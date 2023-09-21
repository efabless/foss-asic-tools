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

  # ----------------------------------------------------------------
  # A special action to implement the cross section MRU menu item
  
  class XSectionMRUAction < RBA::Action
  
    def initialize(&action)
      @action = action
    end
  
    def triggered 
      @action.call(self) 
    end
  
    def script=(s)
      @script = s
      self.visible = (s != nil)
      if s
        self.title = File.basename(s) 
      end
    end
  
    def script
      @script
    end
  
  private
    @action
    @script
  end
  
  # ----------------------------------------------------------------
  # The cross section script environment
  
  class XSectionScriptEnvironment
  
    def initialize
  
      app = RBA::Application.instance
      mw = app.main_window
      mw || return
  
      @action = RBA::Action.new
      @action.title = "Run Script"
      @action.on_triggered do
  
        begin
        
          view = RBA::Application.instance.main_window.current_view
          if !view
            raise "No view open for running the xsection script on"
          end
            
          fn = RBA::FileDialog::get_open_file_name("Select Script", "", "XSection Scripts (*.xs);;All Files (*)");
          if fn.has_value?
            begin
              run_script(fn.value)
            ensure
              make_mru(fn.value)
            end
          end

        rescue => ex
          RBA::MessageBox.critical("Error", ex.to_s, RBA::MessageBox.b_ok)
        end
  
      end
  
      @active_tech = RBA::Action.new
      @active_tech.title = "XSection: Active Technolgy"
      @active_tech.shortcut = "Ctrl+Shift+X"
      @active_tech.on_triggered do
      
        begin
  
          view = RBA::Application.instance.main_window.current_view
          if !view
            raise "No view open for running the xsection script on"
          end
          tech_name = view.active_cellview.technology
          tech = RBA::Technology.technology_by_name(tech_name)
          xsect_dir = File.join(tech.base_path, 'xsect')
          unless File.exist?(xsect_dir)
            raise "No Xsection directory present for #{tech_name}"
          end
          xsect_fileglob = File.join(xsect_dir, '*.xs')
    
          files = []
          Dir.glob(xsect_fileglob) do |xs_file|
            files << xs_file.to_s
          end
          if files.length < 1
            raise "No XSection file found for technology #{tech_name}."
          elsif files.length > 1
            raise "More than one .xs file found for technology #{tech_name}. Found #{files.length}"
          else
            xs_file = files[0]
            run_script(xs_file)
          end

        rescue => ex
          RBA::MessageBox.critical("Error", ex.to_s, RBA::MessageBox.b_ok)
        end
  
      end
  
      menu = mw.menu
      
      # remove any existing menu
      menu.delete_item("tools_menu.xsection_script_submenu")
      
      menu.insert_separator("tools_menu.end", "xsection_script_group")
      menu.insert_menu("tools_menu.end", "xsection_script_submenu", "XSection #{XS::VERSION} Scripts")
      menu.insert_item("tools_menu.xsection_script_submenu.end", "xsection_script_load", @action)
      menu.insert_item("tools_menu.xsection_script_submenu.end", "xsection_for_technology", @active_tech)
      menu.insert_separator("tools_menu.xsection_script_submenu.end.end", "xsection_script_mru_group")
  
      @mru_actions = []
      (1..10).each do |i|
  
        a = XSectionMRUAction.new do |action|
          begin
            run_script(action.script)
          rescue => ex
            RBA::MessageBox.critical("Error", ex.to_s, RBA::MessageBox.b_ok)
          ensure
            make_mru(action.script)
          end
        end
  
        @mru_actions.push(a)
        menu.insert_item("tools_menu.xsection_script_submenu.end", "xsection_script_mru#{i}", a)
  
        a.script = nil
  
      end
  
      # try to save the MRU list to $HOME/.klayout-processing-mru
      i = 0
      home = ENV["HOME"]
      if $xsection_scripts
        $xsection_scripts.split(":").each_with_index do |script,i|
          if i < @mru_actions.size
            @mru_actions[i].script = script
          end
        end
      elsif home
        fn = File.join(home, ".klayout-xsection")
        begin
          File.open(fn, "r") do |file|
            file.readlines.each do |line|
              if line =~ /<mru>(.*)<\/mru>/
                if i < @mru_actions.size
                  @mru_actions[i].script = $1
                end
                i += 1
              end
            end
          end
        rescue
        end
  
      end
  
    end
  
    def run_script(fn, p1 = nil, p2 = nil, batch = false)
  
      begin
      
        pts = []

        app = RBA::Application.instance
        view = app.main_window.current_view
        if !view
          raise("No view open for creating the cross section from")
        end
    
        cv = view.cellview(view.active_cellview_index)
        if ! cv.is_valid?
          raise("The selected layout is not valid")
        end
          
        if p1 && p2
        
          # take the given line
          pts << [ p1, p2 ]
          
        else
  
          # if there is at least one ruler with category "XS", use
          # rulers from there
          any_xs = nil
          xs_rulers = []
          view.each_annotation do |a|
            is_xs = (a.category == "XS")
            if is_xs
              xs_rulers << a
              any_xs = true
            end
          end

          if ! any_xs          
            view.each_annotation do |a|
              xs_rulers << a
            end
          end
          
          pts = xs_rulers.collect { |a| [ a.p1, a.p2 ] }
          if pts.size == 0
            raise("No (valid) ruler present for the cross section line")
          end
  
        end
  
        new_view = nil
        
        pts.each do |pp|
          new_view = XSectionGenerator.new(fn, batch).run(*pp, cv)
        end
        
        new_view
  
      rescue => ex
        
        # Extract the error location in the script and add to the error message
        # The backtrace line is something like "(filename).xs:(line):in ...".

        location = "(not found)"
        ex.backtrace.each do |bt|
          if !bt.to_s.start_with?(File.dirname(__FILE__))
            location = bt.sub(/:in .*$/, "")
            break
          end
        end
        
        raise ex.to_s + "\nin " + location
  
      end
  
    end
  
    def make_mru(script)
  
      # don't maintain MRU if an external list is provided
      if $xsection_scripts
        return
      end
  
      scripts = [script]
      @mru_actions.each do |a|
        if a.script != script
          scripts.push(a.script)
        end
      end
  
      while scripts.size < @mru_actions.size
        scripts.push(nil)
      end
  
      (0..(@mru_actions.size-1)).each do |i|
        @mru_actions[i].script = scripts[i]
      end
  
      # try to save the MRU list to $HOME/.klayout-xsection
      home = ENV["HOME"]
      if home
        fn = File.join(home, ".klayout-xsection")
        File.open(fn, "w") do |file|
          file.puts("<xsection>");
          @mru_actions.each do |a|
            if a.script
              file.puts("<mru>#{a.script}</mru>")
            end
          end
          file.puts("</xsection>");
        end
  
      end
  
    end
  
  end
  
end