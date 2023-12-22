import os as MOD_OS
import network
import time as MOD_TIME

#Connect to Wifi
SSID = "Mohit"
PASSWORD = "Mohit@1358"
def connect_wifi():
    sta_if = network.WLAN(network.STA_IF)
    if not sta_if.isconnected():
        print("Connecting to network...")
        sta_if.active(True)
        sta_if.connect(SSID, PASSWORD)
        while not sta_if.isconnected():
            pass
    print("Network connection successful!")
    print("IP address:", sta_if.ifconfig()[0])
connect_wifi()

#firebase example
import ufirebase as firebase
firebase.setURL("https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/")

#Put Tag1
firebase.put("testtag", "1234", bg=0)

#Put Tag2
firebase.put("lolval/testval", {"somenumbers": [1,2,3], "something": "lol"}, bg=0)

#Get Tag1
firebase.get("testtag", "var1", bg=0)
print("testtag: "+str(firebase.var1))

#Get Tag2
def callbackfunc():
  print("\nlolval_1: "+str(firebase.lolwhat["testval"]["somenumbers"])+
  "\nlolval_2: "+str(firebase.lolwhat["testval"]["something"])+
  "\nlolall: "+str(firebase.lolwhat))

firebase.get("lolval", "lolwhat", bg=1, cb=(callbackfunc, ()))
print(end="Im getting lolval now")

#Do something in this time
while 1:
  print(end=".")
  MOD_TIME.sleep(.100)
  try: 
    firebase.lolwhat
    break
  except:
    pass
