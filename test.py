import B21614
import serial
import time
import sys

tty = serial.Serial("/dev/ttyUSB0")
tty = sys.stdout

B21614.set_hdmi1(tty)
time.sleep(10)
B21614.set_hdmi2(tty)
