import sys, time, socket, json
from OpenGL.GLUT import *

ttime = 0
PORT = 4000

class GyroController(object):
    def __init__(self, scene):
        self.scene = scene
        self.pressedKeys = set()
        
        self.sock = socket.socket(socket.AF_INET, # Internet
                             socket.SOCK_DGRAM) # UDP
        self.sock.bind(("", PORT))

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
            
    def idle(self):
        data, addr = self.sock.recvfrom(1024) # buffer size is 1024 bytes
        # print data
        parsed = json.loads(data)
        x = parsed['x']
        
        self.scene.helicopter.nick(x)
        print x
