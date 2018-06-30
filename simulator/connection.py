# -*- coding: utf-8 -*-
import sys, time, socket, json

MOBILE_TO_SIMULATOR_CONNECT = 0
SIMULATOR_TO_MOBILE_CONNECTED = 1
SIMULATOR_TO_MOBILE_ERROR = 2

def create_socket(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(("", port))
    
    return sock

def wait_for_connection(sock):
    connected = False
    
    while not connected:
        data, addr = sock.recvfrom(1024)
        message = json.loads(data)
        
        if message == int(MOBILE_TO_SIMULATOR_CONNECT):
            sent = sock.sendto(str(SIMULATOR_TO_MOBILE_CONNECTED), addr)
            
            connected = True
    
    return True
    
if __name__ == "__main__":
    sock = create_socket(4000)
    wait_for_connection(sock)
