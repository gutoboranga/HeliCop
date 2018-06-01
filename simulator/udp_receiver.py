import socket
import json

class UDPReceiver:
    def __init__(self, port):
        
        sock = socket.socket(socket.AF_INET, # Internet
                             socket.SOCK_DGRAM) # UDP
        sock.bind(("", port))

        while True:
            data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
            # print data
            d = json.loads(data)
            print d['x']
            
receiver = UDPReceiver(4000)
