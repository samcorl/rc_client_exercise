require 'open3'
require 'json'
require 'uri'

logfile_path = '/tmp/rc_client_log.json'

# use a custom endpoint or a service like https://public.requestbin.com/
post_url = ARGV[0]

# an optional token can be added to indicate specific requests
token = ARGV[1]

timestamp = Time.new.to_s

# try to derive LAN IP
lan_ip = `ipconfig getifaddr en0`.strip

# generate POST data
post_data = "url=#{post_url}&timestamp=#{timestamp}&lan_ip=#{lan_ip}&token=#{token}"

# set network command
network_command = "curl -v -s -d '#{post_data}' #{post_url}"

# Run command, capture result
stdout, stderr, status = Open3.capture3(network_command)

if status.exitstatus == 0
  process_id = status.pid

  # Set destination IP
  destination_ip = nil
  if matchTerm = stderr.split("\n").first.match(/Trying \d+.\d+.\d+.\d+/)
    destination_ip = matchTerm[0].gsub('Trying ', '')
  end

  # log result
  File.open(logfile_path, 'a+') do |logfile|
    logfile.write({
      timestamp: timestamp,
      destinationAddress: destination_ip,
      destinationPort: 443,
      sourceAddress: lan_ip,
      sourcePort: 443,
      dataSize: post_data.size,
      protocol: 'TCP',
      user: ENV['USER'],
      processName: 'curl',
      processCommandLine: network_command,
      processId: process_id
    }.to_json)
    logfile.write "\n"
  end
else
  STDERR.puts "There was an error running the command."
  STDERR.puts status.inspect
end


