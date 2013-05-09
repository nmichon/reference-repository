site :grenoble do |site_uid|

  cluster :genepi do |cluster_uid|
    model "Bull R422-E1"
    created_at Time.parse("2008-10-01").httpdate
    kavlan false

    34.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|

        performance({
        :core_flops => 7651000000,
        :node_flops => 49650000000
      })

        supported_job_types({
          :deploy       => true,
          :besteffort   => true,
          :virtual      => lookup('genepi', node_uid, 'supported_job_types', 'virtual')
        })

        architecture({
          :smp_size       => lookup('genepi', node_uid, 'architecture', 'smp_size'),
          :smt_size       => lookup('genepi', node_uid, 'architecture', 'smt_size'),
          :platform_type  => lookup('genepi', node_uid, 'architecture', 'platform_type')
        })

        processor({
          :vendor             => lookup('genepi', node_uid, 'processor', 'vendor'),
          :model              => lookup('genepi', node_uid, 'processor', 'model'),
          :version            => lookup('genepi', node_uid, 'processor', 'version'),
          :clock_speed        => lookup('genepi', node_uid, 'processor', 'clock_speed'),
          :instruction_set    => lookup('genepi', node_uid, 'processor', 'instruction_set'),
          :other_description  => lookup('genepi', node_uid, 'processor', 'other_description'),
          :cache_l1           => lookup('genepi', node_uid, 'processor', 'cache_l1'),
          :cache_l1i          => lookup('genepi', node_uid, 'processor', 'cache_l1i'),
          :cache_l1d          => lookup('genepi', node_uid, 'processor', 'cache_l1d'),
          :cache_l2           => lookup('genepi', node_uid, 'processor', 'cache_l2'),
          :cache_l3           => lookup('genepi', node_uid, 'processor', 'cache_l3')
        })

        main_memory({
          :ram_size     => lookup('genepi', node_uid, 'main_memory', 'ram_size'),
          :virtual_size => nil
        })

        operating_system({
          :name     => lookup('genepi', node_uid, 'operating_system', 'name'),
          :release  => "Squeeze",
          :version  => lookup('genepi', node_uid, 'operating_system', 'version'),
          :kernel   => lookup('genepi', node_uid, 'operating_system', 'kernel')
        })

        storage_devices [{
          :interface  => 'SATA',
          :size       => lookup('genepi', node_uid, 'block_devices', 'sda', 'size'),
          :driver     => "ahci",
          :device     => lookup('genepi', node_uid, 'block_devices', 'sda', 'device'),
          :model      => lookup('genepi', node_uid, 'block_devices', 'sda', 'model'),
          :vendor     => lookup('genepi', node_uid, 'block_devices', 'sda', 'vendor'),
          :rev        => lookup('genepi', node_uid, 'block_devices', 'sda', 'rev')
        }]
        storage_devices [{
          :interface  => 'SATA',
          :size       => lookup('genepi', node_uid, 'block_devices', 'sda', 'size'),
          :model      => lookup('genepi', node_uid, 'block_devices', 'sda', 'model'),
          :vendor     => lookup('genepi', node_uid, 'block_devices', 'sda', 'vendor'),
          :driver     => "ata_piix"
        }]

        network_adapters [{
          :interface        => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'interface'),
          :rate             => 1.G,
          :enabled          => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'enabled'),
          :management       => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'management'),
          :mountable        => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'mountable'),
          :mounted          => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'mounted'),
          :bridged          => true,
          :device           => "eth0",
          :vendor           => 'Intel',
          :version          => "Intel 80003ES2LAN Gigabit Ethernet Controller (Copper) (rev 01)",
          :driver           => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'driver'),
          :network_address  => "#{node_uid}.#{site_uid}.grid5000.fr",
          :mac              => lookup('genepi', node_uid, 'network_interfaces', 'eth0', 'mac')
        },
        {
          :interface        => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'interface'),
          :rate             => 1.G,
          :enabled          => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'enabled'),
          :management       => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'management'),
          :mountable        => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'mountable'),
          :mounted          => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'mounted'),
          :bridged          => false,
          :device           => "eth1",
          :vendor           => 'Intel',
          :version          => "Intel 80003ES2LAN Gigabit Ethernet Controller (Copper) (rev 01)",
          :ip               => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'ip'),
          :ip6              => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'ip6'),
          :switch           => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'switch_name'),
          :switch_port      => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'switch_port'),
          :driver           => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'driver'),
          :mac              => lookup('genepi', node_uid, 'network_interfaces', 'eth1', 'mac')
        },
        {
          :interface        => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'interface'),
          :rate             => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'rate'),
          :device           => "ib0",
          :enabled          => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'enabled'),
          :management       => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'management'),
          :mountable        => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'mountable'),
          :mounted          => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'mounted'),
          :vendor           => 'Mellanox',
          :version          => "InfiniHost MHGH29-XTC",
          :driver           => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'driver'),
          :network_address  => "#{node_uid}-ib0.#{site_uid}.grid5000.fr",
          :ip               => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'ip'),
          :guid             => lookup('genepi', node_uid, 'network_interfaces', 'ib0', 'guid')
        },
        {
          :interface        => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'interface'),
          :rate             => 40.G,
          :rate             => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'rate'),
          :device           => "ib1",
          :enabled          => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'enabled'),
          :management       => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'management'),
          :mountable        => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'mountable'),
          :mounted          => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'mounted'),
          :vendor           => 'Mellanox',
          :version          => "InfiniHost MHGH29-XTC",
          :driver           => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'driver'),
          :guid             => lookup('genepi', node_uid, 'network_interfaces', 'ib1', 'guid')
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
          :ip               => lookup('genepi', node_uid, 'network_interfaces', 'bmc', 'ip'),
          :mac              => lookup('genepi', node_uid, 'network_interfaces', 'bmc', 'mac'),
          :vendor => "Peppercon AG (10437)",
          :version => "1.50"
        }]

        chassis({
          :serial       => lookup('genepi', node_uid, 'chassis', 'serial_number'),
          :name         => lookup('genepi', node_uid, 'chassis', 'product_name'),
          :manufacturer => lookup('genepi', node_uid, 'chassis', 'manufacturer')
        })

        bios({
          :version      => lookup('genepi', node_uid, 'bios', 'version'),
          :vendor       => lookup('genepi', node_uid, 'bios', 'vendor'),
          :release_date => lookup('genepi', node_uid, 'bios', 'release_date')
        })

        gpu({
          :gpu  => false
        })

        monitoring({
          :wattmeter  => false
        })

      end
    end
  end
end
