site :rennes do |site_uid|

  cluster :parapluie do |cluster_uid|
    model "HP ProLiant DL165 G7"
    created_at Time.parse("2010-11-02").httpdate
    kavlan true
    queues ['default', 'admin']

    40.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|

        performance({
        :core_flops => 4932000000,
        :node_flops => 121200000000
      })

        supported_job_types({
          :deploy       => true,
          :besteffort   => true,
          :virtual      => lookup(node_uid, node_uid, 'supported_job_types', 'virtual'),
          :max_walltime => 0,
          :queues       => ['default', 'admin']
        })

        architecture({
          :smp_size       => lookup(node_uid, node_uid, 'architecture', 'smp_size'),
          :smt_size       => lookup(node_uid, node_uid, 'architecture', 'smt_size'),
          :platform_type  => lookup(node_uid, node_uid, 'architecture', 'platform_type')
        })

        processor({
          :vendor             => lookup(node_uid, node_uid, 'processor', 'vendor'),
          :model              => lookup(node_uid, node_uid, 'processor', 'model'),
          :version            => lookup(node_uid, node_uid, 'processor', 'version'),
          :clock_speed        => lookup(node_uid, node_uid, 'processor', 'clock_speed'),
          :instruction_set    => lookup(node_uid, node_uid, 'processor', 'instruction_set'),
          :other_description  => lookup(node_uid, node_uid, 'processor', 'other_description'),
          :cache_l1           => lookup(node_uid, node_uid, 'processor', 'cache_l1'),
          :cache_l1i          => lookup(node_uid, node_uid, 'processor', 'cache_l1i'),
          :cache_l1d          => lookup(node_uid, node_uid, 'processor', 'cache_l1d'),
          :cache_l2           => lookup(node_uid, node_uid, 'processor', 'cache_l2'),
          :cache_l3           => lookup(node_uid, node_uid, 'processor', 'cache_l3')
        })

        main_memory({
          :ram_size     => lookup(node_uid, node_uid, 'main_memory', 'ram_size'),
          :virtual_size => nil
        })

        operating_system({
          :name     => "debian",
          :release  => "Jessie",
          :version  => "8",
          :kernel   => "3.16.0-4-amd64"
        })

        storage_devices [{
          :interface  => 'SATA',
          :size       => lookup(node_uid, node_uid, 'block_devices', 'sda', 'size'),
          :driver     => "ahci",
          :device     => lookup(node_uid, node_uid, 'block_devices', 'sda', 'device'),
          :model      => lookup(node_uid, node_uid, 'block_devices', 'sda', 'model'),
          :vendor     => lookup(node_uid, node_uid, 'block_devices', 'sda', 'vendor'),
          :rev        => lookup(node_uid, node_uid, 'block_devices', 'sda', 'rev'),
          :storage    => 'HDD'
        }]

        network_adapters [{
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'interface'),
          :rate             => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'rate'),
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'mounted'),
          :device           => "eth0",
          :bridged          => false,
          :vendor           => "Intel",
          :version          => "82576",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'driver'),
          :mac              => lookup(node_uid, node_uid, 'network_interfaces', 'eth0', 'mac')
        },
        {
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'interface'),
          :rate             => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'rate'),
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'mounted'),
          :bridged          => true,
          :device           => "eth1",
          :vendor           => "Intel",
          :version          => "82576",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'driver'),
          :network_address  => "#{node_uid}.#{site_uid}.grid5000.fr",
          :ip               => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'ip'),
          :ip6              => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'ip6'),
          :switch           => net_switch_lookup('rennes', 'parapluie', node_uid),
          :switch_port      => net_port_lookup('rennes', 'parapluie', node_uid),
          :mac              => lookup(node_uid, node_uid, 'network_interfaces', 'eth1', 'mac')
        },
        {
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'interface'),
          :rate             => 1.G,
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'mounted'),
          :device           => "eth2",
          :bridged          => false,
          :vendor           => "Intel",
          :version          => "82576",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'driver'),
          :mac              => lookup(node_uid, node_uid, 'network_interfaces', 'eth2', 'mac')
        },
        {
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'interface'),
          :rate             => 1.G,
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'mounted'),
          :device           => "eth3",
          :bridged          => false,
          :vendor           => "Intel",
          :version          => "82576",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'driver'),
          :mac              => lookup(node_uid, node_uid, 'network_interfaces', 'eth3', 'mac')
        },
        {
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'interface'),
          :rate             => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'rate'),
          :device           => "ib0",
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'mounted'),
          :vendor           => 'Mellanox',
          :version          => "MT25418",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'driver'),
          :network_address  => "#{node_uid}-ib0.#{site_uid}.grid5000.fr",
          :ip               => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'ip'),
          :ip6               => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'ip6'),
          :guid             => lookup(node_uid, node_uid, 'network_interfaces', 'ib0', 'guid')
        },
        {
          :interface        => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'interface'),
          :rate             => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'rate'),
          :device           => "ib1",
          :enabled          => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'enabled'),
          :management       => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'management'),
          :mountable        => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'mountable'),
          :mounted          => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'mounted'),
          :vendor           => 'Mellanox',
          :version          => "MT25418",
          :driver           => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'driver'),
          :guid             => lookup(node_uid, node_uid, 'network_interfaces', 'ib1', 'guid')
        },
        {
          :interface            => 'Ethernet',
          :rate                 => 1.G,
          :network_address      => "#{node_uid}-bmc.#{site_uid}.grid5000.fr",
          :ip                   => lookup(node_uid, node_uid, 'network_interfaces', 'bmc', 'ip'),
          :mac                  => lookup(node_uid, node_uid, 'network_interfaces', 'bmc', 'mac'),
          :enabled              => true,
          :mounted              => false,
          :mountable            => false,
          :management           => true,
          :device               => "bmc"
        }]

        chassis({
          :serial       => lookup(node_uid, node_uid, 'chassis', 'serial_number'),
          :name         => lookup(node_uid, node_uid, 'chassis', 'product_name'),
          :manufacturer => lookup(node_uid, node_uid, 'chassis', 'manufacturer')
        })

        bios({
          :version      => lookup(node_uid, node_uid, 'bios', 'version'),
          :vendor       => lookup(node_uid, node_uid, 'bios', 'vendor'),
          :release_date => lookup(node_uid, node_uid, 'bios', 'release_date')
        })

        bios({
          :version      => lookup(node_uid, node_uid, 'bios', 'version'),
          :vendor       => lookup(node_uid, node_uid, 'bios', 'vendor'),
          :release_date => lookup(node_uid, node_uid, 'bios', 'release_date')
        })

        gpu({
          :gpu  => false
        })

        monitoring({
          :temperature  => true,
        })

        sensors({
          :power => {
            :available => true,
            :via => {
              :pdu      => [{
                :uid  => lookup('parapluie_manual', node_uid, 'pdu', 'pdu_name'),
                :port => lookup('parapluie_manual', node_uid, 'pdu', 'pdu_position'),
             }],
              :api      => { :metric => "power" }
            }
          },
          :temperature => {
            :available => true,
            :via => {
              :api      => { :metric => "ambient_temp" },
              :ipmi     => { :sensors => { :ambient => "Inlet Ambient" } }
            }
          }
        })

#        chassis({:serial_number => lookup(node_uid, node_uid, 'chassis', 'serial_number')})

      end
    end
  end
end