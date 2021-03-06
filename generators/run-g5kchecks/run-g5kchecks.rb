# This script reserves nodes and then runs g5k-check as root using the g5kadmin credentials.
#
# Usage: cd run-g5kcheck; ruby run-g5kchecks.rb
#
# - You can edit the node reservation at the beginning of the script (or create reservation manually).
# - The script will run g5k-checks on every nodes that have been reserved.
# - Output YAML files of g5k-checks are stored in output/
# - If an output YAML file already exist in ouput/, the execution of g5k-check on the corresponding node is skipped.
# - Use postprocessing.rb for moving the file in the input/ directory. This script also edits some keys of the YAML files.

require 'optparse'
require 'fileutils'
require 'cute'
require 'peach'
require '../lib/input_loader'
require 'pp'

if RUBY_VERSION < "2.1"
  puts "This script requires ruby >= 2.1"
  exit
end

# puts 'Init ruby-cute'
$g5k = Cute::G5K::API.new()
# puts '...done'

# puts 'Get site_uids'
begin
  sites = $g5k.site_uids()
rescue Exception => e
  puts "Error while getting the site list with ruby-cute: #{e.class}: #{e.message}"
  puts "API unavailable ?"
  refapi = load_yaml_file_hierarchy("../../input/grid5000/")
  sites = refapi["sites"].keys
end
# puts '...done'

#
# Parse command line parameters
#

options = {}
options[:sites] = sites # %w{grenoble lille luxembourg lyon nancy nantes rennes sophia}

OptionParser.new do |opts|
  opts.banner = "Usage: run-g5kchecks.rb [options]"

  opts.separator ""
  opts.separator "Example: ruby run-g5kchecks.rb -s nancy -n graoully-1         # make a reservation on graoully-1 and run g5k-checks"
  opts.separator "         ruby run-g5kchecks.rb -s nancy -n graoully-1 --force # run g5k-checks without making a reservation (for dead node)"
  # opts.separator "         ruby run-g5kchecks.rb                                # make a reservation on every nodes"      

  ###

  opts.separator ""
  opts.separator "Filters:"

  opts.on('-s', '--sites a,b,c', Array, 'Select site(s)',
          "Default: "+options[:sites].join(", ")) do |s|
    raise "Wrong argument for -s option." unless (s - options[:sites]).empty?
    options[:sites] = s
  end

  opts.on('-c', '--clusters a,b,c', Array, 'Select clusters(s). Default: all') do |s|
    options[:clusters] = s
  end

  opts.on('-n', '--nodes a,b,c', Array, 'Select nodes(s). Default: all') do |n|
    options[:nodes] = n
  end

  ###

  opts.separator ""
  opts.separator "Node reservation options:"

  opts.on('-qQUEUE', '--queue=queue', String, 'Specify an OAR reservation queue') do |q|
    options[:queue] = q
  end

  opts.on('-f', '--force', 
          'Run g5k-checks on the nodes without any OAR reservation', 
          'This option is meant to be used for dead nodes',
          'or if you already reserved the ressources') do |f|
    options[:force] = true
  end

  ###
  ###

  ###

  opts.separator ""
  opts.separator "SSH options:"

  opts.on('--ssh-keys k1,k2,k3', Array, 'SSH keys') do |k|
    options[:ssh] ||= {}
    options[:ssh][:params] ||= {}
    options[:ssh][:params][:keys] ||= []
    options[:ssh][:params][:keys] << k
  end
  
  ###

  opts.separator ""
  opts.separator "Common options:"
  
  # Print an options summary.
  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  if ARGV.empty?
    printf "No option is specified. Run g5k-checks on the entire platform ? (y/N) "
    prompt = STDIN.gets.chomp
    if prompt != 'y'
      puts opts
      exit
    end
  end

end.parse!

options[:ssh] ||= {}
options[:ssh][:user] = 'g5kadmin'        unless options[:ssh][:user]
options[:ssh][:host] = '%s.g5kadmin' unless options[:ssh][:host]
options[:ssh][:params] ||= {:timeout => 10}

options[:queue] ||= 'admin'

puts "Options: #{options}" if options[:verbose]

#
#
#

FileUtils::mkdir_p("output/")

# fnode_uid = fully qualified name (node.site.nancy.grid5000.fr)
def run_g5kcheck(site_uid, fnode_uid, options)
  puts "#{site_uid}: Processing #{fnode_uid}"

  begin
    Net::SSH.start(options[:ssh][:host].gsub("%s", site_uid), options[:ssh][:user], options[:ssh][:params]) { |ssh|
      output1 = ssh.exec!("sudo ssh -o StrictHostKeychecking=no root@#{fnode_uid} 'sudo /usr/bin/g5k-checks -m api'")
      output2 = ssh.exec!("sudo ssh -q -o StrictHostKeychecking=no root@#{fnode_uid} 'cat /tmp/#{fnode_uid}.yaml'")

      if output2 == ''
        puts output1 # ex: "ssh: connect to host graphite-1.nancy.grid5000.fr port 22: No route to host\r\n"
      else
        File.open("output/#{fnode_uid}.yaml", 'w') do |f|
          f.write(output2) 
        end
      end
    }
  rescue Exception => e
    puts "#{site_uid}: Error while processing #{fnode_uid} - #{e.class}: #{e.message}"
  end
end

def oarsub(site_uid, resources, queue)
  job = nil

  begin
    job = $g5k.reserve(:site => site_uid, :resources => resources, :walltime => '00:30:00', :wait => false, :queue => queue)

  rescue Exception => e
    puts "#{site_uid}: Error during the reservation '#{resources}' at #{site_uid} - #{e.class}: #{e.message}"
  end

  return job
end

if options[:force]
  
  # puts 'Get input/'
  refapi_hash = load_yaml_file_hierarchy("../../input/grid5000/") # use input/ has nodes might not be register in OAR db yet (for new clusters installation)
  # puts '...done'

  run_queue ||= {}

  # Safeguard. Ask before running g5k-checks on reserved nodes (We should not interfere with user experiments)
  prompt = ''
  options[:sites].each { |site_uid|
    run_queue[site_uid] ||= []

    # puts "Get node status at #{site_uid}"
    nodes_status = nil # postpone query
    # puts '...done'

    refapi_hash['sites'][site_uid]["clusters"].peach { |cluster_uid, cluster|
      next if options[:clusters] && ! options[:clusters].include?(cluster_uid)
      
      cluster["nodes"].each_sort_by_node_uid { |node_uid, node|
        next if options[:nodes] && ! options[:nodes].include?(node_uid)

        fnode_uid = "#{node_uid}.#{site_uid}.grid5000.fr"
        
        if File.exist?("output/#{fnode_uid}.yaml")
          puts "output/#{fnode_uid}.yaml exist. Remove this file if you want to run g5k-checks again on this node."
          next
        end

        if nodes_status.nil?
          begin
            nodes_status = $g5k.nodes_status(site_uid)
          rescue Exception => e
            nodes_status = {} # do not retry
            puts "Error while getting nodes status at #{site_uid}" #{e}
            #next continue anyway as the --force option might be used for a new cluster that is not available yet in the reference-api
          end
        end

        if prompt != 'yes-all' && nodes_status[fnode_uid] && nodes_status[fnode_uid] == "busy"
          if prompt != 'no-all'
            printf "#{site_uid} - #{node_uid} is busy (ie. there is currently an OAR reservation. Run g5k-checks on reserved nodes ? (y/yes-all/no-all/N) "
            prompt = STDIN.gets.chomp
            run_queue[site_uid] << fnode_uid if prompt == 'y' || prompt == 'yes-all'
          end
        else
          run_queue[site_uid] << fnode_uid
        end
        
      }
    }
  }

  # Actual run
  run_queue.peach { |site_uid, q|
    q.peach(5) { |fnode_uid|
      run_g5kcheck(site_uid, fnode_uid, options)
    }
  }

else # ! options[:force]

  begin
    jobs = {} # list of OAR reservation
    released_jobs = {};

    options[:sites].peach  { |site_uid|

      jobs[site_uid] = [] # list of OAR reservation
      released_jobs[site_uid] = {};

      begin

        #
        # Node reservation
        #
        
        begin
          nodes_status = $g5k.nodes_status(site_uid)
        rescue Exception => e
          puts "Error while getting nodes status at #{site_uid}" #{e}
          next
        end

        if options[:nodes]        

          # Reserve nodes one by one
          options[:nodes].each { |uid| 
            node_uid = uid.split('.')[0] # entries might be either 'node' or 'node.site.grid5000.fr'
            fnode_uid = "#{node_uid}.#{site_uid}.grid5000.fr"

            cluster_uid = node_uid.split(/-/).first
            next if options[:clusters] && ! options[:clusters].include?(cluster_uid) # -c and -n info should be consistent
            next if ! nodes_status.keys.include?(fnode_uid)                          # the node does not belong to this site

            if File.exist?("output/#{fnode_uid}.yaml")
              puts "output/#{fnode_uid}.yaml exist. Remove this file if you want to run g5k-checks again on this node."
              next
            end
            
            jobs[site_uid] << oarsub(site_uid, "{host='#{fnode_uid}'}", options[:queue]) 
          }
          
        else

          clusters = $g5k.cluster_uids(site_uid)
          
          # Reserve as many free node as possible in one reservation
          if options[:clusters]
            options[:clusters].each { |cluster_uid|
              jobs[site_uid] << oarsub(site_uid, "{cluster='#{cluster_uid}'}/nodes=BEST", options[:queue]) if clusters.include?(cluster_uid)
            }
          else
            jobs[site_uid] << oarsub(site_uid, "nodes=BEST", options[:queue])
          end
          
          # Reserve busy nodes one by one
          nodes_status.each { |fnode_uid, status|
            cluster_uid = fnode_uid.split(/-/).first
            next if options[:clusters] && ! options[:clusters].include?(cluster_uid)
            next if File.exist?("output/#{fnode_uid}.yaml") # skip reservation if we alread have the node info
            next if status != "busy"                        # only busy nodes
            
            if File.exist?("output/#{fnode_uid}.yaml")
              puts "output/#{fnode_uid}.yaml exist. Remove this file if you want to run g5k-checks again on this node."
              next
            end

            jobs[site_uid] << oarsub(site_uid, "{host='#{fnode_uid}'}", options[:queue])
          }
          
        end
        
        #
        # Process running jobs
        #
        
        loop do
          waiting_jobs   = $g5k.get_my_jobs(site_uid, state='waiting')
          running_jobs   = $g5k.get_my_jobs(site_uid, state='running')
          launching_jobs = $g5k.get_my_jobs(site_uid, state='launching')
          
          puts "#{site_uid}: Running: #{running_jobs.size} - Waiting: #{waiting_jobs.size} - Launching: #{launching_jobs.size}"
          
          running_jobs.each { |job|
            job_uid = job['uid']

            next unless jobs[site_uid].any? { |j| j['uid'] == job_uid } # skip reservations that are not related to this script
            
            if released_jobs[site_uid][job_uid]
              puts "#{site_uid}: #{job_uid} already processed (waiting for job termination)" # OAR job deletions can take some times
              next
            end
            
            puts "#{site_uid}: Processing #{job_uid}"
            
            job['assigned_nodes'].peach(10) { |fnode_uid|
              
              next if File.exist?("output/#{fnode_uid}.yaml")
              
              run_g5kcheck(site_uid, fnode_uid, options)
              
            }
            
            puts "#{site_uid}: Release #{job_uid}"
            begin
              $g5k.release(job)
              released_jobs[site_uid][job_uid] = true
            rescue Exception => e
              puts "#{site_uid}: Error while releasing job #{job_uid} - #{e.class}: #{e.message}"
            end
          }
          
          # Stop when there isn't any job left
          break    if running_jobs.empty? and waiting_jobs.empty? and launching_jobs.empty?
          
          # Wait a little bit when the previous loop iteration did not find any job to process
          sleep(5) if running_jobs.empty?
          
        end
        
      end # begin
      
    } # options[:sites].peach
    
  rescue Exception => e
    puts "#{e.class}: #{e.message}"
  ensure
    jobs.each{|site_uid, jobs| jobs.compact.each { |job|
        begin
          job_uid = job['uid']
          if released_jobs[site_uid][job_uid] != true
            puts "Release job #{job['links'][0]['href']}"
            $g5k.release(job)
          end
        rescue Exception => e
          puts "Failed releasing job #{job['links'][0]['href']} - #{e.class}: #{e.message}"
        end
      }
    }
    exit
  end
  
end # options[:force]

stdout_str, stderr_str, status = Open3.capture3('ruby postprocessing.rb')
puts stdout_str
puts stderr_str
