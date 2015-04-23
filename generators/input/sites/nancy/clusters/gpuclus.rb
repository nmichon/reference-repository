site :nancy do |site_uid|

  cluster :gpuclus do |cluster_uid|
    model "Dell R720"
    created_at Time.parse("2015-04-20 12:00 GMT").httpdate
    kavlan true
    production true

    5.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|

        supported_job_types({
          :deploy       => true,
          :besteffort   => true,
          :virtual      => lookup('gpuclus_generated', node_uid, 'supported_job_types', 'virtual')
        })

        architecture({
          :smp_size       => lookup('gpuclus_generated', node_uid, 'architecture', 'smp_size'),
          :smt_size       => lookup('gpuclus_generated', node_uid, 'architecture', 'smt_size'),
          :platform_type  => lookup('gpuclus_generated', node_uid, 'architecture', 'platform_type')
        })

        processor({
          :vendor             => lookup('gpuclus_generated', node_uid, 'processor', 'vendor'),
          :model              => lookup('gpuclus_generated', node_uid, 'processor', 'model'),
          :version            => lookup('gpuclus_generated', node_uid, 'processor', 'version'),
          :clock_speed        => lookup('gpuclus_generated', node_uid, 'processor', 'clock_speed'),
          :instruction_set    => lookup('gpuclus_generated', node_uid, 'processor', 'instruction_set'),
          :other_description  => lookup('gpuclus_generated', node_uid, 'processor', 'other_description'),
          :cache_l1           => lookup('gpuclus_generated', node_uid, 'processor', 'cache_l1'),
          :cache_l1i          => lookup('gpuclus_generated', node_uid, 'processor', 'cache_l1i'),
          :cache_l1d          => lookup('gpuclus_generated', node_uid, 'processor', 'cache_l1d'),
          :cache_l2           => lookup('gpuclus_generated', node_uid, 'processor', 'cache_l2'),
          :cache_l3           => lookup('gpuclus_generated', node_uid, 'processor', 'cache_l3')
        })

        main_memory({
          :ram_size     => lookup('gpuclus_generated', node_uid, 'main_memory', 'ram_size'),
          :virtual_size => nil
        })

        operating_system({
          :name     => "debian",
          :release  => "Wheezy",
          :version  => "7",
          :kernel   => "3.16.0-4-amd64"
        })

        storage_devices [{
          :interface  => 'SCSI',
          :size       => lookup('gpuclus_generated', node_uid, 'block_devices', 'sda', 'size'),
          :driver     => "megaraid_sas",
          :device     => lookup('gpuclus_generated', node_uid, 'block_devices', 'sda', 'device'),
          :model      => lookup('gpuclus_generated', node_uid, 'block_devices', 'sda', 'model'),
          :vendor     => lookup('gpuclus_generated', node_uid, 'block_devices', 'sda', 'vendor'),
          :rev        => lookup('gpuclus_generated', node_uid, 'block_devices', 'sda', 'rev'),
          :storage    => 'HDD'
        }]

        network_adapters [{
          :interface        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'interface'),
          :rate             => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'rate'),
          :enabled          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'enabled'), 
          :management       => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'management'),
          :mountable        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'mountable'),
          :mounted          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'mounted'),
          :bridged          => false,
          :device           => "eth0",
          :vendor           => 'Broadcom',
          :model            => 'Broadcom 57800 10 GB DA/SFP+',
          :driver           => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'driver'),
          :mac              => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth0', 'mac')
        },
        {
          :interface        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'interface'),
          :rate             => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'rate'),
          :enabled          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'enabled'),
          :management       => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'management'),
          :mountable        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'mountable'),
          :mounted          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'mounted'),
          :device           => "eth1",
          :bridged          => false,
          :vendor           => 'Broadcom',
          :model            => 'Broadcom 57800 10 GB DA/SFP+',
          :driver           => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'driver'),
          :mac              => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth1', 'mac')
        },
        {
          :interface        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'interface'),
          :rate             => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'rate'),
          :enabled          => true,
          :management       => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'management'),
          :mountable        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'mountable'),
          :mounted          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'mounted'),
          :device           => "eth2",
          :network_address  => "#{node_uid}.#{site_uid}.grid5000.fr",
          :bridged          => true,
          :vendor           => 'Broadcom',
          :model            => 'Broadcom 57800 1 GB Base-T',
          :driver           => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'driver'),
          :ip               => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'ip'),
          #:ip6              => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'ip6'),
          #:switch           => net_switch_lookup('nancy', 'gpuclus', node_uid, 'eth2'),
          #:switch_port      => net_port_lookup('nancy', 'gpuclus', node_uid, 'eth2'),
          :mac              => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth2', 'mac')
        },
        {
          :interface        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'interface'),
          :rate             => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'rate'),
          :enabled          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'enabled'),
          :management       => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'management'),
          :mountable        => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'mountable'),
          :mounted          => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'mounted'),
          :device           => "eth3",
          :bridged          => false,
          :vendor           => 'Broadcom',
          :model            => 'Broadcom 57800 1 GB Base-T',
          :driver           => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'driver'),
          :mac              => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'eth3', 'mac')
        },
        {
          :interface            => 'Ethernet',
          :rate                 => 1.G,
          :network_address      => "#{node_uid}-bmc.#{site_uid}.grid5000.fr",
          :ip                   => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'bmc', 'ip'),
          :mac                  => lookup('gpuclus_generated', node_uid, 'network_interfaces', 'bmc', 'mac'),
          :enabled              => true,
          :mounted              => false,
          :mountable            => false,
          :management           => true,
          :device               => "bmc"
        }]

        chassis({
          :serial       => lookup('gpuclus_generated', node_uid, 'chassis', 'serial_number'),
          :name         => lookup('gpuclus_generated', node_uid, 'chassis', 'product_name'),
          :manufacturer => lookup('gpuclus_generated', node_uid, 'chassis', 'manufacturer')
        })

        bios({
          :version      => lookup('gpuclus_generated', node_uid, 'bios', 'version'),
          :vendor       => lookup('gpuclus_generated', node_uid, 'bios', 'vendor'),
          :release_date => lookup('gpuclus_generated', node_uid, 'bios', 'release_date')
        })

        monitoring({
          :wattmeter  => false
        })

        sensors({
        })
        gpu({
          :gpu         =>  true,
          :gpu_count   =>  2,
          :gpu_vendor  =>  "Nvidia",
          :gpu_model   =>  "GTX 980",
        })

      end
    end
 end # cluster gpuclus
end
