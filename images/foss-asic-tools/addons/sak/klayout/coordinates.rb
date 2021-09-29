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
#           klayout -rd file1=<file1> -rd file2=<file2> -z -r coordinates.rb

layout = RBA::Layout.new
lmap = layout.read($file1)

origin = Struct.new(:instx, :insty, :instrot)
origins = Array.new

lmap2 = layout.read($file2)

ind = 0

layout.each_cell do |c|
    # change and the instances
    if c.name == "user_project_wrapper"
        ind = Integer(c.cell_index)
    end
end

layout.each_cell do |c|
    c.each_inst do |inst|
        if inst.cell_index.equal? ind
            iindex = inst.cell_index
            name = layout.cell_name(iindex)
            itrans = inst.trans.to_s.gsub(",", "\s").split("\s")
            instrot = itrans[0]
            instx = (itrans[1].to_i * layout.dbu).round(6)
            insty = (itrans[2].to_i * layout.dbu).round(6)
            origin.new(instx, insty, instrot)
            origins.append(origin)
            puts("#{name},#{instx},#{insty},#{instrot}")
        end
    end
end

if origins.uniq.size > 1
    puts "They are not equivalent"
else
    puts "They are equivalent"
end
