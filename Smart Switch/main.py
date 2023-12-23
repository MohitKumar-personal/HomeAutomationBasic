import sys, time
import network
import machine
import ufirebase as firebase

#--SETTING UP PINS FOR INPUTS AND OUTPUTS
#For the first relay setup
relay01=machine.Pin(32,machine.Pin.OUT) #FIRST OUTPUT SWITCH 
switch01=machine.Pin(34,machine.Pin.IN,machine.Pin.PULL_UP) #FIRST INPUT SWITCH WITH PULLUP RESISTOR
relay01.value(1)

#--WIFI CONFIGURATION OR CONNECTING METHOD
#Making a global variable so i can use this variable anywhere
global wlan_status
def wlan_connect():
    #Wifi SSID & Password inputs
    wifi_ssid = "Mohit"
    wifi_password = "Mohit@1358"
    #Connecting method...
    wlan = network.WLAN(network.STA_IF)
    if not wlan.active() or not wlan.isconnected():
        wlan.active(True)
        wlan.connect(wifi_ssid,wifi_password)
        while not wlan.isconnected():
            pass
    return 1

#--UFIREBASE CONFIGURATION 
#Setting up url for the project
firebase.setURL("https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/")

#Setting up pins for the firebase database and checking wifi status
wlan_status = wlan_connect()
firebase.put("Appliances/SmartSwitch/SmartSwitch00", False, bg=0) # For Switch no.1
firebase.put("Appliances/SmartSwitch/SmartSwitch00Flag", 0, bg=0)

#--Main Function
while True:
    firebase.get("Appliances/SmartSwitch/SmartSwitch00", "S01", bg=0)
    if (firebase.S01==True):
        relay01.off()
    elif (firebase.S01==False):
        relay01.on()