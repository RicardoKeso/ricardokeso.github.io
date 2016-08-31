#!/bin/python2.7

import threading
import RPi.GPIO as GPIO
import time
import sys

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

pinLedRed = 15
pinLedGreen = 13
pinLedBlue = 11

cor = sys.argv[1]
#intensidade = sys.argv[2]

GPIO.setup(pinLedRed, GPIO.OUT)
GPIO.setup(pinLedGreen, GPIO.OUT)
GPIO.setup(pinLedBlue, GPIO.OUT)
# - - - - -
def White (intensidade):
	while (1):
		GPIO.output(pinLedRed, 1)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0003)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 1)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 1)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(intensidade)
# - - - - -
def Yellow (intensidade):
	while (1):
		GPIO.output(pinLedRed, 1)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0003)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 1)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(intensidade)
# - - - - -
def Magenta (intensidade):
	while (1):
		GPIO.output(pinLedRed, 1)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0002)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 1)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(intensidade)
# - - - - -
def Cyan (intensidade):
	while (1):		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 1)
		GPIO.output(pinLedBlue, 0)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 1)
		time.sleep(0.0001)
		
		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(intensidade)
# - - - - -
def AjusteCores (red, green, blue, intensidade):
	while (1):
		GPIO.output(pinLedRed, red)
		GPIO.output(pinLedGreen, green)
		GPIO.output(pinLedBlue, blue)
		time.sleep(0.0001)

		GPIO.output(pinLedRed, 0)
		GPIO.output(pinLedGreen, 0)
		GPIO.output(pinLedBlue, 0)
		time.sleep(intensidade)
# - - - - -
def Cores (cor):
	if (cor == "white"):
		White(0)
	elif (cor == "red"):
		AjusteCores (1, 0, 0, 0)
	elif (cor == "green"):
		AjusteCores (0, 1, 0, 0)
	elif (cor == "blue"):
		AjusteCores (0, 0, 1, 0)
	elif (cor == "yellow"):
		Yellow(0)
	elif (cor == "magenta"):
		Magenta(0)
	elif (cor == "cyan"):
		Cyan(0)
	else:
		AjusteCores (0, 0, 0, 0)
# - - - - -

#t = threading.Thread(target=Cores, args=(cor,))
#threads.append(t)
#t.start()

Cores(cor)
	
