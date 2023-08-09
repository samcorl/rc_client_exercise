require 'open3'
require 'json'

logfile_path = '/tmp/rc_client_log.json'

file_path = ARGV[0]

file_command = "rm #{file_path}"

# File creation
stdout, stderr, status = Open3.capture3(file_command)

if status.exitstatus == 0
  process_id = status.pid

  File.open(logfile_path, 'a+') do |logfile|
    logfile.write({
      timestamp: Time.new,
      filePath: file_path,
      activity: :delete,
      user: ENV['USER'],
      processName: 'rm',
      processCommandLine: file_command,
      processId: process_id
    }.to_json)
    logfile.write "\n"
  end
else
  STDERR.puts "There was an error running the command."
  STDERR.puts status.inspect
end


