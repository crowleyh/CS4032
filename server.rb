require 'socket'                 
require 'thread'

class Server                                                
  attr_accessor :socket, :IsOpen                           
  def initialize()                  
   @socket = TCPServer.open(PortNumber)
   @IsOpen = true
  end
end


def serveClient(client, server, portnum)
  line = client.gets
  if line.include?("HELO\n")
    puts "special message received and reply sent"
    client.puts "HELO echoed text:"+ line +"IP:[#{IPAddress}]\nPort:[#{portnum}]\nStudentID:[10303365]"
  elsif line == "KILL_SERVICE\n"
    puts "Server closing"
    server.socket.close              #this needs to be fixed- atm it just crashes
    server.IsOpen = false
  else
    puts "unknown message"    #default for other messages
  end
  client.close                # Disconnect from client
end


#create work queue and server
IPAddress = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
PortNumber= ARGV[0]           #take port number as argument from command line
server = Server.new()
work_q = Queue.new


# 5 threads serve the clients
workers = (0...5).map do
  Thread.new do
    begin   
      while server.IsOpen
       if work_q.length > 0
          client = work_q.pop                
          serveClient client, server, PortNumber
         end                                        
     end
    rescue ThreadError
    end
  end
end; 


#main loop continues to accept clients and push them onto the queue
while server.IsOpen                                                                          
  work_q.push(server.socket.accept)  
end
workers.map(&:join);    #stop all threads when they have completed serving
