site :rennes do |site_uid|
  name "Rennes"
  location "Rennes, France"
  web "http://www.irisa.fr"
  description "Grid5000 Rennes site"
  latitude 48.1000
  longitude -1.6667
  email_contact "support-staff@lists.grid5000.fr"
  sys_admin_contact "support-staff@lists.grid5000.fr"
  security_contact "support-staff@lists.grid5000.fr"
  user_support_contact "support-staff@lists.grid5000.fr"
  compilation_server false
  kavlan_ip_range "10.24.0.0/14"
  virt_ip_range "10.156.0.0/14"
  storage5k true
  production true

  g5ksubnet({
    :network => '10.156.0.0/14',
    :gateway => '10.159.255.254'
  })

  kavlans({
    'default' => {
      :network => '172.16.96.0/20',
      :gateway => '172.16.111.254'
    },
    '1' => {
      :network => '192.168.192.0/20',
      :gateway => '172.16.111.101'
    },
    '2' => {
      :network => '192.168.208.0/20',
      :gateway => '172.16.111.102'
    },
    '3' => {
      :network => '192.168.224.0/20',
      :gateway => '172.16.111.103'
    },
    '4' => {
      :network => '10.24.0.0/18',
      :gateway => '10.24.63.254'
    },
    '5' => {
      :network => '10.24.64.0/18',
      :gateway => '10.24.127.254'
    },
    '6' => {
      :network => '10.24.128.0/18',
      :gateway => '10.24.191.254'
    },
    '7' => {
      :network => '10.24.192.0/18',
      :gateway => '10.24.255.254'
    },
    '8' => {
      :network => '10.25.0.0/18',
      :gateway => '10.25.63.254'
    },
    '9' => {
      :network => '10.25.64.0/18',
      :gateway => '10.25.127.254'
    },
    '16' => {
      :network => '10.27.192.0/18',
      :gateway => '10.27.255.254'
    },
  })

end
