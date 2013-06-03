environment 'wheezy-x64-xen-1.0' do
  state "stable"
  file({:path => "/grid5000/images/wheezy-x64-xen-1.0.tgz", :md5 => "90e3e52ef39b98e802ccb5094aedc923"})
  kernel "3.2.0-4"
  available_on %w{bordeaux grenoble lille luxembourg lyon nancy reims rennes sophia toulouse}
  valid_on "bordereau , borderline ,  adonis , edel , genepi , chicon , chimint , chinqchint , chirloute , granduc , hercule, orion, sagittaire, taurus, graphene , griffon , stremi , paradent , paramount , parapide , parapluie , sol , suno, pastel"
  based_on "Debian version wheezy for amd64"
  consoles [{:port => "ttyS0", :bps => 34800}]
  services []
  accounts [{:login => "root", :password => "grid5000"}]
  applications %w{Vim XEmacs JED nano JOE Perl Python Ruby}
  x11_forwarding true
  max_open_files 65536
  tcp_bandwidth 1.G
end