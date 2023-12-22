#--LIBRARIES
import sys, time
import network
import machine
import ufirebase as firebase

#--SETTING UP PINS FOR INPUTS AND OUTPUTS

#For the first relay setup
relay01=machine.Pin(32,machine.Pin.OUT) #FIRST OUTPUT SWITCH 
switch01=machine.Pin(34,machine.Pin.IN,machine.Pin.PULL_UP) #FIRST INPUT SWITCH WITH PULLUP RESISTOR
relay01.value(1)

#For the second relay setup
relay02=machine.Pin(33,machine.Pin.OUT) #SECOND OUTPUT SWITCH 
switch02=machine.Pin(35,machine.Pin.IN,machine.Pin.PULL_UP) #SECOND INPUT SWITCH WITH PULLUP RESISTOR
relay02.value(1)

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
firebase.put("Appliances/Switch00/Switch00", False, bg=0) # For Switch no.1
firebase.put("Appliances/Switch00/Switch00Flag", 0, bg=0)
firebase.put("Appliances/Switch01/Switch01", False, bg=0) # For Switch no.2
firebase.put("Appliances/Switch01/Switch01Flag", 0, bg=0)

# --------------------FUNCTIONS--------------------------
#WITHOUT INTERNET FUNCTION
def without_internet(): 
    relay01.value(not switch01.value())
    relay02.value(not switch02.value())

#WITH INTERNET CONNECTION
def with_internet():
    firebase.get("Appliances/Switch00/Switch00Flag", "switch01_flag", bg=0)
    firebase.get("Appliances/Switch01/Switch01Flag", "switch02_flag", bg=0)
    
    if switch01.value() == 0:
        if firebase.switch01_flag == 0:
            relay01.off()
            firebase.put("Appliances/Switch00/Switch00", True, bg=0)
            firebase.put("Appliances/Switch00/Switch00Flag", 1, bg=0)
    
    if switch01.value() == 1:
        if firebase.switch01_flag == 1:
            relay01.on()
            firebase.put("Appliances/Switch00/Switch00", False, bg=0)
            firebase.put("Appliances/Switch00/Switch00Flag", 0, bg=0)
    
    if switch02.value() == 0:
        if firebase.switch02_flag == 0:
            relay02.off()
            firebase.put("Appliances/Switch01/Switch01", True, bg=0)
            firebase.put("Appliances/Switch01/Switch01Flag", 1, bg=0)
    
    if switch02.value() == 1:
        if firebase.switch02_flag == 1:
            relay02.on()
            firebase.put("Appliances/Switch01/Switch01", False, bg=0)
            firebase.put("Appliances/Switch01/Switch01Flag", 0, bg=0)

#DATA FROM FIREBASE
def data_from_firebase():
    firebase.get("Appliances/Switch00/Switch00", "S01", bg=0)
    firebase.get("Appliances/Switch01/Switch01", "S02", bg=0)
    if (firebase.S01==True):
        relay01.off()
    elif (firebase.S02==True):
        relay02.off()
    elif (firebase.S01==False):
        relay01.on()
    elif (firebase.S02==False):
        relay02.on()

#MAIN FUNCTION
while True:
    if wlan_status != 1:
        without_internet()
    else:
        data_from_firebase()
        with_internet()


