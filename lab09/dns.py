#!/usr/bin/env python3

# Python DNS query client
#
# Example usage:
#   ./dns.py --type=A --name=www.pacific.edu --server=8.8.8.8
#   ./dns.py --type=AAAA --name=www.google.com --server=8.8.8.8

# Should provide equivalent results to:
#   dig www.pacific.edu A @8.8.8.8 +noedns
#   dig www.google.com AAAA @8.8.8.8 +noedns
#   (note that the +noedns option is used to disable the pseduo-OPT
#    header that dig adds. Our Python DNS client does not need
#    to produce that optional, more modern header)

from dns_tools import dns_header_bitfields
from dns_tools import dns  # Custom module for boilerplate code

import argparse
import ctypes
import random
import socket
import struct
import sys
import codecs


class dns_header_bitfields(ctypes.BigEndianStructure):
    _fields_ = [
        ("qr", ctypes.c_uint16, 1),
        ("opcode", ctypes.c_uint16, 4),
        ("aa", ctypes.c_uint16, 1),
        ("tc", ctypes.c_uint16, 1),
        ("rd", ctypes.c_uint16, 1),
        ("ra", ctypes.c_uint16, 1),
        ("reserved", ctypes.c_uint16, 3),
        ("rcode", ctypes.c_uint16, 4)
    ]

def main():

	#hello = "HELLO"

	# Setup configuration
	parser = argparse.ArgumentParser(description='DNS client for ECPE 170')
	parser.add_argument('--type', action='store', dest='qtype',
		                required=True, help='Query Type (A or AAAA)')
	parser.add_argument('--name', action='store', dest='qname',
		                required=True, help='Query Name')
	parser.add_argument('--server', action='store', dest='server_ip',
		                required=True, help='DNS Server IP')

	args = parser.parse_args()
	qtype = args.qtype
	qname = args.qname
	server_ip = args.server_ip
	port = 53
	server_address = (server_ip, port)
	    
	#print(qname)

	if qtype not in ("A", "AAAA"):
		print("Error: Query Type must be 'A' (IPv4) or 'AAAA' (IPv6)")
		sys.exit()

    # Create UDP socket
    # ---------
    # STUDENT TO-DO
    # ---------

	# Create UDP socket
	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	except socket.error as msg:
		print("Error: could not create socket")
		print("Description: " + str(msg))
		sys.exit()

#print("Connecting to server at " + qname + " on port " + str(port))


    # Generate DNS request message
    # ---------
    # STUDENT TO-DO
    # ---------
    
    
    
	request = ("Sending request for " + qname + ", type " + qtype + ", to server " + server_ip + ", port 53")
	
	print(request)
	
	msgID = random.getrandbits(8)
	
	
	bits = dns_header_bitfields()
	bits.qr = 0
	bits.opcode = 0
	bits.tc = 0
	bits.aa = 1
	bits.rd = 1
	bits.ra = 0
	bits.reserved = 0
	bits.rcode = 0
	
	
	data = qname.split('.')
	qname= struct.pack("0c")
	if qtype == "A":
		qty = 1
	else:
		qty = 28
		

	qt = struct.pack("!H", qty)
	qc = struct.pack("!H", 1)
	
	for chunk in data:
		linelength = len(chunk)
		bytesLength = struct.pack("B", linelength)
		qname = qname + bytesLength
		qname = qname + bytes(chunk, "ascii")
	qname = qname + struct.pack("B", 0)
		
	nscount = 0
	arcount = 0
	qdcount = 1
	ancount = 0
	query = qname + qt + qc
	
	
	
	raw_bytes = struct.pack('!H2sHHHH', msgID, bytes(bits), qdcount, ancount, nscount, arcount)
	
	raw_bytes = raw_bytes + query
	#print(raw_bytes)
	
	#Something is wrong with the request. Not sure what it is. Fixed it!
	
	
	

    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    
    # Send message to server
	#string_unicode = request
	#raw_bytes = bytes(string_unicode,'ascii')
    
	try:
	    # Send the string
	    # Note: send() might not send all the bytes!
	    # You should loop, or use sendall()
	    s.sendto(raw_bytes, server_address)
	    	#bytes_sent = s.send(raw_bytes)
	    	#bytes = bytes - 1
	except socket.error as msg:
	    print("Error: send() failed")
	    print("Description: " + str(msg))
	    sys.exit()
	  	 


    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    
	max_recv = 64*1024
	
	
	try:
		(raw_bytes, server_address) = s.recvfrom(max_recv)   
		
	except socket.error as msg:
		print("Error: unable to recv()") 
		print("Description: " + str(msg))
		sys.exit()



    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------
    
     # Close socket
	try:
		s.close()
	except socket.error as msg:
		print("Error: unable to close() socket")
		print("Description: " + str(msg))
		sys.exit()

		print("Sockets closed, now exiting")


    # Decode DNS message and display to screen
	dns.decode_dns(raw_bytes)


if __name__ == "__main__":
	sys.exit(main())
