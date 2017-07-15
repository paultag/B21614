import B21614
import serial
import time

tty = serial.Serial("/dev/ttyUSB0")

B21614.set_hdmi1(tty)
time.sleep(10)
B21614.set_hdmi2(tty)
