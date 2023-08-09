require 'open3'
require 'json'

logfile_path = '/tmp/rc_client_log.json'
process_command = ARGV[0]
process_arguments = ARGV[1]
process_command_line = "#{process_command} #{process_arguments}"

# File creation
stdout, stderr, status = Open3.capture3(process_command_line)

if status.exitstatus == 0
  process_id = status.pid

  File.open(logfile_path, 'a+') do |logfile|
    logfile.write({
      timestamp: Time.new,
      user: ENV['USER'],
      processName: process_command,
      processCommandLine: process_command_line,
      processId: process_id
    }.to_json)
    logfile.write "\n"
  end
else
  STDERR.puts "There was an error running the command."
  STDERR.puts status.inspect
end


