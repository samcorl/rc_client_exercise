# RC Client Exercise

## Dependencies

I chose to use Ruby for this project because it is easily installed 
on all three target OS types and it is well suited for quick prototyping.

The `Open3` module was chosen to help with command execution 
for the process status reporting features.

This project includes five program files to be executed by Ruby. 
Details about each program file are below.

## Execution

Each program is executed individually. 
An example is provided in the "run.sh" file.


## Logging

All programs provided in this project append to a log file 
at `/tmp/rc_client_log.json`. If the execution of the program
is successful, a serialized log entry will be appended to this file.
If the program file does not exit successfully, a message is printed
to STDERR.

Each log entry in the file ends with a newline character. Log entries
are JSON-formatted strings representing the details of each program's
execution.

## Program Files

### start_process.rb

Usage: `ruby start_process.rb EXECUTABLE [ARGUMENTS] ;`

Takes two arguments: the executable to be run and an optional string with
any arguments to be passed to the executable.

This program executes the specified executable file, with 
arguments provided. 

### write_file.rb

Usage example: `ruby write_file.rb ORIGIN_FILE_PATH DESTINATION_FILE_PATH;`

Takes two arguments: the path of the source file to be copied and the
path for the copied file.

This program writes a specified file at a specified location by copying 
a source file. The example script `run.sh` copies this Readme file, but 
any file path can be specified, as long as the file is available to the
user executing the program.

### modify_file.rb

Usage example: `ruby modify_file.rb FILE_PATH;`

Takes one argument: the path of the file to be modified.

This program modifies a specified file by appending a string.

### delete_file.rb

Usage example: `ruby delete_file.rb FILE_PATH;`

Takes one argument: the path of the file to be deleted.

This program removes the specified file using the `rm` executable.


### network_transmission.rb

Usage example: `ruby network_transmission.rb URL [TOKEN];`

Takes two arguments: the URL to receive the data transmission and
an optional "token" to identify a specific transaction.

This program uses the `curl` executable to send a www-url-encoded
string as form data with the HTTP verb `POST`.


