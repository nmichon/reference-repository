environment 'lenny-x64-big-2.3' do
  state "stable"
  file({:path => "/grid5000/images/lenny-x64-big-2.3.tgz", :md5 => "e5870c72c1a5386c287935dcf39a8a23"})
  kernel "2.6.26.2"
  available_on %w{bordeaux grenoble lille lyon nancy orsay reims rennes sophia toulouse}
  valid_on "bordeplage , bordereau , borderline ,  adonis , edel , genepi , chicon , chimint , chinqchint , chirloute , capricorne , sagittaire , graphene , griffon , gdx , netgdx , stremi , paradent , paramount , parapide , parapluie , helios , sol , suno, pastel , violette"
  based_on "Debian version lenny for amd64"
  consoles [{:port => "ttyS0", :bps => 34800}]
  services []
  accounts [{:login => "root", :password => "grid5000"}]
  applications "Vim, XEmacs, JED, nano, JOE, Perl, Python, Ruby".split(", ")
  x11_forwarding true
  max_open_files 8192
  tcp_bandwidth 1.G
end
