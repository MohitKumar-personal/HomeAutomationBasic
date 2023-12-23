print("Hello, ESP32!")
#LIBRARIES
import sys, time
import network
import machine
import ufirebase as firebase

#SETTING UP PINS FOR INPUTS AND OUTPUTS
relay01=machine.Pin(32,machine.Pin.OUT) #FIRST OUTPUT SWITCH 
switch01=machine.Pin(34,machine.Pin.IN,machine.Pin.PULL_UP) #FIRST INPUT SWITCH WITH PULLUP RESISTOR
relay01.value(1)

#IMPORTANT VARIABLES
global wlan_status

#WIFI CONFIGURATION OR CONNECTING METHOD
def wlan_connect():
    #WIFI SSID/NAME AND PASSWORD
    wifi_ssid = "Wokwi-GUEST"
    wifi_password = ""

    #CONNECTING METHOD
    wlan = network.WLAN(network.STA_IF)
    if not wlan.active() or not wlan.isconnected():
        wlan.active(True)
        wlan.connect(wifi_ssid,wifi_password)
        while not wlan.isconnected():
            pass
    return 1

#UFIREBASE CONFIGURATION 
firebase.setURL("https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/")

# --------------------FUNCTIONS--------------------------
#WITHOUT INTERNET FUNCTION
def without_internet(): 
    relay01.value(not switch01.value())

#WITH INTERNET CONNECTION
def with_internet():
    firebase.get("Appliances/Switch00/Switch00Flag", "switch01_flag", bg=0)
    
    if switch01.value() == 0:
        if firebase.switch01_flag == 0:
            print(switch01.value())
            relay01.on()
            firebase.put("Appliances/Switch00/Switch00", True, bg=0)
            firebase.put("Appliances/Switch00/Switch00Flag", 1, bg=0)
    
    if switch01.value() == 1:
        if firebase.switch01_flag == 1:
            print(switch01.value())
            relay01.off()
            firebase.put("Appliances/Switch00/Switch00", False, bg=0)
            firebase.put("Appliances/Switch00/Switch00Flag", 0, bg=0)

#DATA FROM FIREBASE
def data_from_firebase():
    firebase.get("Appliances/Switch00/Switch00", "S01", bg=0)
    if (firebase.S01==True):
        print(firebase.S01)
        relay01.on()
    else:
        print(firebase.S01)
        relay01.off()

#SETTING UP PINS FOR FIREBASE DATABASE AND CHECKING WIFI STATUS
wlan_status = wlan_connect()
firebase.put("Appliances/Switch00/Switch00", False, bg=0)
firebase.put("Appliances/Switch00/Switch00Flag", 0, bg=0)

#MAIN FUNCTION
while True:
    if wlan_status != 1:
        print('Wifi not connected')
        without_internet()
    else:
        print('Wifi connected')
        data_from_firebase()
        with_internet()


