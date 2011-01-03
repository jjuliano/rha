  # = rha - A Heartbeat gem for Ruby
  #
  # Homepage::  http://github.com/jjuliano/rha
  # Author::    Joel Bryan Juliano
  # Copyright:: (cc) 2011 Joel Bryan Juliano
  # License::   MIT

  #
  # class RhaDaemon.new( array, str, array)
  #

  #
  # RhaDaemon controls the heartbeat daemon
  #
  class RhaDaemon

    #
    # Increment debugging level. Higher levels are more verbose.
    #
    attr_accessor :debug_level

    #
    # Alternate path to heartbeat. If this is not set, environment path
    # is used.
    #
    attr_accessor :path_to_heartbeat

    #
    # Set heartbeat daemon option; This will set an arbitrary
    # heartbeat option.
    #
    attr_accessor :option

    #
    # Returns a new RhaDaemon Object
    #
    def initialize()
    end

    #
    # Reload heartbeat. This option is functionally identical to
    # sending a running heartbeat process a HUP signal. If the
    # configuration has not changed, then this option is essentially
    # a no-op. If ha.cf  or authkeys has changed, then heartbeat
    # will re-read these files and update its configuration.
    #
    def reload
      tmp = Tempfile.new('tmp')
      command = option_string() + "-r " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end

    #
    # Kill (stop) heartbeat.
    #
    def reload
      tmp = Tempfile.new('tmp')
      command = option_string() + "-k " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end

    #
    # Report heartbeat status.
    #
    def report
      tmp = Tempfile.new('tmp')
      command = option_string() + "-k " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end
    
    #
    # Heartbeat restart exec flag (internal use only).
    #
    def restart
      tmp = Tempfile.new('tmp')
      command = option_string() + "-R " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end

    #
    # Report heartbeat status.
    #
    def status
      tmp = Tempfile.new('tmp')
      command = option_string() + "-s " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end

    #
    # Heartbeat current resource state for restart (internal use only).
    #
    def restart_with_current_resources
      tmp = Tempfile.new('tmp')
      command = option_string() + "-R -C " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end
    
    #
    # Print out heartbeat version.
    #
    def version
      tmp = Tempfile.new('tmp')
      command = option_string() + "-V " + " 2> " + tmp.path
      success = system(command)
      if success
        begin
          while (line = tmp.readline)
            line.chomp
            selected_string = line
          end
        rescue EOFError
          tmp.close
        end
        return selected_string
      else
        tmp.close!
        return success
      end
    end

    private

    def option_string()

      unless @path_to_heartbeat
        ostring = "heartbeat "
      else
        ostring = @path_to_heartbeat + " "
      end

      if @option
        ostring += @option + " "
      end

      if @debug_level
        ostring += "-d " + @debug_level
      end

      return ostring

    end
  end

