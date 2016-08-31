#!/bin/python2.7

import threading
import RPi.GPIO as GPIO
import time
import sys

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)
cor = sys.argv[1]
pinLedRed = 15
pinLedGreen = 13
pinLedBlue = 11

GPIO.setup(pinLedRed, GPIO.OUT)
GPIO.setup(pinLedGreen, GPIO.OUT)
GPIO.setup(pinLedBlue, GPIO.OUT)

def AjusteCores (red, green, blue, tempo):
	while (1):
		GPIO.output(pinLedRed, red)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(tempo)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, green)
		GPIO.output(pinLedBlue, 0)
		time.sleep(tempo)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, blue)
		time.sleep(tempo)

def Cores (cor):
	if (cor == "white"):
		AjusteCores (1, 1, 1, 0.0001)
	elif (cor == "red"):
		AjusteCores (1, 0, 0, 0.0001)
	elif (cor == "green"):
		AjusteCores (0, 1, 0, 0.0001)
	elif (cor == "blue"):
		AjusteCores (0, 0, 1, 0.0001)
	elif (cor == "yellow"):
		AjusteCores (1, 1, 0, 0.0001)
	elif (cor == "magenta"):
		AjusteCores (1, 0, 1, 0.0001)
	elif (cor == "cyan"):
		AjusteCores (0, 1, 1, 0.0001)
	else:
		AjusteCores (0, 0, 0, 0.0001)
	
Cores (cor)

t = threading.Thread(target=Cores, args=(cor,))
#threads.append(t)
t.start()
	
