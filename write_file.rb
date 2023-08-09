require 'open3'
require 'json'

logfile_path = '/tmp/rc_client_log.json'

input_file_path = ARGV[0]
output_file_path = ARGV[1]
`rm -f #{output_file_path}` # remove if already present

file_command = "cp #{input_file_path} #{output_file_path}"

# File creation
stdout, stderr, status = Open3.capture3(file_command)

if status.exitstatus == 0
  process_id = status.pid

  File.open(logfile_path, 'a+') do |logfile|
    logfile.write({
      timestamp: Time.new,
      filePath: output_file_path,
      activity: :create,
      user: ENV['USER'],
      processName: 'cp',
      processCommandLine: file_command,
      processId: process_id
    }.to_json)
    logfile.write "\n"
  end
else
  STDERR.puts "There was an error running the command."
  STDERR.puts status.inspect
end



