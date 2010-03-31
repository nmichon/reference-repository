require 'fileutils'
require 'restfully'
require 'json'
require 'logger'

LIB_DIR = File.expand_path File.dirname(__FILE__)+'/generators/lib'
$LOAD_PATH.unshift(LIB_DIR) unless $LOAD_PATH.include?(LIB_DIR)

require 'grid5000'

RESTFULLY_CONFIGURATION_FILE = File.expand_path("~/.restfully/api.grid5000.fr.yml")

task :environment do
  @logger = Logger.new(STDOUT)
end

namespace :oar do
  desc "Generates the oarnodesetting lines"
  task :generate => :environment do
    # GET diff between v1 and v2
    # selon ajout/suppression/modification/...
    fail "You must specify a commit id from where to start" if ENV['FROM'].nil? || ENV['FROM'].empty?
    ENV['TO'] ||= 'HEAD'
    commands = []
    Restfully::Session.new(:configuration_file => File.expand_path(ENV['CONFIG'] || RESTFULLY_CONFIGURATION_FILE), :logger => @logger) do |grid5000, session|
      diff = session.get("./grid5000/versions/#{ENV['FROM']}/diff/#{ENV['TO']}", :headers => {'Accept' => "text/plain", "Cache-Control" => "no-cache"})
      diff.body.split("\n").each do |line|
        action, filename = line.split("\t")
        host = [filename.split("/").values_at(-1, -5, -7), "fr"].flatten.join(".")
        p host
        
        command = "oaradmin resources"
        
        case action
        when "A", "C", "M"
          node_properties = session.get(".#{filename}", :query => {:version => ENV['TO']}, :headers => {'Accept' => 'application/json'}).body
          cluster_properties = session.get(".#{filename.gsub(%r{/nodes.*}, '')}", :query => {:version => ENV['TO']}, :headers => {'Accept' => 'application/json'}).body
          node = Grid5000::Node.new(URI.join(grid5000.uri, URI.parse(".#{filename}")), cluster_properties, node_properties)
          export = node.export("oar-2.4")
          if action == "M"  # modification of a file
            command.concat(" -s /node=#{host}")
          else              # new file
            command.concat(" -a /node=#{host}/cpu={#{node.properties['architecture']['smp_size']}}/core={#{export['cpucore']}}")
          end
          command.concat( export.to_a.map{|(k,v)|
            [k, v.inspect].join("=")
          }.join("-p ") )          
        when "D"            # deletion of a file
          command.concat(" -d /node=#{host}")
        else 
          @logger.warn "Don't know what to do with #{line.inspect}. Ignoring."
          next
        end
        commands << command
      end
      p commands
    end
  end
  
  desc "Executes the commands required to update the OAR database after a change in the Reference repository"
  task :update => :generate do
    
  end
end
