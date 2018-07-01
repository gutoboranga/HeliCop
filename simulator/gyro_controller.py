import sys, time, socket, json
from OpenGL.GLUT import *

ttime = 0
PORT = 4000

class GyroController(object):
    def __init__(self, scene, sock):
        self.scene = scene
        self.pressedKeys = set()
        
        self.sock = sock

    def handleKeyDown(self, key, x, y):
        if key == chr(27):
            sys.exit()
        scene = self.scene
        helicopter = scene.helicopter

        if key == 'c':
            scene.switchCam()

        if key == '1':
            scene.switchSky()
        if key in 'adjlikws':
            self.pressedKeys.add(key)

        if key in 'ad':
            global ttime
            ttime = time.time()
            
        for k in self.pressedKeys:
            if k == 'a':
                helicopter.gier(False)
            if k == 'd':
                helicopter.gier(True)

            if k == 'j':
                helicopter.roll(True)
            if k == 'l':
                helicopter.roll(False)

            if k == 'i':
                helicopter.nick(-1)
            if k == 'k':
                helicopter.nick(1)

            if k == 'w':
                helicopter.pitch(True)
            if k == 's':
                helicopter.pitch(False)

    def handleKeyUp(self, key, x, y):
        scene = self.scene
        helicopter = scene.helicopter

        if key in 'ad':
            x = time.time()-ttime
            if x > 0.05:
                helicopter.gierSwingout()
    
        if key in 'adjlikws':
            self.pressedKeys.remove(key)
            
    def receive_from_socket(self):
        data, addr = self.sock.recvfrom(1024) # buffer size is 1024 bytes
        return data
        
    def parse_json(self, data):
        parsed = json.loads(data)
        
        x = parsed['x']
        y = parsed['y']
        z = parsed['z']
        
        up = parsed['up']
        should_go_up = (up == 'True')
        
        return x, y, z, should_go_up
        
    def get_gyro_data(self):
        while True:
            data = self.receive_from_socket()
            
            x, y, z, up = self.parse_json(data)
            
            self.scene.helicopter.move(x, y, z, up)
