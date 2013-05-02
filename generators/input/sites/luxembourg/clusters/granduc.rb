site :luxembourg do |site_uid|

  cluster :granduc do |cluster_uid|
    model "PowerEdge 1950"
    created_at Time.parse("2011-12-01").httpdate
    kavlan true

    22.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|

        performance({
        :node_flops     => 44.07.G,
        :core_flops     => 6.409.G
      })

        supported_job_types({
          :deploy       => true,
          :besteffort   => true,
          :virtual      => lookup('granduc', node_uid, 'supported_job_types', 'virtual')
        })

        architecture({
          :smp_size       => lookup('granduc', node_uid, 'architecture', 'smp_size'),
          :smt_size       => lookup('granduc', node_uid, 'architecture', 'smt_size'),
          :platform_type  => lookup('granduc', node_uid, 'architecture', 'platform_type')
        })

        processor({
          :vendor             => lookup('granduc', node_uid, 'processor', 'vendor'),
          :model              => lookup('granduc', node_uid, 'processor', 'model'),
          :version            => lookup('granduc', node_uid, 'processor', 'version'),
          :clock_speed        => lookup('granduc', node_uid, 'processor', 'clock_speed'),
          :instruction_set    => lookup('granduc', node_uid, 'processor', 'instruction_set'),
          :other_description  => lookup('granduc', node_uid, 'processor', 'other_description'),
          :cache_l1           => lookup('granduc', node_uid, 'processor', 'cache_l1'),
          :cache_l1i          => lookup('granduc', node_uid, 'processor', 'cache_l1i'),
          :cache_l1d          => lookup('granduc', node_uid, 'processor', 'cache_l1d'),
          :cache_l2           => lookup('granduc', node_uid, 'processor', 'cache_l2'),
          :cache_l3           => lookup('granduc', node_uid, 'processor', 'cache_l3')
        })

        main_memory({
          :ram_size     => lookup('granduc', node_uid, 'main_memory', 'ram_size'),
          :virtual_size => nil
        })

        operating_system({
          :name     => lookup('granduc', node_uid, 'operating_system', 'name'),
          :release  => "Squeeze",
          :version  => lookup('granduc', node_uid, 'operating_system', 'version'),
          :kernel   => lookup('granduc', node_uid, 'operating_system', 'kernel')
        })

        storage_devices [{
          :interface  => 'SAS',
          :size       => lookup('granduc', node_uid, 'block_devices', 'sda', 'size'),
          :driver     => "mptsas",
          :device     => lookup('granduc', node_uid, 'block_devices', 'sda', 'device'),
          :model      => lookup('granduc', node_uid, 'block_devices', 'sda', 'model'),
          :vendor     => lookup('granduc', node_uid, 'block_devices', 'sda', 'vendor'),
          :rev        => lookup('granduc', node_uid, 'block_devices', 'sda', 'rev')
        }]

        network_adapters [{
          :interface        => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'interface'),
          :rate             => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'rate'),
          :enabled          => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'enabled'),
          :management       => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'management'),
          :mountable        => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'mountable'),
          :mounted          => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'mounted'),
          :bridged 	    => true,
          :device           => "eth0",
          :driver           => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'driver'),
          :network_address  => "#{node_uid}.#{site_uid}.grid5000.fr",
          :ip               => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'ip'),
          :ip6              => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'ip6'),
          :switch           => "gw-luxembourg",
          :switch_port      => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'switch_port'),
          :mac              => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'mac')
        },
        {
          :interface        => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'interface'),
          :rate             => 1.G,
          :enabled          => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'enabled'),
          :management       => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'management'),
          :mountable        => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'mountable'),
          :mounted          => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'mounted'),
          :bridged 	    => false,
          :device           => "eth1",
          :driver           => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'driver'),
          :network_address  => "#{node_uid}-eth1.#{site_uid}.grid5000.fr",
          :ip               => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'ip'),
          :switch           => "gw-luxembourg",
          :switch_port      => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'switch_port'),
          :mac              => lookup('granduc', node_uid, 'network_interfaces', 'eth1', 'mac')
        },
        {
          :interface        => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'interface'),
          :rate             => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'rate'),
          :enabled          => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'enabled'),
          :management       => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'management'),
          :mountable        => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'mountable'),
          :mounted          => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'mounted'),
          :bridged 	    => false,
          :device           => "eth2",
          :driver           => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'driver'),
          :switch           => "ul-grid5000-sw02",
          :switch_port      => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'switch_port'),
          :network_address  => "#{node_uid}-eth2.#{site_uid}.grid5000.fr",
          :ip               => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'ip'),
          :mac              => lookup('granduc', node_uid, 'network_interfaces', 'eth2', 'mac')
        },
        {
          :interface        => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'interface'),
          :rate             => 10.G,
          :enabled          => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'enabled'),
          :management       => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'management'),
          :mountable        => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'mountable'),
          :mounted          => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'mounted'),
          :bridged 	    => false,
          :device           => "eth3",
          :driver           => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'driver'),
          :mac              => lookup('granduc', node_uid, 'network_interfaces', 'eth3', 'mac')
        },
        {
          :interface        => 'Ethernet',
          :rate             => 1.G,
          :enabled          => true,
          :management       => true,
          :mountable        => false,
          :mounted          => false,
          :device           => "bmc",
          :network_address  => "#{node_uid}-bmc.#{site_uid}.grid5000.fr",
          :ip               => lookup('granduc', node_uid, 'network_interfaces', 'bmc', 'ip'),
          :switch           => "gw-luxembourg",
          :switch_port      => lookup('granduc', node_uid, 'network_interfaces', 'eth0', 'switch_port'),
          :mac              => lookup('granduc', node_uid, 'network_interfaces', 'bmc', 'mac'),
          :driver           => "bnx2"
        }]

        chassis({
          :serial       => lookup('granduc', node_uid, 'chassis', 'serial_number'),
          :name         => lookup('granduc', node_uid, 'chassis', 'product_name'),
          :manufacturer => lookup('granduc', node_uid, 'chassis', 'manufacturer')
        })

        bios({
          :version      => lookup('granduc', node_uid, 'bios', 'version'),
          :vendor       => lookup('granduc', node_uid, 'bios', 'vendor'),
          :release_date => lookup('granduc', node_uid, 'bios', 'release_date')
        })

        gpu({
          :gpu  => false
        })

        monitoring({
          :wattmeter  => false
        })

        addressing_plan({
          :kavlan => "10.40.0.0/14",
          :virt   => "10.172.0.0/14"
        })

      end
    end
  end
end
