#--------------------LIBRARIES-------------------------------------------------#

import sys, time
import network
import machine
# from firebase_realtime import Auth, Realtime
import ufirebase as firebase

#--------------------SETTING UP PINS, VARIABLES AND ALL CONTROLS---------------#

#PIN OF RELAY OUTPUT (APPLIANCES CONTROL)
relay01=machine.Pin(32,machine.Pin.OUT)


#PINS OF SWITCHES INPUT FROM MANUAL
switch01=machine.Pin(34,machine.Pin.IN,machine.Pin.PULL_UP)


#FLAGS FOR KNOWING THE VALUES OF PREVIOUS SWITCHES
# switch01_flag = 0


global wlan_status


#WIFI CONFIGURATION
def wlan_connect():
    #WIFI SSID/NAME AND PASSWORD
    wifi_ssid = "Mohit"
    wifi_password = "Mohit@1358"

    #CONNECTING METHOD
    wlan = network.WLAN(network.STA_IF)
    if not wlan.active() or not wlan.isconnected():
        wlan.active(True)
        wlan.connect(wifi_ssid,wifi_password)
        while not wlan.isconnected():
            pass
    return 1
    print("Network connection successful!")
    print("IP address:", wlan.ifconfig()[0])
    
    
#-------------------------------------------------------------------------------------
wlan_status = wlan_connect()

#---------------------FIREBASE SETUP--------------------------#
#FIREBASE REALTIME URL LINK AND AUTHENTICATION METHOD
# real_db_url = f"https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/"
# auth = Auth()
# flg, headers = auth.validate_user("transdig555@gmail.com", "Mohit@2015192", "AIzaSyA5EllEpnbt7PtsyjcVV1OpzhvZn7V5f4I")
# realtime = Realtime(real_db_url, headers)

# flg, data = realtime.put("Switch01", data=0)
        
#UFIREBASE
firebase.setURL("https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/")
#------------------------ALL FUNCTIONS----------------------------------------#

#WITHOUT INTERNET FUNCTION
def without_internet(): 
    relay01.value(not switch01.value())

#WITH INTERNET CONNECTION
def with_internet():
    firebase.get("Switch01Flag", "switch01_flag", bg=0)
    
    if switch01.value() == 0:
        if firebase.switch01_flag == 0:
            relay01.off()
            firebase.put("Relay01", 1, bg=0)
            firebase.put("Switch01Flag", 1, bg=0)
            #switch01_flag = 1
    
    if switch01.value() == 1:
        if firebase.switch01_flag == 1:
            relay01.on()
            firebase.put("Relay01", 0, bg=0)
            firebase.put("Switch01Flag", 0, bg=0)
            #switch01_flag = 0


def data_from_firebase():
    firebase.get("Relay01", "r01", bg=0)
    if (firebase.r01==1):
        relay01.off()
    else:
        relay01.on()

firebase.put("Relay01", 0, bg=0)
firebase.put("Switch01Flag", 0, bg=0)
#switch01_flag = 0

while True:
    if wlan_status != 1:
        print("without internet")
        without_internet()
    else:
        data_from_firebase()
        with_internet(switch01_flag)
