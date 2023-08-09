ruby start_process.rb 'df' '-h' ;
ruby write_file.rb ./Readme.txt '/tmp/rc_client_test';
ruby modify_file.rb '/tmp/rc_client_test';
ruby delete_file.rb '/tmp/rc_client_test';
ruby ./network_transmission.rb 'https://enhmwo8f6ck2l.x.pipedream.net/' 'BOOGA-WOOGA'
