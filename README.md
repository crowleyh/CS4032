CS4032
======
You should document your project here.

This is a thread pooled server containing 5 threads.

While the server is running, clients are pushed on to the queue. Meanwhile, 5 threads pop
clients off the queue and serve them using the serve_client function

serve_client echoes the original message, IP address and port number when the special message
"HELO" is included. Otherwise it does not reply to the client

To run the server, run start.sh portnumber
