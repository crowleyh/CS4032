require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

#while line = s.gets   # Read lines from the socket
 # puts line.chop      # And print with platform line terminator
 #end
 
s.puts("KILL_SERVICE\n")

s.puts("HELO\n")

while line = s.gets
  puts line.chop
end

s.close               # Close the socket when done