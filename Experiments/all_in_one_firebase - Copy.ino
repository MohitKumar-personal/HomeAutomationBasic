
#include <WiFi.h>
#include <WiFiClient.h>
#include <FirebaseESP32.h>

// Firebase Credentials
#define FIREBASE_HOST "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#define FIREBASE_AUTH "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

// WiFi Credentials
#define WIFI_SSID "SSID"
#define WIFI_PASSWORD "PASS"

// Function Declaration
void  with_internet();
void  without_internet();

// Pins of Switches
#define S5 32
#define S6 35

// Pins of Relay (Appliances Control)
#define R5 15
#define R6 2

//Define FirebaseESP32 data object
FirebaseData firebaseData;
FirebaseJson json;

int switch_ON_Flag1_previous_I = 0;
int switch_ON_Flag2_previous_I = 0;

void setup()
{
  // put your setup code here, to run once:
  pinMode(S5, INPUT_PULLUP);
  pinMode(S6, INPUT_PULLUP);

  pinMode(R5, OUTPUT);
  pinMode(R6, OUTPUT);

  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);

}


void loop()
{

  if (WiFi.status() != WL_CONNECTED)
  {
    without_internet();
  }
  else
  {
    Data_from_firebase();
    with_internet();
  }
}

void Data_from_firebase()
{
    if (Firebase.getString(firebaseData, "/Appliances/appliance1"))
    {
      if (firebaseData.stringData() == "1")
      {
        digitalWrite(R5, HIGH);
      }
      else
      {
        digitalWrite(R5, LOW);
      }
    }
    if (Firebase.getString(firebaseData, "/Appliances/appliance2")) {
      if (firebaseData.stringData() == "1")
      {
        digitalWrite(R6, HIGH);
      }
      else
      {
        digitalWrite(R6, LOW);
      }

    }
}


void with_internet()
{
  // FOR SWITCH
  if (digitalRead(S5) == LOW)
  {
    if (switch_ON_Flag1_previous_I == 0 )
    {
      digitalWrite(R5, HIGH);
      String Value1 = "1";
      json.set("/appliance1", Value1);
      Firebase.updateNode(firebaseData, "/Appliances", json);
      switch_ON_Flag1_previous_I = 1;
    }
  }
  if (digitalRead(S5) == HIGH )
  {
    if (switch_ON_Flag1_previous_I == 1)
    {
      digitalWrite(R5, LOW);
      String Value1 = "0";
      json.set("/appliance1", Value1);
      Firebase.updateNode(firebaseData, "/Appliances", json);
      switch_ON_Flag1_previous_I = 0;
    }
  }
  if (digitalRead(S6) == LOW)
  {
    if (switch_ON_Flag2_previous_I == 0 )
    {
      digitalWrite(R6, HIGH);
      String Value2 = "1";
      json.set("/appliance2", Value2);
      Firebase.updateNode(firebaseData, "/Appliances", json);
      switch_ON_Flag2_previous_I = 1;
    }
  }
  if (digitalRead(S6) == HIGH )
  {
    if (switch_ON_Flag2_previous_I == 1)
    {
      digitalWrite(R6, LOW);
      String Value2 = "0";
      json.set("/appliance2", Value2);
      Firebase.updateNode(firebaseData, "/Appliances", json);
      switch_ON_Flag2_previous_I = 0;
    }
  }
}

void without_internet()
{
  // FOR SWITCH
  digitalWrite(R5, !digitalRead(S5));
  digitalWrite(R6, !digitalRead(S6));
} 




