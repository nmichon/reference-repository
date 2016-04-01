site :luxembourg do |site_uid|
  name "Luxembourg"
  location "Luxembourg, Luxembourg"
  web "https://www.grid5000.fr/mediawiki/index.php/Luxembourg:Home"
  description "Grid'5000 Luxembourg site"
  latitude 49.626595
  longitude 6.158676
  email_contact "support-staff@lists.grid5000.fr"
  sys_admin_contact "support-staff@lists.grid5000.fr"
  security_contact "support-staff@lists.grid5000.fr"
  user_support_contact "support-staff@lists.grid5000.fr"
  compilation_server false
  kavlan_ip_range "10.40.0.0/14"
  virt_ip_range "10.172.0.0/14"
  storage5k true
  production true

  g5ksubnet({
    :network => '10.172.0.0/14',
    :gateway => '10.175.255.254'
  })

  kavlans({
    'default' => {
      :network => '172.16.176.0/20',
      :gateway => '172.16.191.254'
    },
    '1' => {
      :network => '192.168.192.0/20',
      :gateway => '172.16.191.121'
    },
    '2' => {
      :network => '192.168.208.0/20',
      :gateway => '172.16.191.122'
    },
    '3' => {
      :network => '192.168.224.0/20',
      :gateway => '172.16.191.123'
    },
    '4' => {
      :network => '10.40.0.0/18',
      :gateway => '10.40.63.254'
    },
    '5' => {
      :network => '10.40.64.0/18',
      :gateway => '10.40.127.254'
    },
    '6' => {
      :network => '10.40.128.0/18',
      :gateway => '10.40.191.254'
    },
    '7' => {
      :network => '10.40.192.0/18',
      :gateway => '10.40.255.254'
    },
    '8' => {
      :network => '10.41.0.0/18',
      :gateway => '10.41.63.254'
    },
    '9' => {
      :network => '10.41.64.0/18',
      :gateway => '10.41.127.254'
    },
    '20' => {
      :network => '10.43.192.0/18',
      :gateway => '10.43.255.254'
    },
  })

end
