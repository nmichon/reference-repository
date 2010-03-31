require 'fileutils'
require 'json'
require 'logger'

ROOT_DIR = File.expand_path File.dirname(__FILE__)
LIB_DIR = File.join(ROOT_DIR, "generators", "lib")
$LOAD_PATH.unshift(LIB_DIR) unless $LOAD_PATH.include?(LIB_DIR)

require 'grid5000'

task :environment do
  Dir.chdir(ROOT_DIR)
  @logger = Logger.new(STDERR)
  @logger.level = Logger.const_get((ENV['DEBUG'] || 'INFO').upcase)
end


# TESTS
# deletion: 4cfebf92e9cce05315782b51e05eded4ab4f0e7e..7d2648eaad7dbbc6f1fdb9c0279f73d374ccd47a
# update: 7d2648eaad7dbbc6f1fdb9c0279f73d374ccd47a..bb528643003757942521942eaeab74b15aaa976d
# add: be9f7338b9750ce675447c13d172157992041ec1..7dc3a4101a657230b7ad0534025a7ca93c905411
# all be9f7338b9750ce675447c13d172157992041ec1..7d2648eaad7dbbc6f1fdb9c0279f73d374ccd47a
namespace :oar do
  desc "Generates the oarnodesetting lines to update OAR database after a change in the reference repository"
  task :generate => :environment do
    @logger.info "You MUST already have pushed your changes to the master reference repository. Abort if it's not the case."
    if ENV['FROM'].nil? || ENV['FROM'].empty?
      @logger.fatal "You MUST specify a commit id from where to start using the FROM=xx argument." 
      exit(1)
    end
    ENV['TO'] ||= 'HEAD'
    @logger.info "Analysing changes between #{ENV['FROM']}..#{ENV['TO']}..."
    
    commands = []
    diff = `git diff --name-status #{ENV['FROM']}..#{ENV['TO']}`
    
    diff.split("\n").each do |line|
      action, filename = line.split("\t")
      next unless filename =~ %r{.+/nodes/.+}
      
      node_uid, site_uid, grid_uid = filename.gsub(/\.json/,'').split("/").values_at(-1, -5, -7)
      cluster_uid = node_uid.split("-")[0]
      host = [node_uid, site_uid, grid_uid, "fr"].flatten.join(".")
      
      if ENV['SITE'] && !ENV['SITE'].split(",").include?(site_uid)
        @logger.info "Skipping #{host} since you only want changes that occured on #{ENV['SITE'].inspect}"
        next
      end
      
      command = "oaradmin resources"
      
      case action
      when "A", "C", "M"
        node_properties = JSON.parse(File.read(filename))
        cluster_properties = JSON.parse(File.read(filename.gsub(%r{/nodes.*}, "/#{cluster_uid}.json")))
        cluster = Grid5000::Cluster.new(cluster_properties)
        node = Grid5000::Node.new(cluster, node_properties)
        begin
          export = node.export("oar-2.4")
        rescue Grid5000::MissingProperty => e
          @logger.warn "Error when exporting #{host}: #{e.message}. Skipped."
          next
        end
        if action == "M"  # modification of a file
          command.concat(" -s node=#{host} ")
        else              # new file
          command.concat(" -a node=#{host}/cpu={#{node.properties['architecture']['smp_size']}}/core={#{export['cpucore']}} ")
        end
        command.concat(" -p ").concat( export.to_a.map{|(k,v)|
          if v.nil?
            nil
          elsif v.kind_of?(String) && v =~ / / # to remove after oaradmin correctly parses options
            [k, v.inspect.inspect].join("=")
          else
            [k, v.inspect].join("=")
          end
        }.compact.join(" -p ") )          
      when "D"            # deletion of a file
        command.concat(" -d node=#{host}")
      else 
        @logger.warn "Don't know what to do with #{line.inspect}. Ignoring."
        next
      end
      commands << command
    end
    commands.each do |command|
      puts command
    end
  end
end
