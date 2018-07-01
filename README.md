# Crazy Helicopter Pilot Simulator

This is the final assignment of Human-Computer Interaction class (INF01043 @ UFRGS).

Our goal is to develop an alternative way to control a 3D helicopter model, using the gyroscope of a smartphone.

Group participants:

- [Augusto Boranga](https://github.com/gutoboranga/);
- [Isadora Oliveira](https://github.com/isadorasop).

## The 3D model

The 3D helicopter, along with its physics model to create the simulation were built by [eyesfocus](https://github.com/eyesfocus), and forked by us. Original repository is [here](https://github.com/eyesfocus/HeliCop).

## Install

To make the python dependencies, run:

```
make install
```

## Run

### Keyboard controller

To run the default controller (using the keyboard):

```
make simulate-keyboard
```

### Mobile controller

To run the mobile controller, open the XCode project `iOS-CoreMotion-Example/CoreMotionExample.xcodeproj` and run it on an iPhone with gyroscope.

Afterwards, run on the desktop:

```
make simulate-mobile
```

Then, insert your computer's IP into the app and follow the instructions to control the helicopter with the movements of your hand, captured by the phone.

### Have fun :)
