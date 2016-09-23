Valkyria # cat 2test.py     
#!/usr/bin/python2.7

import RPi.GPIO as GPIO
import time
import sys

buzzer_pin = 7
GPIO.setmode(GPIO.BOARD)
GPIO.setup(buzzer_pin, GPIO.OUT)

def buzz(frequencia, atraso, largura, quantidade):
    periodo = 1.0 / frequencia
    delay = periodo / 2
    ciclos = int(largura * frequencia)

    for j in range(quantidade):
        for i in range(ciclos):
            GPIO.output(buzzer_pin, 1)
            time.sleep(delay)
            GPIO.output(buzzer_pin, 0)
            time.sleep(delay)
        time.sleep((atraso / quantidade) - (periodo * ciclos))


buzz(880, float(sys.argv[1]), .02, int(sys.argv[2]))

#uma boa opcao nos parametros eh: ./buzzer.py .1 3

GPIO.cleanup()
