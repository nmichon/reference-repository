site :orsay do |site_uid|
  name "Orsay"
  location "Orsay, France"
  web
  description ""
  latitude
  longitude
  email_contact
  sys_admin_contact
  security_contact
  user_support_contact
  %w{sid-x64-base-1.0}.each{|env_uid| environment env_uid, :refer_to => "grid5000/environments/#{env_uid}"}

  cluster :netgdx do |cluster_uid|
    model "IBM eServer 326m"
    created_at nil
    misc "bios:1.28/bcm:1.20.17/bmc:1.10/rsaII:1.00"
    30.times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|
        architecture({
          :smp_size => 2, 
          :smt_size => 2,
          :platform_type => "x86_64"
          })
        processor({
          :vendor => "AMD",
          :model => "AMD Opteron",
          :version => "246",
          :clock_speed => 2.giga,
          :instruction_set => "",
          :other_description => "",
          :cache_l1 => nil,
          :cache_l1i => nil,
          :cache_l1d => nil,
          :cache_l2 => 1.MB
        })
        main_memory({
          :ram_size => 2.GB(true), # bytes
          :virtual_size => nil
        })
        operating_system({
          :name => nil,
          :release => nil,
          :version => nil
        })
        storage_devices [
          {:interface => 'SATA', :size => 80.GB(false), :driver => nil}
          ]
        network_adapters [
          {:interface => 'Ethernet', :rate => 1.giga, :enabled => true, 
            :switch => nil, :network_address => "#{node_uid}.#{site_uid}.grid5000.fr", :ip => dns_lookup("#{node_uid}.#{site_uid}.grid5000.fr"),
            :driver => nil},          
          {:interface => 'Ethernet', :rate => 1.giga, :enabled => true, :driver => nil},
          {:interface => 'Ethernet', :rate => 1.giga, :enabled => true, :driver => nil}
          ]  
      end      
    end
  end # cluster net-gdx
  
  cluster :gdx do |cluster_uid|
    model "IBM eServer 326m"
    created_at nil
    misc "bios:1.28/bcm:1.20.17/bmc:1.10/rsaII:1.00"
    
    (186+126).times do |i|
      node "#{cluster_uid}-#{i+1}" do |node_uid|
        architecture({
          :smp_size => 2, 
          :smt_size => 2,
          :platform_type => "x86_64"
          })
        processor({
          :vendor => "AMD",
          :model => "AMD Opteron",
          :version => "246",
          :clock_speed => 2.giga,
          :instruction_set => "",
          :other_description => "",
          :cache_l1 => nil,
          :cache_l1i => nil,
          :cache_l1d => nil,
          :cache_l2 => 1.MB
        })
        main_memory({
          :ram_size => 2.GB(true), # bytes
          :virtual_size => nil
        })
        operating_system({
          :name => nil,
          :release => nil,
          :version => nil
        })
        storage_devices [
          {:interface => 'SATA', :size => 80.GB(false), :driver => nil}
          ]
        network_adapters [  
          {:interface => 'Myri-10G', :rate => 10.giga, :enabled => true, 
            :switch => nil, :network_address => "#{node_uid}.#{site_uid}.grid5000.fr", :ip => dns_lookup("#{node_uid}.#{site_uid}.grid5000.fr"),
            :vendor => "Myrinet", :version => "10G-PCIE-8A-C"},
          {:interface => 'Ethernet', :rate => 1.giga, :enabled => true},
          {:interface => 'Ethernet', :rate => 1.giga, :enabled => false}
          ]
      end        
    end
    
    # extension specifics, starting at node 187
    126.times do |i|
      node "#{cluster_uid}-#{186+i+1}" do
        processor({
          :version => "250",
          :clock_speed => 2.4.giga
        })
      end
    end
    
  end # cluster gdx
  
end