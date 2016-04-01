site :sophia do |site_uid|
  name "Sophia-Antipolis"
  location "Sophia-Antipolis, France"
  web "http://www.grid5000.fr/mediawiki/index.php/Sophia:Home"
  description "Grid'5000 Sophia-Antipolis site"
  latitude 43.6161
  longitude 7.0678
  email_contact "support-staff@lists.grid5000.fr"
  sys_admin_contact "support-staff@lists.grid5000.fr"
  security_contact "support-staff@lists.grid5000.fr"
  user_support_contact "support-staff@lists.grid5000.fr"
  compilation_server false
  kavlan_ip_range "10.32.0.0/14"
  virt_ip_range "10.164.0.0/14"
  storage5k true
  production true

  g5ksubnet({
    :network => '10.164.0.0/14',
    :gateway => '10.167.255.254'
  })

  kavlans({
    'default' => {
      :network => '172.16.128.0/20',
      :gateway => '172.16.143.254'
    },
    '1' => {
      :network => '192.168.192.0/20',
      :gateway => '172.16.143.121'
    },
    '2' => {
      :network => '192.168.208.0/20',
      :gateway => '172.16.143.122'
    },
    '3' => {
      :network => '192.168.224.0/20',
      :gateway => '172.16.143.123'
    },
    '4' => {
      :network => '10.32.0.0/18',
      :gateway => '10.32.63.254'
    },
    '5' => {
      :network => '10.32.64.0/18',
      :gateway => '10.32.127.254'
    },
    '6' => {
      :network => '10.32.128.0/18',
      :gateway => '10.32.191.254'
    },
    '7' => {
      :network => '10.32.192.0/18',
      :gateway => '10.32.255.254'
    },
    '8' => {
      :network => '10.33.0.0/18',
      :gateway => '10.33.63.254'
    },
    '9' => {
      :network => '10.33.64.0/18',
      :gateway => '10.33.127.254'
    },
    '18' => {
      :network => '10.35.192.0/18',
      :gateway => '10.35.255.254'
    },
  })

end
