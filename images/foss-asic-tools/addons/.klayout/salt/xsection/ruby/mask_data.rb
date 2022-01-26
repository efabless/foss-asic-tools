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

  class MaskData < LayoutData
  
    def initialize(air_polygons, mask_polygons, xs)
      super([], xs)
      @air_polygons = air_polygons
      @mask_polygons = mask_polygons
    end
  
    def upcast(polygons)
      MaskData.new(@air_polygons, polygons, @xs)
    end
  
    def grow(*args)
  
      # parse the arguments
      (xy, z, into, through, on, taper, bias, mode, buried) = parse_grow_etch_args(args, :grow)
  
      # produce the geometry of the new material
      d = produce_geom(xy, z, into, through, on, taper, bias, mode, buried, :grow)
  
      # prepare the result
      res = MaterialData.new(d, @xs)
      
      # consume material
      if into
        into.each do |i|
          i.sub(res)
          @xs.clean(i)
        end
      else
        @xs.air.sub(res)
        # clean the air material
        @xs.clean(@xs.air)
      end
  
      # clean the grown material
      @xs.clean(res)
  
      return res
  
    end
  
    def etch(*args)
  
      # parse the arguments
      (xy, z, into, through, on, taper, bias, mode, buried) = parse_grow_etch_args(args, :etch)
  
      if !into
        raise "'etch' method: requires an 'into' specification"
      end
  
      # prepare the result
      d = produce_geom(xy, z, into, through, on, taper, bias, mode, buried, :etch)
  
      # produce the geometry of the etched material
      res = MaterialData.new(d, @xs)
      
      # consume material and add to air
      into.each do |i|
        j = LayoutData::new(i.data, @xs)
        i.sub(res)
        # clean the remaining material
        @xs.clean(i)
        j.sub(i)
        @xs.air.add(j)
      end
  
      # clean the air material
      @xs.clean(@xs.air)
  
    end
    
    def parse_grow_etch_args(args, method)
  
      xy = nil
      z = nil
      into = nil
      through = nil
      on = nil
      taper = nil
      bias = nil
      buried = nil
      mode = :square
  
      args.each do |a|
        if a.kind_of?(Hash)
          a.each_pair do |k,v|
            if k == :into
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
            elsif k == :on
              if !v.kind_of?(Array)
                on = [v]
              else
                on = v
              end
              on.each do |i|
                if !i.kind_of?(MaterialData) 
                  raise "'#{method}' method: 'on' expects a material parameter or an array of such"
                end
              end
            elsif k == :through
              if !v.kind_of?(Array)
                through = [v]
              else
                through = v
              end
              through.each do |i|
                if !i.kind_of?(MaterialData) 
                  raise "'#{method}' method: 'through' expects a material parameter or an array of such"
                end
              end
            elsif k == :mode
              mode = v
              if v != :round && v != :square && v != :octagon
                raise "'#{method}' method: 'mode' expects ':round', ':square' or ':octagon'"
              end
            elsif k == :buried
              buried = v.to_f
            elsif k == :taper
              taper = v.to_f
            elsif k == :bias
              bias = v.to_f
            else
              raise "'#{method}' method: undefined parameter key '#{k}'"
            end
          end
        elsif !z
          z = a.to_f
        elsif !xy
          xy = a.to_f
        else
          raise "Too many arguments for '#{method}' method"
        end
      end
  
      if !z
        raise "Too few arguments for '#{method}' method"
      end
  
      if on && (through || into)
        raise "'on' option cannot be combined with 'into' or 'through' option"
      end
  
      [xy || 0.0, z, into, through, on, taper, bias, mode, buried]
  
    end
  
    def produce_geom(xy, z, into, through, on, taper, bias, mode, buried, method)
  
      dbias = @xs.delta_dbu
      
      prebias = 0.0
      if xy < 0.0
        xy = -xy
        prebias += xy
      end
  
      if taper
        d = z * Math.tan(Math::PI / 180.0 * taper)
        prebias += d - xy
        xy = d
      end
  
      # determine the "into" material by joining the data of all "into" specs
      # or taking "air" if required.
      if into
        if into.length == 1
          into_data = into[0].data
        else
          into_data = []
          into.each do |i|
            if into_data.length == 0
              into_data = i.data
            else
              into_data = @ep.safe_boolean_to_polygon(i.data, into_data, RBA::EdgeProcessor::mode_or, true, true)
            end
          end
        end
      else
        into_data = @xs.air.data
      end
  
      # determine the "through" material by joining the data of all "through" specs
      if through
        if through.length == 1
          through_data = through[0].data
        else
          through_data = []
          through.each do |i|
            if through_data.length == 0
              through_data = i.data
            else
              through_data = @ep.safe_boolean_to_polygon(i.data, through_data, RBA::EdgeProcessor::mode_or, true, true)
            end
          end
        end
      end
  
      # determine the "on" material by joining the data of all "on" specs
      if on
        if on.length == 1
          on_data = on[0].data
        else
          on_data = []
          on.each do |i|
            if on_data.length == 0
              on_data = i.data
            else
              on_data = @ep.safe_boolean_to_polygon(i.data, on_data, RBA::EdgeProcessor::mode_or, true, true)
            end
          end
        end
      end
  
      bi = ((bias || 0.0) / @xs.dbu + 0.5).floor.to_i
      if bi != 0
        # for backward compatibility the bias is inverse
        mp = @ep.size_to_polygon(@mask_polygons, -bi, 0, 2, true, true)
      else
        mp = @mask_polygons
      end
      
      pi = (prebias / @xs.dbu + 0.5).floor.to_i
      xyi = (xy / @xs.dbu + 0.5).floor.to_i
      zi = (z / @xs.dbu + 0.5).floor.to_i
  
      # in the "into", "through" and "on" case determine the interface region between self and into
      enabled_by = nil
      if into || through || on
        if on
          enabled_by = on_data
        elsif through
          enabled_by = through_data
        else
          enabled_by = into_data
        end
      end
  
      # compute the surface edges in me
      me = compute_surface_edges(mp, enabled_by)
  
      if taper 
      
        kpl = []
        kpl << RBA::Point::new(0, -zi)
        kpl << RBA::Point::new(-xyi, 0)
        kpl << RBA::Point::new(0, zi)

      elsif xyi <= 0 || mode == :square
  
        kpl = []
        kpl << RBA::Point::new(-xyi, -zi)
        kpl << RBA::Point::new(-xyi, zi)
        
      elsif mode == :round || mode == :octagon
  
        # approximate round corners by 64 points (or less when in the order of delta_dbu) for "round" 
        # and 8 for "octagon"
        # nmin is the minimum number of points required to achieve a resolution of delta_dbu for
        # the circle.
        if mode == :round
          nmin = (Math::PI * Math::sqrt([xyi, zi].max.to_f / @xs.delta_dbu.to_f) + 0.9).to_i
          n = [ 64, [ nmin, 8 ].max ].min
        else
          n = 8
        end
        nhalf = (n + 1) / 2
        da = Math::PI / nhalf
        rf = 1.0 / Math::cos(da * 0.5)

        # produce a semi-circle for the left half        
        kpl = []
        kpl << RBA::Point::from_dpoint(RBA::DPoint::new(0, -zi))
        nhalf.times do |i|
          p = RBA::Point::from_dpoint(RBA::DPoint::new(-xyi * rf * Math::sin(da * (i + 0.5)), -zi * rf * Math::cos(da * (i + 0.5))))
          kpl << p
        end
        
      else
        return []
      end
      
      kpl = kpl.collect { |p| p }
      kpl += kpl.collect { |p| RBA::Point::new(-p.x, -p.y) }

      d = MaskData.compute_convolved_edges(me, kpl, pi)

      if (buried || 0.0).abs > 1e-6
        t = RBA::Trans::new(RBA::Point::new(0, -(buried / @xs.dbu + 0.5).floor.to_i))
        d.transform(t)
      end
  
      if through
        d -= RBA::Region::new(through_data)
      end
  
      d &= RBA::Region::new(into_data)
      
      poly = []
      d.each { |p| poly << p }
      return poly
  
    end

    # Computes the convolution of the edge sequence with the kernel 
    # (an array of points). After the convolution, a horizontal negative
    # bias (pi, a positive value) is applied. This allows implementation
    # of "negative" kernels. "valley" or "hill" edge combinations receive a special
    # treatment to avoid merging kernels.
    def self.compute_convolved_edges(me, kernel_pts, pi)
    
      ess = MaskData.stitch_edges(me)
      
      d = RBA::Region::new
      ess.each do |es|
        d += MaskData.compute_convolved_edges_from_sequence(es, kernel_pts, pi)
      end
      
      d
    
    end
    
    # Computes the convolved edge sequence
    def self.compute_convolved_edges_from_sequence(es, kernel_pts, pi)

      dead = MaskData.insert_dead_intervals(es, pi)
      
      kp = RBA::SimplePolygon::new(kernel_pts, true) # "raw mode"
      
      sum = RBA::Region::new
      es.each do |e|
        sum.insert(kp.minkowsky_sum(e, false))
      end
        
      if pi != 0
        sum = sum.sized(-pi, 0, 2)
      else
        sum.merge
      end
      
      MaskData.remove_dead_intervals(sum, dead)
      
    end
    
    # Computes the dead intervals and modifies the edge sequence accordingly
    def self.insert_dead_intervals(me, pi)
    
      if me.size < 3 || pi <= 0
        return []
      end
      
      # order the edges such that we have a left-to-right order
      if me[0].p1.x > me[-1].p2.x
        me_org = me.dup
        me.clear
        me_org.reverse.each do |e|
          e = e.dup
          e.swap_points
          me << e
        end
      end
      
      # keeps valley or hill edge indexes
      vorh = {}
      
      # insert dummy edges for later expansion at valley or hill *points*
      me_org = me.dup
      me.clear
      (me_org.size - 1).times do |i|
        ebefore = me_org[i]
        eafter = me_org[i + 1]
        me << ebefore
        if ebefore.dy * eafter.dy < 0
          # valley or hill point
          vorh[me.size] = true
          me << RBA::Edge::new(ebefore.p2, eafter.p1) # same points :)
        end
      end
      me << me_org[-1]
      
      # identify valley or hill *edges*
      (me.size - 2).times do |i|
        ebefore = me[i]
        e = me[i + 1]
        eafter = me[i + 2]
        if e.dy == 0 && ebefore.dy * eafter.dy < 0
          vorh[i + 1] = true
        end
      end
      
      int = []

      stretch = 2 * pi
      
      s = 0
      me.each_with_index do |e,i|
        sv = RBA::Vector::new(s, 0)
        e.p1 = e.p1 + sv
        e.p2 = e.p2 + sv
        if vorh[i]
          xs = (e.p1.x + e.p2.x) / 2
          s += stretch
          int << [ xs, xs + stretch ]
          e.p2 = e.p2 + RBA::Vector::new(stretch, 0)
        end
      end

      int
    
    end
    
    # Removes the dead intervals
    # This is a special coordinate transformation which removes an 
    # interval [a,b] from x by doing
    #   x = x for x<=(a+b)/2
    #   x = x-(b-a) otherwise
    # This method acts on a region and returns a merged region
    def self.remove_dead_intervals(data, dead)
    
      # shortcut
      if dead.empty?
        return data
      end
      
      pp = []
      data.each do |p|
        pp << p
      end
      
      dead.reverse.each do |int|
        
        xm = (int[0] + int[1]) / 2
        dx = int[1] - int[0]
              
        pp_next = []
        pp.each do |p|
        
          hp = []
          p.each_point_hull do |pt|
            hp << RBA::Point::new(pt.x > xm ? pt.x - dx : pt.x, pt.y)
          end
          
          pn = RBA::Polygon::new(hp, true)
          pp_next << pn
          
          p.holes.times do |h|
            hp = []
            p.each_point_hole(h) do |pt|
              hp << RBA::Point::new(pt.x > xm ? pt.x - dx : pt.x, pt.y)
            end
            pn.insert_hole(hp, true)
          end
      
        end
        
        pp = pp_next
      
      end
      
      ep = RBA::EdgeProcessor::new
      pp_merged = ep.simple_merge_p2p(pp, false, true, 1)
      RBA::Region::new(pp_merged)
      
    end
    
    # Stitches the edge sequence into a sequence of consecutive edges
    # Returns an array of arrays of edges (the latter being 
    # in consecutive order - that is, their end- and start point 
    # is identical)
    def self.stitch_edges(me)
    
      seq = []
      
      p1_to_e = {}
      p2_to_e = {}
      me.each do |e|
        if e.p1 != e.p2
          p1_to_e[e.p1] = e
          p2_to_e[e.p2] = e
        end
      end
      
      me.each do |e|
      
        if !p2_to_e[e.p1]
          # a new start of a sequence
          s = []
          s << e
          while ee = p1_to_e[e.p2]
            p1_to_e[e.p2] = nil
            s << ee
            e = ee
          end
          seq << s
        end
        
      end
      
      seq
    
    end
    
    # computes the surface edges (the interface between air and some material)
    # "enabled_by" is a material object which needs to touch with the surface
    # in order to enable it. "mp" are the verticalized mask polygons (vertical bands
    # where the mask is open)
    def compute_surface_edges(mp, enabled_by)

      # compute the surface edges in me
      if enabled_by

        # pre-size the air polygons to achieve a guaranteed overlap with "enabled_by"
        # (in horizontal direction)
        # ap_sized = air_polygons.sized_x(delta) - enabled_by
        ap_sized = @ep.size_to_polygon(@air_polygons, @xs.delta_dbu, 0, 2, true, true)
        ap_sized = @ep.safe_boolean_to_polygon(ap_sized, enabled_by, RBA::EdgeProcessor::mode_anotb, true, true)

        # when masking by enabled_by, apply an additional vertical sizing to catch vertical deviations
        # (we do this after the masking so we don't alter the vertical dimensions of the etch)
        # me = (edges(mp & ap_sized) & ((mp & enabled_by).sized_y(delta))) - edges(mp)
        ap_masked = @ep.safe_boolean_to_polygon(mp, ap_sized, RBA::EdgeProcessor::mode_and, true, true)
        me = ap_masked.empty? ? RBA::Edges::new : (RBA::Edges::new(ap_masked) - (mp.empty? ? RBA::Edges::new : RBA::Edges::new(mp)))
      
        en_masked = @ep.safe_boolean_to_polygon(mp, enabled_by, RBA::EdgeProcessor::mode_and, true, true)
        me &= RBA::Region::new(en_masked).sized(0, @xs.delta_dbu, 2)
        
      else

        # me = edges(mp & air_polygons) - edges(mp)
        ap_masked = @ep.safe_boolean_to_polygon(mp, @air_polygons, RBA::EdgeProcessor::mode_and, true, true)
        me = ap_masked.empty? ? RBA::Edges::new : (RBA::Edges::new(ap_masked) - (mp.empty? ? RBA::Edges::new : RBA::Edges::new(mp)))

      end
      
      me
      
    end
    
  end
  
end
