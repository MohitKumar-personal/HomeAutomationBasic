import sys, time
import network
import machine

def wlan_connect(ssid, pwd):
    wlan = network.WLAN(network.STA_IF)
    if not wlan.active() or not wlan.isconnected():
        wlan.active(True)
        wlan.connect(ssid,pwd)
        while not wlan.isconnected():
            pass
    print("Network connection successful!")
    #print('network config:', wlan.ifconfig())
    print("IP address:", wlan.ifconfig()[0])


wlan_connect('Mohit', 'Mohit@1358')

from firebase_realtime import Auth, Realtime
real_db_url = f"https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/"
auth = Auth()
flg, headers = auth.validate_user("transdig555@gmail.com", "Mohit@2015192", "AIzaSyA5EllEpnbt7PtsyjcVV1OpzhvZn7V5f4I")
# print(flg, headers)
realtime = Realtime(real_db_url, headers)
# print(realtime)



led=machine.Pin(2,machine.Pin.OUT)

while True:
    flg, value01 = realtime.get("LED01")
    if(value01=='ON'):
        led.off()
    if(value01=='OFF'):
        led.on()



    
    
