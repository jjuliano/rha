  # = rha - A Heartbeat gem for Ruby
  #
  # Homepage::  http://github.com/jjuliano/rha
  # Author::    Joel Bryan Juliano
  # Copyright:: (cc) 2011-2015 Joel Bryan Juliano
  # License::   GNU LGPLv3

  #
  # class RhaAuthkeys.new( array, str, array)
  #

  #
  # RhaAuthkeys are authentication configurations for heartbeat.
  #
  class RhaAuthkeys
    #
    # Returns a new RhaConfig Object
    #
    def initialize()
      @num ||= []
    end

    # 
    # auth num selects the currently active authentication method and secret.
    #
    # num is a numerical identifier, between 1 and 15 inclusive.
    # It must be unique within the file.
    #
    def auth(value)
      @num.push("auth #{value}")
    end

    #
    # MD5 hash method. This method requires a shared secret.
    #
    def add_md5(auth_num, method_num, secret)
      begin
        num_index = @num.index("auth #{auth_num}")
        @num.insert(num_index + 1, method_num.to_s + " md5 " + secret.to_s + "\n")
      rescue
        puts "no such auth num #{auth_num}"
        return false
      end
    end

    #
    # SHA-1 hash method. This method requires a shared secret.
    #
    def add_sha1(auth_num, method_num, secret)
      begin
        num_index = @num.index("auth #{auth_num}")
        @num.insert(num_index + 1, method_num.to_s + " sha1 " + secret.to_s + "\n")
      rescue
        puts "no such auth num #{auth_num}"
        return false
      end
    end

    #
    # Cyclic Redundancy Check hash method. This method does not require
    # a shared secret and is insecure; it's use is strongly discouraged.
    #
    def add_crc(auth_num, method_num)
      begin
        num_index = @num.index("auth #{auth_num}")
        @num.insert(num_index + 1, method_num.to_s + " crc " + "\n")
      rescue
        puts "no such auth num #{auth_num}"
        return false
      end
    end

    #
    # Return the RhaAuthkeys configuration
    #
    def config
      return @num
    end
    
  end