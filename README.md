RHA - Heartbeat High Availability Cluster API for Ruby
======================================================

Rha is a gem providing a ruby interface to Heartbeat High Availability Cluster.

To install, type 'gem install rha'

### Why RHA?

RHA creates simple and small development tools that help you design,
develop, deploy cloud infrastractures for your enterprise software systems.

#### RHA Pro: A Commercial, Supported Version of RHA
RHA Pro is a collection of useful functionality for the open source RHA library with priority support via Remote access or Skype from the author, new features in-demand, upgrades and lots more.

Sales of RHA Pro also benefit the community by ensuring that RHA itself will remain well supported for the foreseeable future.

#### Licensing
RHA is available under the terms of the GNU LGPLv3 license.

In addition to its useful functionality, buying RHA Pro grants your organization a RHA Commercial License instead of the GNU LGPL, avoiding any legal issues your lawyers might raise. Please contact joelbryan.juliano@gmail.com for further detail on licensing including options for embedding RHA Pro in your own products.

#### Buy RHA Pro
Contact me via joelbryan.juliano@gmail.com, and Pay via Paypal: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6DGJ9FMXUX6ZC

### Usage:

```ruby
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
```

#### ha.cf:

```ruby
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
```

#### authkeys:

```ruby
      auth 1
      3 crc
      2 sha1 secret
      1 md5 secret
```

#### haresources:

```ruby
      alice 192.168.1.10 sshd nginx mysql
```

### Donations

Please support independent cloud computing toolkits, also money donated to the project will benefit the community by ensuring that RHA itself will remain well supported for the foreseeable future. To Donate, please visit: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KT9CY4T7BYDM4
