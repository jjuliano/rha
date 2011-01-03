  # = rha - A Heartbeat gem for Ruby
  #
  # Homepage::  http://github.com/jjuliano/rha
  # Author::    Joel Bryan Juliano
  # Copyright:: (cc) 2011 Joel Bryan Juliano
  # License::   MIT

  #
  # class RhaResources.new( array, str, array)
  #

  #
  # RhaResources is the built-in resource manager configuration for heartbeat.
  #
  class RhaResources

    #
    # The preferred_node is the node that this resource group would prefer to be run on.
    # This usually takes the form of the hostname, or running 'uname -n'.
    #
    attr_accessor :preferred_node
    
    #
    # The resource_name is usually the IP address of the preferred_node cluster.
    #
    attr_accessor :resource_name
    
    #
    # The script_name is the services that will be started by heartbeat.
    # It looks in the /etc/init.d for the matched services (ie. nginx, httpd, smb)
    # Services/Daemons on this line are separated by a single space.
    #
    # Actions can be invoke via script_name::action (ie. httpd::restart )
    #
    attr_accessor :script_name

    #
    # Returns a new RhaConfig Object
    #
    def initialize()
    end

    #
    # Compile the RhaConfig configuration
    #
    def config
      haresources = option_string()
      return haresources
    end

    private

    def option_string()
      ostring = "#{@preferred_node} #{@resource_name} "

      if @script_name
        ostring += @script_name.to_s
      end
      
      return ostring
    end
  end

