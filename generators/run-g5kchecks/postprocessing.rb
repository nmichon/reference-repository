#!/usr/bin/ruby

# This script does minor edits on the ouput of g5k-checks YAML files and moves the files to the right place in the input/ directory
#
# Usage: cd run-g5kcheck; ruby run-g5kchecks.rb; ruby postprocessing.rb

require 'pp'
require 'erb'
require 'fileutils'
require 'pathname'
require 'yaml'
require '../lib/hash/hash'

puts 'Postprocessing of output/. Copying files into ../../input/'

list_of_yaml_files = Dir['output/*.y*ml'].sort_by { |x| -x.count('/') }
list_of_yaml_files.each { |filename|
  file     = filename.split("/")[1]
  node_uid = file.split(".")[0]
  site_uid = file.split(".")[1]
  cluster_uid = node_uid.split("-")[0]

  hash = YAML::load_file(filename)
  if hash == false
    puts "Error found in #{filename}"
    next
  end

  hash["storage_devices"]  = hash.delete("block_devices")
  hash["storage_devices"]  = hash["storage_devices"].sort_by_array(["sda", "sdb", "sdc", "sdd", "sde"])
  hash["storage_devices"].each {|k, v| v.delete("device") }

  hash["network_adapters"] = hash.delete("network_interfaces")
  hash["network_adapters"] = hash["network_adapters"].sort_by_array(["eth0", "eth1", "eth2", "eth3", "eth4", "eth5", "eth6", "ib0", "ib1", "ib2", "ib3", "bmc"])
 
  hash["chassis"]["name"] = hash["chassis"].delete("product_name")
  hash["chassis"]["serial"] = hash["chassis"].delete("serial_number")

  hash = {node_uid => hash}
 
  new_filename = "../../input/grid5000/sites/#{site_uid}/clusters/#{cluster_uid}/nodes/" + node_uid + ".yaml"
  write_yaml(new_filename, hash)

  contents = File.read(new_filename)
  File.open(new_filename, 'w') { |file| 
    file.write("# Generated by g5k-checks (g5k-checks -m api)\n")
    file.write(contents) 
  }
}