#!/usr/bin/python3

# Usage:
#  ./display.py --help
#  ./display.py --port=??? --url=????
#
# Example commands:
#  ./display.py --port=80 --url=http://www.google.com/images/srpr/logo3w.png
#  ./display.py --port=80 --url=http://imgsrc.hubblesite.org/hu/db/images/hs-2006-01-a-800_wallpaper.jpg
#  ./display.py --port=80 --url=http://imgsrc.hubblesite.org/hu/db/images/hs-2010-13-a-2560x1024_wallpaper.jpg
#  ./display.py --port=80 --url=http://ut-images.s3.amazonaws.com/wp-content/uploads/2009/09/SED_wall_1920x1200.jpg
#  ./display.py --port=80 --url=http://history.nasa.gov/ap11ann/kippsphotos/69-H-1096.jpg
#  ./display.py --port=80 --url=http://www.nasa.gov/centers/dryden/images/content/690557main_SCA_Endeavour_over_Ventura.jpg
#  ./display.py --port=8080 --url=http://cmdb.nccs.nasa.gov/odisees/images/CDS_Website_Banner-2-4-14.png

import argparse
import string
import socket
import sys
import os
from subprocess import call
from urllib.parse import urlparse

# Size of receive buffer.
# Maximum number of bytes to get from network in one recv() call
max_recv = 64*1024

# Setup configuration
parser = argparse.ArgumentParser(description='Download client for ECPE 170')
parser.add_argument('--url', 
                    action='store',
                    dest='url', 
                    required=True,
                    help='URL of file to download')
parser.add_argument('--port', 
                    action='store',
                    dest='port', 
                    required=True,
                    help='Port number of web server')

args = parser.parse_args()
url = args.url
port = int(args.port)

print("Running download client")
print("Download url: %s" % url)
print("Download port number: %i" % port)

# Split URL into "host", "path", and "filename" variables.
# http://www.google.com/images/srpr/logo3w.png
#  * host=www.google.com
#  * path=/images/srpr
#  * file=logo3w.png

u = urlparse(url)
print("Parsing URL:")
print(" * scheme=%s" % u.scheme)
print(" * netloc=%s" % u.netloc)
print(" * path+file=%s" % u.path)
print(" * path=%s" % os.path.dirname(u.path))
print(" * file=%s" %os.path.basename(u.path))
print()

# Download file (image) from http://host/path/filename
host = u.netloc
path = os.path.dirname(u.path) + '/'
filename = os.path.basename(u.path)

print("Preparing to download object from http://" + host + path + filename)


# *****************************
# STUDENT WORK: 
#  (1) Build the HTTP request string to send to the server
#      and *print it* on the screen.
#
#      Requirements:
#        HTTP 1.1
#        Use the Host header
#        Request the connection be closed after response sent.
#
#      Tip: What is the important sequence of characters that
#      must be provided at the end of the HTTP client request
#      to the server? (otherwise, the server won't begin processing)
# *****************************

#print("GET " + path + " HTTP/1.1")
#print("Host: " + url)
#print("Connection: close")

request = "GET " + path + filename + " HTTP/1.1\r\nHost: " + host + "\r\n" + "Connection: close\r\n\r\n"
print(request)



# *****************************
# STUDENT WORK: 
#  (2) Create a TCP socket (SOCK_STREAM)
#  (3) Connect to the remote host using the socket
#  (4) Send the HTTP request to the remote host.
#      Tip: Look at the demo client program to see how
#      to convert a unicode string to a byte array
#      prior to transmitting it.
# *****************************

# Create TCP socket
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
except socket.error as msg:
    print("Error: could not create socket")
    print("Description: " + str(msg))
    sys.exit()

print("Connecting to server at " + host + " on port " + str(port))

# Connect
try:
    s.connect((host, port))
except socket.error as msg:
    print("Error: Could not open connection")
    print("Description: " + str(msg))
    sys.exit()
 
print("Connection established")

# Send message to server
string_unicode = request
raw_bytes = bytes(string_unicode,'ascii')
    
try:
    # Send the string
    # Note: send() might not send all the bytes!
    # You should loop, or use sendall()
    s.sendall(raw_bytes)
    	#bytes_sent = s.send(raw_bytes)
    	#bytes = bytes - 1
except socket.error as msg:
    print("Error: send() failed")
    print("Description: " + str(msg))
    sys.exit()
 
#print("Sent %d bytes to server" % bytes_sent)



# *****************************
# STUDENT WORK: 
#  (5) Receive everything the remote host sends us
#      in chunks of 'max_recv' bytes (64kB).
#      When the server finishes sending us the data,
#      it will close the socket. That is detected locally
#      by receiving an array of length ZERO
#      (i.e. no bytes received)
#  (6) Close the socket - finished with the network now
# *****************************

print("Sent data, waiting for response")
    
# Receive data


#complete_raw_bytes = b''
#raw_bytes = s.recv(max_recv)


#len(temp_raw_bytes) != 0
#temp_raw_bytes != b''

#complete_raw_bytes = s.recv(buffer_size)
#print("Hello")
#print("Received %d bytes from client" % len(complete_raw_bytes))
    

temp_raw_bytes = s.recv(max_recv)    
print("Received %d bytes from client" % len(temp_raw_bytes))
complete_raw_bytes=temp_raw_bytes
try:
	while(len(temp_raw_bytes) != 0):
		#print("Loop....")
		temp_raw_bytes = s.recv(max_recv)
		print("Received %d bytes from client" % len(temp_raw_bytes))
		complete_raw_bytes = complete_raw_bytes + temp_raw_bytes

			#complete_raw_bytes = complete_raw_bytes + s.recv(buffer_size)
			#max_recv = max_recv - buffer_size
except socket.error as msg:
	print("Error: unable to recv()") 
	print("Description: " + str(msg))
	sys.exit()
	

#string_unicode = raw_bytes.decode('ascii')
print("Received %d bytes from client" % len(complete_raw_bytes))
#print("Message contents: %s" % string_unicode)




 # Close socket
try:
    s.close()
except socket.error as msg:
    print("Error: unable to close() socket")
    print("Description: " + str(msg))
    sys.exit()

print("Sockets closed, now exiting")






# *****************************
# STUDENT WORK: 
#  (7) Split the response into two parts:
#        1.) The part before the \r\n\r\n sequence - the HEADER
#        2.) The part after the \r\n\r\n sequence - the DATA
#  (8) Print the HEADER out on the screen - it's ASCII text
#  (9) Save the DATA to disk as a binary file. Somewhere
#      in the /tmp directory would be a great spot.
# *****************************
(header,data) = complete_raw_bytes.split(bytes("\r\n\r\n", 'ascii'), 1)

print(header)

with open ('/tmp/data', 'wb') as f:
	f.write(data)
f.close()

saved_filename = '/tmp/data'


# *****************************
# END OF STUDENT WORK
# *****************************

# Assuming you downloaded the image, and placed its path/filename
# in the variable 'saved_filename', use the 'eog' utility to 
# display the image on screen
call(["eog", saved_filename])
