#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

module XS

  def self.string_to_layerinfo(layer_spec)
  
    # convert the layer specification into a LayerInfo structure
    # format: "l", "l/d", "n(l/d)" or "n".
    ls = nil
    if (layer_spec =~ /^(\d+)$/)
      ls = RBA::LayerInfo.new($1.to_i, 0)
    elsif (layer_spec =~ /^(\d+)\/(\d+)$/)
      ls = RBA::LayerInfo.new($1.to_i, $2.to_i)
    elsif (layer_spec =~ /^(.*)\s*\((\d+)\/(\d+)\)$/)
      ls = RBA::LayerInfo.new($2.to_i, $3.to_i, $1)
    else
      ls = RBA::LayerInfo.new(layer_spec)
    end
  
    return ls
  
  end
  
  
  # The main class that creates a cross-section file
  class XSectionGenerator
  
    # Constructor
    def initialize(file_path, batch)
  
      @file_path = file_path
      @lyp_file = nil
      @ep = RBA::EdgeProcessor.new
      @flipped = false
      @dbu = 0.001
      @batch = batch
  
    end
  
    def layer(layer_spec)
      ld = LayoutData.new([], self)
      ld.load(@layout, @cell, @line.bbox.enlarge(RBA::Point.new(@extend, @extend)), layer_spec)
      return ld
    end
  
    # TODO: for debugging only
    def output_raw(layer_spec, d)
  
      ls = string_to_layerinfo(layer_spec)
      li = @target_layout.layer(ls)
      shapes = @target_layout.cell(@target_cell).shapes(li)
      shapes.insert(d)
  
    end
    
    def snapshot(name = nil)
    
      if @batch
        return
      end
    
      name && @target_view.title = name
      source_cell = @target_layout.cell(@target_cell)
      
      finish_output_view
      prepare_output_view
      
      # copy what we had so far
      @target_layout.cell(@target_cell).copy_tree(source_cell)
    
    end
  
    def pause(name = nil)
    
      if @batch
        return
      end
    
      name && @target_view.title = name
      finish_output_view
            
      v = RBA::MessageBox::question("XSection snapshot", "New snapshot taken. Continue?", RBA::MessageBox::Yes + RBA::MessageBox::No)
      if v != RBA::MessageBox::Yes
        raise "XSection script processing stopped."
      end

    end
  
    def output(layer_spec, layer_data)
    
      # allows using the output spec on not-yet-defined layers
      if !layer_data
        return
      end
  
      raise("'output' method: second parameter must be a geometry object") unless layer_data.kind_of?(LayoutData)
  
      ls = XS.string_to_layerinfo(layer_spec)
      li = @target_layout.layer(ls)
      shapes = @target_layout.cell(@target_cell).shapes(li)
      shapes.clear
  
      # confine the shapes to the region of interest
      @ep.boolean_to_polygon([ RBA::Polygon.new(@roi) ], layer_data.data, RBA::EdgeProcessor::mode_and, true, true).each do |polygon|
        shapes.insert(polygon)
      end
  
    end
  
    def flip
      @air, @air_below = @air_below, @air
      @flipped = !@flipped
    end
  
    def all
      return xpoints_to_mask([[ -@extend, 1 ], [ @line.length + @extend, -1 ]])
    end
  
    def diffuse(*args)
      all.grow(*args)
    end
  
    def deposit(*args)
      all.grow(*args)
    end
  
    def grow(*args)
      all.grow(*args)
    end
  
    def etch(*args)
      all.etch(*args)
    end
  
    def mask(layer_data)
  
      crossing_points = []
  
      layer_data.data.each do |polygon|
  
        polygon.each_edge do |edge_dbu|
        
          if @line.crossed_by?(edge_dbu) && (@line.side_of(edge_dbu.p1) > 0 || @line.side_of(edge_dbu.p2) > 0)
  
            # compute the crossing point of "edge" and "line" in database units
            # confine the point to the length of the line
            z = (edge_dbu.dx.to_f * (edge_dbu.p1.y.to_f - @line.p1.y.to_f) - edge_dbu.dy.to_f * (edge_dbu.p1.x.to_f - @line.p1.x.to_f)) /
                (edge_dbu.dx.to_f * (@line.p2.y.to_f - @line.p1.y.to_f) - edge_dbu.dy.to_f * (@line.p2.x.to_f - @line.p1.x.to_f))
            z = (z * @line.length + 0.5).floor
            if z < -@extend
              z = -@extend
            elsif z > @line.length + @extend
              z = @line.length + @extend
            end
  
            s = ((edge_dbu.dy * @line.dx - edge_dbu.dx * @line.dy) <=> 0)
  
            # store that along with the orientation of the edge (+1: "enter geometry", -1: "leave geometry")
            crossing_points.push([ z, s ])
  
          end
  
        end
  
      end
  
      # compress the crossing points by collecting all of those which cut the measure line at the
      # same position
      compressed_crossing_points = []
      last_z = nil
      sum_s = 0
      crossing_points.sort.each do |i|
  
        z = i[0]
        s = i[1]
  
        if z == last_z
          sum_s += s
        else
          if sum_s != 0
            compressed_crossing_points.push([ last_z, sum_s ])
          end
          last_z = z
          sum_s = s
        end
  
      end
  
      if last_z && sum_s != 0
        compressed_crossing_points.push([ last_z, sum_s ])
      end
  
      # create the final intervals by selecting those crossing points which
      # denote an entry or leave point into or out of drawn geometry. This
      # basically does a merge of all drawn shapes.
  
      return xpoints_to_mask(compressed_crossing_points)
  
    end
  
    def clean(mat)
      mat.clean(self.delta)
    end
  
    def planarize(*args)
  
      downto = nil
      less = nil
      to = nil
      into = nil
  
      args.each do |a|
        if a.kind_of?(Hash)
          a.each_pair do |k,v|
            if k == :downto
              if !v.kind_of?(Array)
                downto = [v]
              else
                downto = v
              end
              downto.each do |i|
                if !i.kind_of?(MaterialData) 
                  raise "'#{method}' method: 'into' expects a material parameter or an array of such"
                end
              end
            elsif k == :into
              if !v.kind_of?(Array)
                into = [v]
              else
                into = v
              end
              into.each do |i|
                if !i.kind_of?(MaterialData) 
                  raise "'#{method}' method: 'into' expects a material parameter or an array of such"
                end
              end
            elsif k == :less
              less = (0.5 + v.to_f / self.dbu).floor.to_i
            elsif k == :to
              to = (0.5 + v.to_f / self.dbu).floor.to_i
            end
          end
        else
          raise "'planarize' expects named arguments 'less', 'downto', 'into' or 'to'"
        end
      end
  
      if !into
        raise "'planarize' requires an 'into' argument"
      end
  
      if downto
  
        downto_data = nil
        if downto.length == 1
          downto_data = downto[0].data
        else
          downto.each do |i|
            if downto_data.length == 0
              downto_data = i.data
            else
              downto_data = @ep.safe_boolean_to_polygon(i.data, downto_data, RBA::EdgeProcessor::mode_or, true, true)
            end
          end
        end
  
        downto_data = @ep.safe_boolean_to_polygon([ RBA::Polygon.new(@roi) ], downto_data, RBA::EdgeProcessor::mode_and, true, true)
  
        # determine upper bound of material
        if downto_data
            downto_data.each do |p|
            yt = p.bbox.top
            yb = p.bbox.bottom
            to ||= yt
            if !@flipped
              to = [ to, yt, yb ].max
            else
              to = [ to, yt, yb ].min
            end
          end
        end
  
      elsif into && !to
  
        # determine upper bound of our material
        into.each do |i|
        
          into_data = @ep.safe_boolean_to_polygon([ RBA::Polygon.new(@roi) ], i.data, RBA::EdgeProcessor::mode_and, true, true)
          
          into_data.each do |p|
            yt = p.bbox.top
            yb = p.bbox.bottom
            to ||= yt
            if !@flipped
              to = [ to, yt, yb ].max
            else
              to = [ to, yt, yb ].min
            end
          end
          
        end
  
      end
  
      if to
      
        less ||= 0
        
        if @flipped
          removed_box = RBA::Box.new(-@extend, -self.depth_dbu - self.below_dbu, @line.length + @extend, to + less)
        else
          removed_box = RBA::Box.new(-@extend, to - less, @line.length + @extend, self.height_dbu)
        end
        
        rem = LayoutData::new([], self)
        into.each do |i|
          rem.add(i.andp([RBA::Polygon.new(removed_box)]))
          i.subp([RBA::Polygon.new(removed_box)])
        end
        
        self.air.add(rem)
        clean(self.air)
       
      end
  
    end
  
    def xpoints_to_mask(iv)
  
      s = 0
      last_s = 0
      p1 = 0
      p2 = 0
  
      mask_polygons = []
      iv.each do |i|
  
        z = i[0]
        s += i[1]
  
        if s > 0 && last_s <= 0
          p1 = z
        elsif s <= 0 && last_s > 0
          p2 = z
          mask_polygons.push(RBA::Polygon.new(RBA::Box.new(p1, -@depth - @below, p2, @height)))
        end
  
        last_s = s
  
      end
  
      return MaskData.new(@air.data, mask_polygons, self)
  
    end
  
    def delta(x = nil)
      if x
        @delta = (x / @dbu + 0.5).floor.to_i
      end
      @delta * @dbu
    end
  
    def delta_dbu
      @delta
    end
  
    def height(x)
      @height = (x / @dbu + 0.5).floor.to_i
      update_basic_regions
    end
  
    def height_dbu
      @height
    end
  
    def depth(x)
      @depth = (x / @dbu + 0.5).floor.to_i
      update_basic_regions
    end
  
    def depth_dbu
      @depth
    end
  
    def below(x)
      @below = (x / @dbu + 0.5).floor.to_i
      update_basic_regions
    end
  
    def below_dbu
      @below
    end
  
    def extend(x)
      @extend = (x / @dbu + 0.5).floor.to_i
      update_basic_regions
    end
  
    def extend_dbu
      @extend
    end
  
    def width_dbu
      @line.length
    end
  
    def background
      x1 = @line.p1.x
      y1 = @line.p1.y
      x2 = @line.p2.x
      y2 = @line.p2.y
      if x2 < x1
        (x1, x2) = [x2, x1]
      end
      if y2 < y1
        (y1, y2) = [y2, y1]
      end
      x1 -= @extend
      y1 -= @extend
      x2 += @extend
      y2 += @extend
      RBA::Box.new(RBA::Point.new(x1 - @delta * 5, y1 - @delta * 5), RBA::Point.new(x2 + @delta * 5, y2 + @delta * 5))
    end
  
    def air
      @air
    end
  
    def bulk
      MaterialData.new(@bulk.data, self)
    end
  
    def dbu(u = nil)
    
      if !u
        return @dbu
      end
    
      if u < 1.0e-10
        raise "Invalid DBU value (must >0)"
      end
      
      scale = @dbu / u
      @dbu = u
      
      # rescale all the parameters except delta (which is probably the reason why 
      # the DBU will be changed)
      
      @extend = (@extend * scale + 0.5).floor.to_i
      @height = (@height * scale + 0.5).floor.to_i
      @depth = (@depth * scale + 0.5).floor.to_i
      @below = (@below * scale + 0.5).floor.to_i
      
      @line = @line * scale
      @target_layout.dbu = @dbu

      update_basic_regions
      
    end
  
    def layers_file(lyp_file)
      # read the layers file relative to the script unless the absolute path is given
      lyp_file = File.absolute_path(lyp_file, File.dirname(@file_path))
      @lyp_file = lyp_file
    end
  
    # The basic generation method
    def run(p1, p2, cv)
  
      @target_view = nil
  
      setup(p1, p2, cv)
  
      update_basic_regions
  
      text = nil
      File.open(@file_path) do |file|
        text = file.read
      end
      if !text
        raise("Error reading file #{@file_path}")
      end
  
      eval(text, binding, @file_path)

      finish_output_view
        
      @target_view
  
    end
  
    def setup(p1, p2, cv)
  
      # locate the layout and the (single) ruler
      @cv = cv
      @layout = cv.layout
      @source_dbu = @dbu = @layout.dbu
      @cell = cv.cell_index
  
      # get the start and end points in database units and micron
      p1_dbu = RBA::Point::from_dpoint(p1 * (1.0 / @dbu))
      p2_dbu = RBA::Point::from_dpoint(p2 * (1.0 / @dbu))
      @line = RBA::Edge.new(p1_dbu, p2_dbu)
  
      # create a new layout for the output
      prepare_output_view
  
      # initialize height and depth
      @extend = (2.0 / @dbu + 0.5).floor.to_i
      @delta = 10
      @height = (2.0 / @dbu + 0.5).floor.to_i
      @depth = (2.0 / @dbu + 0.5).floor.to_i
      @below = (2.0 / @dbu + 0.5).floor.to_i
  
      return true
  
    end
  
  private
  
    def update_basic_regions
      @area = RBA::Box.new(-@extend, -@depth - @below, @line.length + @extend, @height)
      @air = MaterialData.new([RBA::Polygon.new(RBA::Box.new(-@extend, 0, @line.length + @extend, @height))], self)
      @air_below = MaterialData.new([RBA::Polygon.new(RBA::Box.new(-@extend, -@depth - @below, @line.length + @extend, -@depth))], self)
      @bulk = MaterialData.new([RBA::Polygon.new(RBA::Box.new(-@extend, -@depth, @line.length + @extend, 0))], self)
      @roi = RBA::Box.new(0, -@depth - @below, @line.length, @height)
    end
    
    def prepare_output_view

      app = RBA::Application.instance
  
      cv = app.main_window.create_layout(1)
      cell = cv.layout.add_cell("XSECTION")

      @target_view = app.main_window.current_view
      @target_view.select_cell(cell, 0)
      @target_layout = cv.layout
      @target_layout.dbu = @dbu
      @target_cell = cell

    end
  
    def finish_output_view
    
      # Show all layers which were created in between
      RBA::Application.instance.main_window.cm_lv_add_missing 
      if @lyp_file
        @target_view.load_layer_props(@lyp_file)
      end
      @target_view.zoom_fit
  
    end

  end

end
