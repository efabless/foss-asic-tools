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

  # MaterialData is pretty identical to LayoutData, but it represents
  # a cross section rather than mask data in xy plane
  class MaterialData < LayoutData
  
    def initialize(polygons, xs)
      super(polygons, xs)
    end
  
    def upcast(polygons)
      MaterialData.new(polygons, @xs)
    end
  
    def discard
      @xs.air.add(self)
      self
    end
  
    def keep
      @xs.air.sub(self)
      self
    end
  
  end

end
