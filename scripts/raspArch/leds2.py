#!/usr/bin/python2.7
# -*- utf-8 -*-

import RPi.GPIO as GPIO
import threading
import time

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

GPIO.setup(11, GPIO.OUT)
GPIO.setup(13, GPIO.OUT)
GPIO.setup(15, GPIO.OUT)

def Pino():
    texto = open("pino.dat","r")
    pino = int(texto.read())
    texto.close
    return pino

def Cor(pino):
    pwm = GPIO.PWM(pino,100) # pino, frequencia
    pwm.start(1) # intensidade
    while(pino == Pino()):
        time.sleep(1)

while(1):
    Cor(Pino())
