site :qualif do |site_uid|
  
  cluster :itruc do |cluster_uid|
    model "Dell PowerEdge 1950"
    created_at Time.parse("2011-09-05").httpdate
    4.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|
        supported_job_types({:deploy => true, :besteffort => true, :virtual => "ivt"})
        architecture({
          :smp_size       => 2,
          :smt_size       => 4,
          :platform_type  => "x86_64"
        })
        
        processor({
          :vendor             => "Intel",
          :model              => "Intel Xeon",
          :version            => "5148 LV",
          :clock_speed        => 2.33.G,
          :instruction_set    => "",
          :other_description  => "",
          :cache_l1           => nil,
          :cache_l1i          => nil,
          :cache_l1d          => nil,
          :cache_l2           => nil          
        })
        main_memory({
          :ram_size     => 4.GiB,
          :virtual_size => nil
        })
        operating_system({
          :name     => "Debian",
          :release  => "5.0",
          :version  => nil,
          :kernel   => "2.6.26"
        })
        storage_devices [{
          :interface  => 'SATA',
          :size       => 160.GB,
          :driver     => "mptsas",
          :device     => "sda",
          :model      => lookup('qualif-itruc', node_uid, 'block_device', 'sda', 'model'),
          :rev        => lookup('qualif-itruc', node_uid, 'block_device', 'sda', 'rev')
        }]
        network_adapters [{
           :interface        => 'Ethernet',
           :rate             => 1.G,
           :enabled          => true,
           :management       => true,
           :mountable        => false,
           :mounted          => false,
           :device           => "bmc",
           :network_address  => "#{node_uid}-bmc.#{site_uid}.grid5000.fr",
           :ip               => lookup('qualif-itruc', node_uid, 'network_interfaces', 'bmc', 'ip'),
           :mac              => lookup('qualif-itruc', node_uid, 'network_interfaces', 'bmc', 'mac')
         },
         {
          :interface        => 'Ethernet',
          :rate             => 1.G,
          :enabled          => true,
          :management       => false,
          :mountable        => true,
          :mounted          => true,
          :device           => "eth0",
          :network_address  => "#{node_uid}.#{site_uid}.grid5000.fr",
          :ip               => lookup('qualif-itruc', node_uid, 'network_interfaces', 'eth0', 'ip'),
          :vendor           => "Broadcom",
          :version          => "NetXtreme II BCM5708",
          :driver           => "bnx2",
          :switch           => "c6509-grid",
          :switch_port      => lookup('qualif-itruc', node_uid, 'network_interfaces', 'eth0', 'switch_port'),
          :mac              => lookup('qualif-itruc', node_uid, 'network_interfaces', 'eth0', 'mac')
        },
        {
          :interface  => 'Ethernet',
          :rate       => 1.G,
          :enabled    => false,
          :device     => "eth1",
          :vendor     => "Broadcom",
          :version    => "NetXtreme II BCM5708",
          :driver     => "bnx2",
          :mac        => lookup('qualif-itruc', node_uid, 'network_interfaces', 'eth1', 'mac')
        }]
        bios({
           :version      => lookup('qualif-itruc', node_uid, 'bios', 'version'),
           :vendor       => lookup('qualif-itruc', node_uid, 'bios', 'vendor'),
           :release_date => lookup('qualif-itruc', node_uid, 'bios', 'release_date')
        })
        chassis({:serial_number => lookup('qualif-itruc', node_uid, 'chassis', 'serial_number')})
      end
    end
  end
  
end
