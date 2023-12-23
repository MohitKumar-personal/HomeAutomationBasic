import sys, time
import machine

relay01=machine.Pin(32,machine.Pin.OUT)

switch01=machine.Pin(34,machine.Pin.IN)

switch01_flag = 0
print(switch01_flag)

while True:
    #relay01.value(not switch01.value())
    if not switch01.value() == 0:
        if switch01_flag == 0:
            print(switch01_flag)
            relay01.value(1)
            switch01_flag = 1
            print(switch01_flag)

    if not switch01.value() == 1:
        if switch01_flag == 1:
            print(switch01_flag)
            relay01.value(0)
            switch01_flag = 0
            print(switch01_flag)