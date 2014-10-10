require 'socket'               # Get sockets from stdlib

portnum = ARGV[0] #take port number as argument from command line
server = TCPServer.open(portnum)  # Socket to listen on port 2000


while true 
  loop {                       # Servers run forever 
        
      Thread.start(server.accept) do |client|
      #client = server.accept     # Wait for a client to connect
      line = client.gets
    
      if line == "HELO\n"
        puts "special message received"
        client.puts "HELO text\nIP:[ip address]\nPort:[#{portnum}]\nStudentID:[10303365]"
      
      elsif line == "KILL_SERVICE\n"
        puts "close message received"
        puts "Server closing"
        server.close
        break                    #break out of loop
      
      else
        puts "unknown message"
      end
        client.close               # Disconnect from the client
        
      end #end of do client
      
  }
  
  break                        #break out of while loop


end



#close breaks