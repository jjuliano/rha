README for Rha
==================

Rha is a gem providing a ruby interface to Heartbeat High Availability Cluster.

To install, type 'gem install rha'

Usage:

      require 'rubygems'
      require 'rha'
      
      ha_cf = RhaConfig.new
      ha_cf.use_logd = "on"
      ha_cf.mcast = "eth0 239.0.0.42 694 1 0"
      ha_cf.bcast = "eth1"
      ha_cf.node = "alice bob"
      ha_cf.keepalive = "1000ms"
      ha_cf.deadtime = "30000ms"
      ha_cf.realtime = true
      ha_cf.conn_logd_time = "60"
      ha_cf.crm = "false"
      ha_cf.compression = "zlib"
      ha_cf.compression_threshold = 2

      authkeys = RhaAuthkeys.new
      authkeys.auth(1)
      authkeys.add_md5(1, 1, "secret")
      authkeys.add_sha1(1, 2, "secret")
      authkeys.add_crc(1, 3)
      
      haresources = RhaResources.new
      haresources.preferred_node = "alice"
      haresources.resource_name = "192.168.1.10"
      haresources.script_name = "sshd nginx mysql"

      ha_cf_file = File.new("ha.cf", "w+")
      ha_cf_file.puts(ha_cf.config)

      authkeys_file = File.new("authkeys", "w+")
      authkeys_file.puts(authkeys.config)
      
      haresources_file = File.new("haresources", "w+")
      haresources_file.puts(haresources.config)

      ha_cf_file.close      
      authkeys_file.close
      haresources_file.close

      heartbeat = RhaDaemon.new
      heartbeat.path_to_heartbeat = "/etc/init.d/heartbeat"
      heartbeat.debug_level = "3"
      heartbeat.reload

ha.cf:

      use_logd on 
      bcast eth1 
      compression zlib 
      compression_threshold 2 
      conn_logd_time 60 
      crm false 
      deadtime 30000ms 
      keepalive 1000ms 
      mcast eth0 239.0.0.42 694 1 0 
      node alice bob 
      realtime true 

authkeys:

      auth 1
      3 crc 
      2 sha1 secret
      1 md5 secret

haresources:

      alice 192.168.1.10 sshd nginx mysql