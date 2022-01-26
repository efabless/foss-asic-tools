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

# ----------------------------------------------------------------------------

# @brief An enhancement to the Edge processor
# Empty polyon arrays produce errors with boolean_to_polygon because
# RBA does not recognize the empty array as an array of polygons and then there is
# an ambiguity between the edge-input and polygon input variants
# Thus this extension which checks for empty input and performs some default operation:
class RBA::EdgeProcessor
  def safe_boolean_to_polygon(pa, pb, mode, rh, mc)
    if pa.length > 0 && pb.length > 0
      return self.boolean_to_polygon(pa, pb, mode, rh, mc)
    elsif mode == RBA::EdgeProcessor::mode_and
      return []
    elsif mode == RBA::EdgeProcessor::mode_or
      if pa.length > 0
        return pa
      else
        return pb
      end
    elsif mode == RBA::EdgeProcessor::mode_xor
      if pa.length > 0
        return pa
      else
        return pb
      end
    elsif mode == RBA::EdgeProcessor::mode_anotb
      return pa
    elsif mode == RBA::EdgeProcessor::mode_bnota
      return pb
    else
      return []
    end
  end
end

module XS

  class LayoutData
  
    def initialize(polygons, xs)
      @polygons = polygons
      @ep = RBA::EdgeProcessor.new
      @xs = xs
    end
  
    def upcast(polygons)
      LayoutData.new(polygons, @xs)
    end
  
    def load(layout, cell, box, layer_spec)
    
      box_in_layout = box * (@xs.dbu / layout.dbu)
      scale = RBA::ICplxTrans::new(layout.dbu / @xs.dbu)
  
      ls = XS::string_to_layerinfo(layer_spec)
  
      # look up the layer
      layer_index = nil
      layout.layer_indices.each do |li|
        if (layout.get_info(li).is_equivalent?(ls))
          layer_index = li
        end
      end
  
      # collect polygons from the specified layer
      if (layer_index)
  
        shape_iter = layout.begin_shapes_touching(cell, layer_index, box_in_layout)
        while !shape_iter.at_end
  
          shape = shape_iter.shape
          if shape.is_polygon? || shape.is_path? || shape.is_box?
            @polygons.push(shape.polygon.transformed(scale * shape_iter.trans))
          end
  
          shape_iter.next
  
        end
  
      end
  
    end
    
    def data
      @polygons
    end
  
    def data=(polygons)
      @polygons = polygons
    end
  
    def sized(*args)
      if args.length == 1
        upcast(@ep.size_to_polygon(@polygons, (args[0] / @xs.dbu + 0.5).floor.to_i, 2, true, true))
      elsif args.length == 2
        upcast(@ep.size_to_polygon(@polygons, (args[0] / @xs.dbu + 0.5).floor.to_i, (args[1] / @xs.dbu + 0.5).floor.to_i, 2, true, true))
      else
        raise("sized method expects on or two arguments")
      end
    end
  
    def size(*args)
      if args.length == 1
        @polygons = @ep.size_to_polygon(@polygons, (args[0] / @xs.dbu + 0.5).floor.to_i, 2, true, true)
      elsif args.length == 2
        @polygons = @ep.size_to_polygon(@polygons, (args[0] / @xs.dbu + 0.5).floor.to_i, (args[1] / @xs.dbu + 0.5).floor.to_i, 2, true, true)
      else
        raise("size method expects one to three arguments")
      end
    end
  
    def clean(d)
      # NOTE: doing cleaning for x and y direction separately ensures there are no
      # particular snapping effects for any-angled edges. The computation of the size
      # values ensures that di + di1 + di2 = 0
      di = (d / @xs.dbu + 0.5).floor.to_i
      di1 = -(di / 2)
      di2 = -di - di1
      @polygons = @ep.size_to_polygon(@polygons, di1, 0, 0, true, true)
      @polygons = @ep.size_to_polygon(@polygons, di, 0, 0, true, true)
      @polygons = @ep.size_to_polygon(@polygons, di2, 0, 0, true, true)
      @polygons = @ep.size_to_polygon(@polygons, 0, di1, 0, true, true)
      @polygons = @ep.size_to_polygon(@polygons, 0, di, 0, true, true)
      @polygons = @ep.size_to_polygon(@polygons, 0, di2, 0, true, true)
    end
      
    def invert
      @polygons = @ep.safe_boolean_to_polygon(@polygons, [RBA::Polygon.new(@xs.background)], RBA::EdgeProcessor::mode_xor, true, true)
    end
  
    def inverted
      upcast(@ep.safe_boolean_to_polygon(@polygons, [RBA::Polygon.new(@xs.background)], RBA::EdgeProcessor::mode_xor, true, true))
    end
  
    def or(other)
      raise "'or': argument is not a layer" unless other.kind_of?(LayoutData)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_or, true, true))
    end
  
    def orp(other)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_or, true, true))
    end
  
    def and(other)
      raise "'and': argument is not a layer" unless other.kind_of?(LayoutData)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_and, true, true))
    end
  
    def andp(other)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_and, true, true))
    end
  
    def xor(other)
      raise "'xor': argument is not a layer" unless other.kind_of?(LayoutData)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_xor, true, true))
    end
  
    def xorp(other)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_xor, true, true))
    end
  
    def not(other)
      raise "'not': argument is not a layer" unless other.kind_of?(LayoutData)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_anotb, true, true))
    end
  
    def notp(other)
      upcast(@ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_anotb, true, true))
    end
  
    def add(other)
      raise "'add': argument is not a layer" unless other.kind_of?(LayoutData)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_or, true, true)
    end
  
    def addp(other)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_or, true, true)
    end
  
    def sub(other)
      raise "'sub': argument is not a layer" unless other.kind_of?(LayoutData)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_anotb, true, true)
    end
  
    def subp(other)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_anotb, true, true)
    end
  
    def mask(other)
      raise "'mask': argument is not a layer" unless other.kind_of?(LayoutData)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other.data, RBA::EdgeProcessor::mode_and, true, true)
    end
  
    def maskp(other)
      @polygons = @ep.safe_boolean_to_polygon(@polygons, other, RBA::EdgeProcessor::mode_and, true, true)
    end
  
    def transform(t)
      @polygons = @polygons.collect { |p| p.transformed(t) }
    end
  
  end
  
end