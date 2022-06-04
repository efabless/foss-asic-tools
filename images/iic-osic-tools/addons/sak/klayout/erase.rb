# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# This script finds origin of the user_project_wrapper and returns if they are equivalent
#
# To Run the script:
#           klayout -rd file1=<file1> -rd file2=<file2> -z -r layer_check.rb


# ----------------------------------------------------------------
# A boolean processor class

class BoolProcessor

    def initialize(layout, cell)
  
      @layout = layout
      @cell = cell
  
      @proc = RBA::ShapeProcessor.new
  
      @temp_layers = []
  
    end
  
    # Locate a layer for input.
    # The layer is specified by a RBA::LayerInfo object which identifies the layer by 
    # a layer and datatype for example. If the layer does not exist, it is created.
    # This method returns a layer index which can be used as input for other functions.
    def input(lp)
  
      layer_index = nil
  
      # locate the layer if it already exists
      (0..(@layout.layers-1)).each do |i|
        if @layout.is_valid_layer?(i) && @layout.get_info(i).is_equivalent?(lp)
          layer_index = i
          break
        end
      end
  
      # create a new layer if it does not exist
      return layer_index || @layout.insert_layer(lp)
  
    end
  
    # Create a new temporary layer and remember for removal on "cleanup".
    # This method returns a layer index which can be used as input for other functions.
    def tmp
      lp = RBA::LayerInfo.new
      layer_index = @layout.insert_layer(lp)
      @temp_layers.push(layer_index)
      return layer_index
    end
  
    # Assign a layer as output.
    # Change the layer given by the layer index to the output layer specified
    # by a RBA::LayerInfo object. If the layer already exists, it is deleted.
    def output(lp, layer_index)
  
      li = nil
  
      # locate the layer if it already exists
      (0..(@layout.layers-1)).each do |i|
        if @layout.is_valid_layer?(i) && @layout.get_info(i).is_equivalent?(lp)
          li = i
          break
        end
      end
  
      # clear the layer if it already exists
      if li != layer_index
        if li
          @layout.delete_layer(li)
        end
        @layout.set_info(layer_index, lp)
      end
  
      # remove the layer from the list of temporary layers
      new_temp = []
      @temp_layers.each do |i|
        if i != layer_index
          new_temp.push(i)
        end
      end
      @temp_layers = new_temp
  
    end
  
    # Clean up all temporary layers
    def cleanup
      @temp_layers.each do |i|
        @layout.delete_layer(i)
      end
      @temp_layers = []
    end
  
    # Size a layer by the given value (in micron).
    # "input" is the input layer, given by a layer index.
    def size(input, d)
      res = tmp()
      @proc.size(@layout, @cell, input, @cell.shapes(res), to_dbu(d), 
                 2, true, true, true)
      return res
    end    
  
    # Size a layer by the given values anisotropically (in micron)
    # "input" is the input layer, given by a layer index.
    def size2(input, dx, dy)
      res = tmp()
      @proc.size(@layout, @cell, input, @cell.shapes(res), to_dbu(dx), to_dbu(dy), 
                 2, true, true, true)
      return res
    end    
  
    # OR two layers
    # "a" and "b" are the input layers, given by a layer index.
    def or(a, b)
      res = tmp()
      @proc.boolean(@layout, @cell, a, @layout, @cell, b, @cell.shapes(res), 
                    RBA::EdgeProcessor::mode_or, true, true, true)
      return res
    end    
  
    # XOR two layers
    # "a" and "b" are the input layers, given by a layer index.
    def xor(a, b)
      res = tmp()
      @proc.boolean(@layout, @cell, a, @layout, @cell, b, @cell.shapes(res), 
                    RBA::EdgeProcessor::mode_xor, true, true, true)
      return res
    end    
  
    # AND two layers
    # "a" and "b" are the input layers, given by a layer index.
    def and(a, b)
      res = tmp()
      @proc.boolean(@layout, @cell, a, @layout, @cell, b, @cell.shapes(res), 
                    RBA::EdgeProcessor::mode_and, true, true, true)
      return res
    end    
  
    # NOT two layers
    # "a" and "b" are the input layers, given by a layer index.
    def not(a, b)
      res = tmp()
      @proc.boolean(@layout, @cell, a, @layout, @cell, b, @cell.shapes(res), 
                    RBA::EdgeProcessor::mode_anotb, true, true, true)
      return res
    end    
  
    # Convert a value from micron to database units
    # "a" and "b" are the input layers, given by a layer index.
    def to_dbu(micron)
      return (0.5 + micron / @layout.dbu).floor()
    end
  
    # Run a procedure in the context of this object
    def run(&action)
      action.call(self)
      cleanup
    end
  
  private
    @layout
    @cell
    @proc
  
end

layout = RBA::Layout::new
layout.read($file1)

cell_to_change = layout.cell($cell_name)
cell_to_change.shapes(layout.layer(104, 0)).insert(RBA::Box::new(-42880, -1600, 2962500, 3521290))
cell_to_change.shapes(layout.layer(106, 0)).insert(RBA::Box::new(-6980, -37520, 2926600, 3557210))

BoolProcessor.new(layout, layout.cell($cell_name)).run do |p|
  boundry = p.input(RBA::LayerInfo.new(235, 4))
  bbox = p.input(RBA::LayerInfo.new(104, 0))
  bbox2 = p.input(RBA::LayerInfo.new(106, 0))
  tap = p.input(RBA::LayerInfo.new(81, 14))
  met5_pin = p.input(RBA::LayerInfo.new(72, 16))
  met5 = p.input(RBA::LayerInfo.new(72, 20))
  met4_pin = p.input(RBA::LayerInfo.new(71, 16))
  met4 = p.input(RBA::LayerInfo.new(71, 20))
  via = p.input(RBA::LayerInfo.new(71, 44))

  layout.layer_indices.each do |li| 
    # if li != bbox
      if li == met5 || li == met5_pin
        active = p.input(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype))
        gates = p.and(active, bbox)
        p.output(RBA::LayerInfo.new(10, 0), gates)
        active = p.xor(gates, active)
        p.output(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype), active)
      end
    # end
    # if li != bbox2
      if li == met4 || li == met4_pin
        active = p.input(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype))
        gates = p.and(active, bbox2)
        p.output(RBA::LayerInfo.new(10, 0), gates)
        active = p.xor(gates, active)
        p.output(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype), active)
      end
      if li == via
        active = p.input(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype))
        gates = p.and(active, bbox2)
        gates2 = p.and(active, bbox)
        p.output(RBA::LayerInfo.new(10, 0), gates)
        p.output(RBA::LayerInfo.new(11, 0), gates2)
        act = p.xor(gates, active)
        act2 = p.xor(gates2, active)
        actt = p.and(act, act2)
        p.output(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype), actt)
      end
    # end
    if li != boundry && li != tap
      active = p.input(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype))
      gates = p.and(active, boundry)
      p.output(RBA::LayerInfo.new(10, 0), gates)
      active = p.xor(gates, active)
      p.output(RBA::LayerInfo.new(layout.get_info(li).layer, layout.get_info(li).datatype), active)
    end
  end
  layout.delete_layer(layout.layer(10,0))
  layout.delete_layer(layout.layer(11,0))
  layout.delete_layer(layout.layer(104,0))
  layout.delete_layer(layout.layer(106,0))
end

layout.write($output)