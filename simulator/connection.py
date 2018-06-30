# -*- coding: utf-8 -*-
from thread import start_new_thread
import sys, socket, json
from OpenGL.GLUT import *
from OpenGL.GLU import *
from OpenGL.GL import *
from PIL import Image
from numpy import *


MOBILE_TO_SIMULATOR_CONNECT = 0
SIMULATOR_TO_MOBILE_CONNECTED = 1
SIMULATOR_TO_MOBILE_ERROR = 2

WIDTH, HEIGHT = 1000, 1000


def create_socket(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(("", port))
    
    return sock

def display():
    glClearColor(1.0, 1.0, 1.0, 1.0)
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

def show_connection_screen():
    glutInit(sys.argv)
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH)
    glutInitWindowSize(WIDTH, HEIGHT)
    glutCreateWindow("Waiting for connection")
    glutDisplayFunc(display)
    glutMainLoop()
    
def hide_connection_screen():
    glutLeaveMainLoop()

def receive_message(sock):
    connected = False
    
    while not connected:
        
        data, addr = sock.recvfrom(1024)
        message = json.loads(data)
        
        if message == int(MOBILE_TO_SIMULATOR_CONNECT):
            print("> recebeu direitinho")
            sent = sock.sendto(str(SIMULATOR_TO_MOBILE_CONNECTED), addr)
            
            connected = True
    
    print("> did connect")
    hide_connection_screen()
    return True
    

def wait_for_connection(sock):
    
    
    # show_connection_screen()
    start_new_thread(show_connection_screen, ())
    
    receive_message(sock)
    
    # start_new_thread(receive_message, (sock))
    
    # while not connected:
    #
    #     data, addr = sock.recvfrom(1024)
    #     message = json.loads(data)
    #
    #     if message == int(MOBILE_TO_SIMULATOR_CONNECT):
    #         print("> recebeu direitinho")
    #         sent = sock.sendto(str(SIMULATOR_TO_MOBILE_CONNECTED), addr)
    #
    #         connected = True
    #
    # print("> did connect")
    # hide_connection_screen()
    # return True
    
if __name__ == "__main__":
    sock = create_socket(4000)
    wait_for_connection(sock)
