  # = rha - A Heartbeat gem for Ruby
  #
  # Homepage::  http://github.com/jjuliano/rha
  # Author::    Joel Bryan Juliano
  # Copyright:: (cc) 2011-2015 Joel Bryan Juliano
  # License::   GNU LGPLv3

  #
  # class RhaConfig.new( array, str, array)
  #

  #
  # RhaConfig are configurations for heartbeat.
  #
  class RhaConfig
    #
    # The use_logd directive specifies whether Heartbeat logs its
    # messages through logging daemon or not.
    #
    # If the logging daemon is used, all log messages will be sent
    # through IPC to the logging daemon, which then writes them into
    # log files. In case the logging daemon dies (for whatever reason),
    # a warning message will be logged and all messages will be written
    # to log files directly.
    #
    # If the logging daemon is used, logfile/debugfile/logfacility in this
    # file are not meaningful any longer. You should check the config file
    # for logging daemon (the default is /etc/logd.cf).
    #
    # If use_logd is not used, all log messages will be written to log files directly.
    #
    # The logging daemon is started/stopped in heartbeat script.
    #
    # Setting use_logd to "on" is recommended.
    #
    attr_accessor :use_logd

    #
    # The udpport directive specifies which port Heartbeat will use for its
    # UDP intra-cluster communication. There are two common reasons for overriding
    # this value: there are multiple bcast clusters on the same subnet, or this port
    # is already in use in accordance with some locally-established policy.
    #
    # The default value for this parameter is the the port ha-cluster in /etc/services
    # (if present), or 694 if port ha-cluster is not in /etc/services. 694 is the
    # IANA registered port number for Heartbeat (a.k.a. ha-cluster).
    #
    # A sample udpport directive is shown below.
    #
    # udpport 694
    #
    # You have to configure udpport (in ha.cf) before you configure
    # ucast or bcast, if not heartbeat will use the default port (694).
    #
    # Note
    #
    # Due to a specification error in the syntax of the mcast directive,
    # this directive does not apply to mcast communications.
    #
    attr_accessor :udpport

    # 
    # This directive specifies what users and/or groups are allowed to connect to
    # a specific API group name. The syntax is simple:
    # 
    # apiauth apigroupname [uid=uid1,uid2 ...] [gid=gid1,gid2 ...]
    # 
    # You can specify either a uid list, or a gid list, or both. However you must
    # specify either a uid list or a gid list. If you include both a uid list and a
    # gid list, then a process is authorized to connect to that API group if if it is
    # either in the uid-list or it is in the gid-list.
    # 
    # The API group name default has special meaning. If it is specified, it will
    # be used for authorizing clients without any API group name, and all client
    # groups not identified by any other apiauth directive.
    # 
    # Unless you specify otherwise in the ha.cf file, certain services will be
    # provided default authorizations as follows:
    # 
    # Table A.1. Default service authorizations
    # Service  Default apiauth
    # ipfail  uid=hacluster
    # ccm  gid=haclient
    # ping  gid=haclient
    # cl_status  gid=haclient
    # lha-snmpagent  uid=root
    # crm  uid=hacluster
    #
    attr_accessor :apiauth

    # 
    # The autojoin directive enables nodes to join automatically just by
    # communicating with the cluster, hence not requiring node directives in the ha.cf
    # file. Since our communication is normally strongly authenticated, only nodes
    # which know the cluster key can join (automatically or otherwise).
    # 
    # The values you can give for the autojoin directive have the following
    # meanings:
    # 
    # * none: disables automatic joining.
    # * other: allows nodes other than ourself who are not listed in ha.cf to
    # join automatically. In other words, our node has to be listed in ha.cf, but
    # other nodes do not.
    # * any: allows any node to join automatically without being listed in
    # ha.cf, even the current node.
    # 
    # Note that the set of nodes currently considered part of the cluster is kept
    # in the hostcache file. With autojoin enabled, the node directive is no longer
    # authoritative - the hostcache file is.
    #
    attr_accessor :autojoin

    # 
    # The bcast directive is used to configure which interfaces Heartbeat sends
    # UDP broadcast traffic on. More than one interface can be specified on the line.
    # The udpport directive is used to configure which port is used for these
    # broadcast communications if the udpport directive is specified before the bcast
    # directive, otherwise the default port will be used. A couple of sample bcast
    # lines are shown below.
    # 
    # bcast eth0 eth1  # on Linux systems
    # bcast le0# for Solaris systems
    # 
    # Note
    # 
    # Broadcast links are not supported in Pacemaker clusters on BSD systems.
    #
    attr_accessor :bcast

    # 
    # The compression directive sets which compression method will be used when a
    # message is big and compression is needed.
    # 
    # It could be either zlib or bz2, depending on whether you have the
    # corresponding library in the system. You can check
    # /usr/lib/heartbeat/plugins/HBcompress to see what compression module is
    # available.
    # 
    # If this directive is not set, there will be no compression.
    #
    attr_accessor :compression

    # 
    # The compression_threshold directive sets the threshold to compress a
    # message, e.g. if the threshold is 1, then any message with size greater than 1
    # KB will be compressed. The default is 2 (KB). This directive only makes sense if
    # you have set the compression directive.
    #
    attr_accessor :compression_threshold

    # 
    # The conn_logd_time directive specifies the time Heartbeat will reconnect to
    # the logging daemon if the connection between Heartbeat and the logging daemon is
    # broken. The conn_logd_time is specified according to the Heartbeat time syntax,
    # for example:
    # 
    # conn_logd_time 60 #60 seconds
    # 
    # The default is 60 seconds.
    # Note
    # 
    # Heartbeat will not automatically reconnect to the logging daemon. It only
    # tries to reconnect when it needs to log a message and conn_logd_time have passed
    # since the last attempt to connect.
    #
    attr_accessor :conn_logd_time
    
    # 
    # The coredumps directive tells Heartbeat to do things to enable making core
    # dumps - should it need to dump core.
    # 
    # The allowed values are true and false.
    #
    attr_accessor :coredumps
    
    # 
    # Enables the Pacemaker cluster manager. For historical reasons, the default
    # for this option is off; however, it should always be set to respawn.
    # 
    # When set to respawn, the directive automatically implies:
    # 
    # apiauth stonithduid=root
    # apiauth crmduid=hacluster
    # apiauth cib uid=hacluster
    # 
    # respawn hacluster   ccm
    # respawn hacluster   cib
    # respawn rootstonithd
    # respawn rootlrmd
    # respawn hacluster   crmd
    # 
    attr_accessor :crm
    
    # 
    # The deadtime directive is used to specify how quickly Heartbeat should
    # decide that a node in a cluster is dead. Setting this value too low will cause
    # the system to falsely declare itself dead. Setting it too high will delay
    # takeover after the failure of a node in the cluster.
    attr_accessor :deadtime
    
    # 
    # The debug directive is used to set the level of debugging in effect in the
    # system. Production systems should have their debug level set to zero (i.e.,
    # turned off). This is the default. Legal values of the debug option are between
    # 0-255. The most useful values are between 0 (off) and 3. Setting the debug level
    # greater than 1 can have an adverse effect on the size of your log files, and on
    # the system's ability to send heartbeats at rapid rates, thus affecting the
    # cluster reliability.
    # 
    # The debug level of the system can also be specified on the command line
    # using the -d option. Additionally, the debug level of the system can be
    # dynamically changed by sending the heartbeat process SIGUSR1 and SIGUSR2
    # signals. SIGUSR1 raises the debug level, and SIGUSR2 lowers it.
    #
    attr_accessor :debug
    
    # 
    # The hbgenmethod directive specifies how Heartbeat should compute its current
    # generation number for communications. This is a specialized and obscure
    # directive, used mainly in firewalls which have no local disk, and other devices
    # which do not have a method of storing data persistently across reboots. It
    # defaults to storing the Heartbeat generations in a file. Generation numbers are
    # used by Heartbeat for replay attack protection.
    #
    # hbgenmethod time|file
    #
    # Warning
    # 
    # If one specifies the time method, there are certain possible cases where
    # troubles can arise. If a machine restarts Heartbeat and its local time of day
    # clock is less than or equal to than the value of the time of day clock when
    # Heartbeat last started, then that node will be unable to join the cluster.
    #
    attr_accessor :hbgenmethod
    
    # 
    # The initdead parameter is used to set the time that it takes to declare a
    # cluster node dead when Heartbeat is first started. This parameter generally
    # needs to be set to a higher value, because experience suggests that it sometimes
    # takes operating systems many seconds for their communication systems before they
    # operate correctly. initdead is specified according to the Heartbeat time syntax.
    # A sample initdead value is shown below:
    # 
    # initdead 30
    # 
    # In some switched network environments, switches engage in a spanning tree
    # algorithm whenever a NIC connects to a port. This can take a long time to
    # complete, and it is only necessary if the NIC being connected is another switch.
    # If this is the case, you may be able to configure certain NICs as not being
    # switches and shrink the connection delay significantly. If not, you'll need to
    # raise initdead to make this problem go away.
    # 
    # If this is set too low, you'll see one node declare the other as dead.
    #
    attr_accessor :initdead
    
    # 
    # The keepalive directive sets the interval between heartbeat packets. It is
    # specified according to the Heartbeat time syntax.
    #
    attr_accessor :keepalive
    
    # 
    # The logfacility is used to tell Heartbeat which syslog logging facility it
    # should use for logging its messages.
    # 
    # The possible values for logfacility vary by operating system, but some of
    # the most common ones are {auth, authpriv, daemon, syslog, user, local0, local1,
    # local2, local3, local4, local5, local6, local7}.
    # 
    # A sample logfacility directive is shown below:
    # 
    # logfacility local7
    # 
    # If you want to disable logging to syslog:
    # 
    # logfacility none
    # 
    attr_accessor :logfacility
    
    # 
    # The mcast directive is used to configure a multicast communication path. The
    # syntax of an mcast directive is:
    # 
    # mcast dev mcast-group udp-port ttl 0
    # 
    # * dev - IP device to send/rcv heartbeats on
    # * mcast-group - multicast group to join (class D multicast address
    # 224.0.0.0 - 239.255.255.255). For most Heartbeat uses, the first byte should be
    # 239.
    # * port - UDP port to sendto/rcvfrom (set this to the same value as
    # udpport)
    # * ttl - the ttl value for outbound heartbeats. This affects how far the
    # multicast packet will propagate. (0-255). Set to 1 for the current subnet. Must
    # be greater than zero.
    # 
    # A sample mcast directive is shown below:
    # 
    # mcast eth0 239.0.0.1 694 1 0
    # 
    attr_accessor :mcast
    
    #
    # The msgfmt directive specifies the format Heartbeat uses in wire.
    # 
    # * classic - Heartbeat will convert a message into a string and transmit
    # in wire. Binary values are converted with a base64 library.
    # * netstring - Binary messages will be transmitted directly. This is more
    # efficient since it avoids conversion between string and binary values.
    # 
    # When in doubt, leave the default (classic).
    #
    attr_accessor :msgfmt
    
    # 
    # The node directive tells what machines are in the cluster. The syntax of the
    # node directive is simple:
    # 
    # node nodename1 nodename2 ...
    # 
    # Node names in the directive must match the "uname -n" of that machine.
    # 
    # You can declare multiple node names in one directive. You can also use the
    # directive multiple times. Normally every node in the cluster must be listed in
    # the ha.cf file, including the current node, unless the autojoin directive is
    # enabled.
    # 
    # The node directive is not completely authoritative with regard to nodes
    # heartbeat will communicate with. If a node has ever been added in the past, it
    # will tend to remain in the hostcache file more until it's manually removed.
    #
    attr_accessor :node
    
    # 
    # The realtime directive specifies whether or not Heartbeat should try and
    # take advantage of the operating system's realtime scheduling features. When
    # enabled, Heartbeat will lock itself into memory, and raise its priority to a
    # realtime priority (as set by the rtprio directive). This feature is mainly used
    # for debugging various kinds of loops which might otherwise cripple the system
    # and impair debugging them.
    # 
    # realtime on|off
    #
    # The default is on.
    #
    attr_accessor :realtime
    
    # 
    # The rtprio directive is used to specify the priority at which Heartbeat
    # runs. It does not need to be specified unless other realtime priority programs
    # are also running on the system. The minimum and maximum values for this field
    # can be determined from the sched_get_priority_min(SCHED_FIFO) and
    # sched_get_priority_max(SCHED_FIFO) calls respectively. The default value for
    # rtprio is halfway between the minimum and maximum values.
    # 
    # A sample rtprio directive is shown below:
    # 
    # rtprio 5
    # 
    attr_accessor :rtprio
    
    # 
    # The ucast directive configures Heartbeat to communicate over a UDP unicast
    # communications link. The udpport directive is used to configure which port is
    # used for these unicast communications if the udpport directive is specified
    # before the ucast directive, otherwise the default port will be used.
    # 
    # The general syntax of a ucast directive is:
    # 
    # ucast dev peer-ip-address
    # 
    # Where dev is the device to use when talking to the peer, and peer-ip-address
    # is the IP address we will send packets to.
    # 
    # A sample ucast directive is shown below:
    # 
    # ucast eth0 10.10.10.133
    # 
    # This directive will cause us to send packets to 10.10.10.133 over interface
    # eth0.
    # 
    # Note that ucast directives which go to the local machine are effectively
    # ignored. This allows the ha.cf directives on all machines to be identical.
    #
    attr_accessor :ucast
    
    # 
    # In the normal case, heartbeat generates a UUID for each node in the system
    # as a way of uniquely identifying a node - even if it should change nodenames.
    # This UUID is typically stored in the file /var/lib/heartbeat/hb_uuid.
    # 
    # For certain kinds of installations (those booting from CDs or other
    # read-only media), it is impossible for heartbeat to save a generated to disk as
    # it normally does. In these cases, one can use the uuidfrom directive to instruct
    # heartbeat to use the nodename as though it were a UUID, by specifying uuidfrom
    # nodename.
    # 
    # All possible legal uuidfrom directives are shown below.
    # 
    # uuidfrom file
    # uuidfrom nodename
    # 
    attr_accessor :uuidfrom
    
    # 
    # The warntime directive is used to specify how quickly Heartbeat should issue
    # a "late heartbeat" warning.
    # 
    # The warntime value is specified according to the HeartbeatTimeSyntax. A
    # sample warntime specification is shown below.
    # 
    # warntime 10 # 10 seconds
    # 
    # The warntime directive is important for tuning deadtime
    # 
    attr_accessor :warntime

    # 
    #     In legacy Heartbeat clusters, the auto_failback option would determine
    # whether a resource would automatically fail back to its "primary" node, or 
    # remain on whatever node is serving it until that node fails, or an administrator 
    # intervenes. The possible values for auto_failback were:
    # 
    #         * on - enable automatic failbacks
    #         * off - disable automatic failback
    #         * legacy - enable automatic failbacks in systems where all nodes in
    # the cluster do not yet support the auto_failback option.
    # 
    attr_accessor :auto_failback
    
    # 
    #     The baud directive is used to set the speed for serial communications.
    # Any of the following speeds can be specified, provided they are supported by
    # your operating system: 9600, 19200, 38400, 57600, 115200, 230400, 460800. The
    # default speed is 19200.
    # 
    attr_accessor :baud
    
    # 
    #     The deadping directive is used to specify how quickly Heartbeat should decide
    # that a ping node in a cluster is dead. Setting this value too low will cause the
    # system to falsely declare the ping node dead. Setting it too high will delay
    # detection of communication failure.
    # 
    attr_accessor :deadping

    # 
    # 
    #     The debugfile directive specifies the file Heartbeat will write debug messages to.
    # 
    #     This directive is ignored when use_logd is specified. Enabling use_logd is
    # the recommended approach.
    # 
    attr_accessor :debugfile
    
    # 
    #     Hbaping directives are given to declare fiber channel devices as ping nodes.
    # 
    attr_accessor :hbaping
    
    # 
    #     The hopfudge directive controls how many nodes a packet can be forwarded
    # through before it is thrown away in the worst case. However, the hopfudge value
    # is added to the number of nodes in the system. It defaults to 1.
    # 
    attr_accessor :hopfudge
    
    # 
    #     The logfile directive configures a log file. All non-debug messages from
    # Heartbeat will go into this file.
    # 
    #     This directive is ignored when use_logd is specified. Enabling use_logd
    # is the recommended approach.
    # 
    attr_accessor :logfile
    
    # 
    #     Ping directives are given to declare ping nodes to Heartbeat. The syntax
    # of the ping directive is simple:
    # 
    #     ping ip-address ...
    # 
    #     Each IP address listed in a ping directive is considered to be independent.
    # That is, connectivity to each node is considered to be equally important.
    # 
    #     In order to declare that a group of nodes are equally qualified for a particular
    # function, and that the presence of any of them indicates successful communication,
    # use the ping_group directive.
    # 
    attr_accessor :ping

    # 
    #     Ping group directives are given to declare a group ping node to Heartbeat.
    # syntax of the ping_group directive is as follows:
    # 
    #     ping_group group-name ip-address ...
    # 
    #     Each IP address listed in a ping_group directive is considered to be related,
    # and connectivity to any one node is considered to be connectivity to the group.
    # 
    #     A ping group is considered by Heartbeat to be a single cluster node (group-name).
    # The ability to communicate with any of the group members means that the group-name member
    # is reachable. This is useful when (for example) two different routers may be used to contact
    # the internet, depending on which is up, or when finding an appropriate reliable single ping
    # node is difficult.
    # 
    attr_accessor :ping_group

    # 
    #     The respawn directive is used to specify a program to run and monitor while it runs.
    # If this program exits with anything other than exit code 100, it will be automatically
    # restarted. The first parameter is the user id to run the program under, and the second
    # parameter is the program to run. Subsequent parameters will be given to the
    # program as arguments.
    # 
    attr_accessor :respawn
    
    # 
    #     The serial directive tells Heartbeat to use the specified serial port(s) for its
    # communication. The parameters to the serial directive are the names of tty devices
    # suitable for opening without waiting for carrier first. On Linux, those ports are
    # typically named /dev/ttySX.
    # 
    #     A few sample serial directives are shown below:
    # 
    #     serial /dev/ttyS0 /dev/ttyS1     # Linux
    #     serial /dev/cuaa0                # FreeBSD
    #     serial /dev/cua/a                # Solaris
    # 
    #     The baud directive is used to configure the baud rate for the port(s) if the baud
    # directive is specified before the serial directive, otherwise the default baud rate
    # will be used.
    # 
    attr_accessor :serial

    # 
    #     The stonith directive is used to configure Heartbeat's legacy STONITH configuration.
    # It assumes you're going to put in a STONITH configuration file on each machine in the
    # cluster to configure the (single) STONITH device that this node will use to reset the
    # other node in the cluster.
    # 
    attr_accessor :stonith
    
    # 
    #     The stonith_host directive is used to configure Heartbeat's (release 1 only),
    # STONITH configuration. With this directive, you put all the STONITH configuration
    # information for the devices in your cluster in the ha.cf file, rather than in
    # a separate file.
    # 
    attr_accessor :stonith_host
    
    # 
    #     This directive enables traditional compression. It is highly recommended that this
    # be set to off (the default); otherwise heartbeat performance can be significantly
    # negatively impacted.
    # 
    attr_accessor :traditional_compression
    
    # 
    #     The watchdog directive configures Heartbeat to use a watchdog device. In some
    # circumstances, a watchdog device can be used in place of a STONITH device. In any case,
    # it is a reasonable thing to configure if you don't have a STONITH device, or if you
    # wish, in addition to your STONITH device.
    # 
    #     It is the purpose of a watchdog device to shut the machine down if Heartbeat
    # does not hear its own heartbeats as often as it thinks it should. This keeps things
    # like scheduler bugs from becoming split-brain configurations.
    # 
    #     The general syntax of a watchdog directive is:
    # 
    #     watchdog watchdog-device-name
    # 
    #     A sample watchdog directive is shown below:
    # 
    #     watchdog /dev/watchdog
    # 
    #     The most common watchdog device currently used with general Linux systems is the
    # softdog device. The softdog device is a software-based watchdog device and is usually
    # referred to as /dev/watchdog - although like most UNIX devices, this is a convention
    # not a rule.
    attr_accessor :watchdog

    #
    # Returns a new RhaConfig Object
    #
    def initialize()
    end

    #
    # Compile the RhaConfig configuration
    #
    def config
      conf = option_string()
      return conf
    end

    private

    def option_string()
      ostring = ""

      if @use_logd
        ostring += "use_logd " + @use_logd.to_s + " " + "\n"
      end

      if @udpport
        ostring += "udpport " + @udpport.to_s + " " + "\n"
      end

      if @apiauth
        ostring += "apiauth " + @apiauth.to_s + " " + "\n"
      end

      if @autojoin
        ostring += "autojoin " + @autojoin.to_s + " " + "\n"
      end

      if @bcast
        ostring += "bcast " + @bcast.to_s + " " + "\n"
      end

      if @compression
        ostring += "compression " + @compression.to_s + " " + "\n"
      end

      if @compression_threshold
        ostring += "compression_threshold " + @compression_threshold.to_s + " " + "\n"
      end

      if @conn_logd_time
        ostring += "conn_logd_time " + @conn_logd_time.to_s + " " + "\n"
      end

      if @coredumps
        ostring += "coredumps " + @coredumps.to_s + " " + "\n"
      end

      if @crm
        ostring += "crm " + @crm.to_s + " " + "\n"
      end

      if @deadtime
        ostring += "deadtime " + @deadtime.to_s + " " + "\n"
      end

      if @debug
        ostring += "debug " + @debug.to_s + " " + "\n"
      end

      if @hbgenmethod
        ostring += "hbgenmethod " + @hbgenmethod.to_s + " " + "\n"
      end

      if @initdead
        ostring += "initdead " + @initdead.to_s + " " + "\n"
      end

      if @keepalive
        ostring += "keepalive " + @keepalive.to_s + " " + "\n"
      end

      if @logfacility
        ostring += "logfacility " + @logfacility.to_s + " " + "\n"
      end

      if @mcast
        ostring += "mcast " + @mcast.to_s + " " + "\n"
      end

      if @msgfmt
        ostring += "msgfmt " + @msgfmt.to_s + " " + "\n"
      end

      if @node
        ostring += "node " + @node.to_s + " " + "\n"
      end

      if @realtime
        ostring += "realtime " + @realtime.to_s + " " + "\n"
      end

      if @rtprio
        ostring += "rtprio " + @rtprio.to_s + " " + "\n"
      end

      if @ucast
        ostring += "ucast " + @ucast.to_s + " " + "\n"
      end

      if @uuidfrom
        ostring += "uuidfrom " + @uuidfrom.to_s + " " + "\n"
      end

      if @warntime
        ostring += "warntime " + @warntime.to_s + " " + "\n"
      end

      if @auto_failback
        ostring += "auto_failback " + @auto_failback.to_s + " " + "\n"
      end
      
      if @baud
        ostring += "baud " + @baud.to_s + " " + "\n"
      end
      
      if @deadping
        ostring += "deadping " + @deadping.to_s + " " + "\n"
      end
      
      if @debugfile
        ostring += "debugfile " + @debugfile.to_s + " " + "\n"
      end
      
      if @hbaping
        ostring += "hbaping " + @hbaping.to_s + " " + "\n"
      end
      
      if @hopfudge
        ostring += "hopfudge " + @hopfudge.to_s + " " + "\n"
      end
      
      if @logfile
        ostring += "logfile " + @logfile.to_s + " " + "\n"
      end
      
      if @ping
        ostring += "ping " + @ping.to_s + " " + "\n"
      end
      
      if @ping_group
        ostring += "ping_group " + @ping_group.to_s + " " + "\n"
      end
      
      if @respawn
        ostring += "respawn " + @respawn.to_s + " " + "\n"
      end
      
      if @serial
        ostring += "serial " + @serial.to_s + " " + "\n"
      end
      
      if @stonith
        ostring += "stonith " + @stonith.to_s + " " + "\n"
      end
      
      if @stonith_host
        ostring += "stonith_host " + @stonith_host.to_s + " " + "\n"
      end
      
      if @traditional_compression
        ostring += "traditional_compression " + @traditional_compression.to_s + " " + "\n"
      end
      
      if @watchdog
        ostring += "watchdog " + @watchdog.to_s + " " + "\n"
      end
      
      return ostring

    end
  end

