site :reims do |site_uid|
  name "Reims"
  location "Reims, France"
  web "http://www.grid5000.fr/mediawiki/index.php/Reims:Home"
  description "Grid5000 Reims site"
  latitude 49.244508
  longitude 4.062714
  email_contact "support-staff@lists.grid5000.fr"
  sys_admin_contact "support-staff@lists.grid5000.fr"
  security_contact "support-staff@lists.grid5000.fr"
  user_support_contact "support-staff@lists.grid5000.fr"
  compilation_server false
  kavlan_ip_range "10.36.0.0/14"
  virt_ip_range "10.168.0.0/14"
  storage5k false
  production true

  g5ksubnet({
    :network => '10.168.0.0/14',
    :gateway => '10.171.255.254'
  })

  kavlans({
    'default' => {
      :network => '172.16.160.0/20',
      :gateway => '172.16.175.254'
    },
    '1' => {
      :network => '192.168.192.0/20',
      :gateway => '172.16.175.121'
    },
    '2' => {
      :network => '192.168.208.0/20',
      :gateway => '172.16.175.122'
    },
    '3' => {
      :network => '192.168.224.0/20',
      :gateway => '172.16.175.123'
    },
    '4' => {
      :network => '10.36.0.0/18',
      :gateway => '10.36.63.254'
    },
    '5' => {
      :network => '10.36.64.0/18',
      :gateway => '10.36.127.254'
    },
    '6' => {
      :network => '10.36.128.0/18',
      :gateway => '10.36.191.254'
    },
    '7' => {
      :network => '10.36.192.0/18',
      :gateway => '10.36.255.254'
    },
    '8' => {
      :network => '10.37.0.0/18',
      :gateway => '10.37.63.254'
    },
    '9' => {
      :network => '10.37.64.0/18',
      :gateway => '10.37.127.254'
    },
    '19' => {
      :network => '10.39.192.0/18',
      :gateway => '10.39.255.254'
    },
  })

end
