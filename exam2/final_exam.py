#!/usr/bin/env python3

# Simple network socket demo - CLIENT
#
# Set script as executable via: chmod +x client.py
# Run via:  ./client.py <IP> <PORT>
#
# To connect to a server on the same computer, <IP> could
# either be 127.0.0.1 or localhost (they have the same meaning)


#-----------------------------------------------------------------------
#I run the program by typing in  ./final_exam.py 10.10.5.203 3456
#-----------------------------------------------------------------------

import socket
import sys

import argparse
import string
import os
from subprocess import call
from urllib.parse import urlparse

def main():
    if len(sys.argv) != 3:
         print("Error: Program needs <IP> and <PORT> arguments")
         sys.exit()

    # Tip: You should use argparse - this method
    # is sloppy and inflexible
    ip = sys.argv[1]
    port = int(sys.argv[2])
    
    NumA = 1352
    NumB = 2500
    Sum = 4000
    
    #finalIP = "10.10.5.203"
    
    #For the Exam I can just code in the values of the ip and the port
    #ip = finalIP
    #port = 3456
    
    # Create TCP socket
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as msg:
        print("Error: could not create socket")
        print("Description: " + str(msg))
        sys.exit()

    print("Connecting to server at " + ip + " on port " + str(port))
     
    # Connect to server
    try:
        s.connect((ip , port))
    except socket.error as msg:
        print("Error: Could not open connection")
        print("Description: " + str(msg))
        sys.exit()
 
    print("Connection established")
    
    # Send message to server
    #string_unicode = "EXAM 1.0 REQUEST\r\n "+ "NumA: " + str(NumA) + "\r\n" + "NumB: " + str(NumB) + "\r\n Name: Drew Overgaard\r\n\r\n"
    string_unicode = "EXAM 1.0 REQUEST\r\n " + "NumA: " + str(NumA) + "\r\n" + "NumB: " + str(NumB) + "\r\n" + "Name: Drew Overgaard\r\n\r\n"
    raw_bytes = bytes(string_unicode,'ascii')
    
    try:
        # Send the string
        # Note: send() might not send all the bytes!
        # You should loop, or use sendall()
        bytes_sent = s.send(raw_bytes)
    except socket.error as msg:
        print("Error: send() failed")
        print("Description: " + str(msg))
        sys.exit()
 
    print("Sent %d bytes to server" % bytes_sent)
    
    

    
  
     #-------------------------------------------Added from server.py------------------------
     #I think this will help recive the payload from the server
    
       # Create TCP socket
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as msg:
        print("Error: could not create socket")
        print("Description: " + str(msg))
        sys.exit()

    

    # Listen
    try:
        backlog=10  # Number of incoming connections that can wait
                    # to be accept()'ed before being turned away
        s.listen(backlog)
    except socket.error as msg:
        print("Error: unable to listen()")
        print("Description: " + str(msg))
        sys.exit()    

    print("Listening socket bound to port %d" % port)

    # Accept an incoming request
    try:
        (client_s, client_addr) = s.accept()
        # If successful, we now have TWO sockets
        #  (1) The original listening socket, still active
        #  (2) The new socket connected to the client
    except socket.error as msg:
        print("Error: unable to accept()")
        print("Description: " + str(msg))
        sys.exit()

    print("Accepted incoming connection from client")
    print("Client IP, Port = %s" % str(client_addr))

     # Receive data
    try:
        buffer_size=4096
        raw_bytes = client_s.recv(buffer_size)
    except socket.error as msg:
        print("Error: unable to recv()")
        print("Description: " + str(msg))
        sys.exit()

    string_unicode = raw_bytes.decode('ascii')
    print("Received %d bytes from client" % len(raw_bytes))
    print("Message contents: %s" % string_unicode) 
    
    Sum = string_unicode  
    
    print(str(NumA) + "+" + str(NumB) + "=" + str(Sum))
        
        
     #-------------------------------------------Added from server.py------------------------
     
     


if __name__ == "__main__":
    sys.exit(main())
