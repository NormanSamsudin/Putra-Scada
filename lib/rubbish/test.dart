// #include <Arduino.h>
// #include <WiFi.h>
// #include <Firebase_ESP_Client.h>
// #include <Wire.h>
// #include <HTTPClient.h>
// #include <freertos/FreeRTOS.h>
// #include <freertos/task.h>

// // Provide the token generation process info.
// #include "addons/TokenHelper.h"
// // Provide the RTDB payload printing info and other helper functions.
// #include "addons/RTDBHelper.h"

// // Insert your network credentials
// #define WIFI_SSID "XZ1"
// #define WIFI_PASSWORD "test1234"

// // Insert Firebase project API Key
// #define API_KEY "AIzaSyBvcyHfUINuFXYdeXl8WHz4499yqZZPRPo"

// // Insert RTDB URL
// #define DATABASE_URL "https://putra-scada-default-rtdb.asia-southeast1.firebasedatabase.app/"

// // Messenger Firebase
// const char* serverKey = "AAAA1MTGS4M:APA91bELhwLBWmOeE4Td484ZVV7WjT4SVzEYLbh_UteI3ecuw02Oe5yx-CpRy-8kAfxZFme7s2lcEgYwpoJY-KMuDgMyOsB77814ZyXtrnxbusBnuMyndN9fksvp3FGgokHsci1H0uf4";

// // Define Firebase Data object
// FirebaseData fbdo;
// FirebaseAuth auth;
// FirebaseConfig config;
// bool signupOK = false;
// String token;

// String steamFlowAppend;
// String steamPressureAppend;
// String waterLevelAppend;
// String frequencyAppend;
// String valueAppend;
// String dateAppend;
// String date;

// const char* ntpServer = "pool.ntp.org";
// const long gmtOffset_sec = 0;
// const int daylightOffset_sec = 8 * 3600;
// struct tm timeinfo;

// // Potentiometers pin
// const int potPinSF = 36;
// const int potPinSP = 39;
// const int potPinWL = 34;
// const int potPinF = 35;

// // variable for storing the potentiometer value
// int potValueSF = 0;
// int potValueSP = 0;
// int potValueWL = 0;
// int potValueF = 0;

// float steamFlowTH = 0;
// float steamPressureTH = 0;
// float waterLevelTH = 0;
// float frequencyTH = 0;

// float steamFlow;
// float steamPressure;
// float waterLevel;
// float frequency;


// bool activation = false;

// // Send the parameter that low push noti
// String message;

// // trigger push noti
// bool messageTrigger = false;

// void taskReadSensors(void* pvParameters) {
//  while (true) {
//    // Read value from sensor
//    readSensor();

//    // Calculation
//    steamFlow = (potValueSF / 4095.0) * 41.5;
//    steamPressure = (potValueSP / 4095.0) * 41.0;
//    waterLevel = (steamFlow + (steamFlow * 0.40));
//    frequency = (steamFlow + (steamFlow * 0.40));

//    Serial.print("SF:");
//    Serial.print(steamFlow);
//    Serial.print("SP:");
//    Serial.print(steamPressure);
//    Serial.print("WL:");
//    Serial.print(waterLevel);
//    Serial.print("F:");
//    Serial.println(frequency);
//    Serial.println();

//    steamFlowAppend = steamFlowAppend + "," + String(steamFlow);
//    steamPressureAppend = steamPressureAppend + "," + String(steamPressure);
//    waterLevelAppend = waterLevelAppend + "," + String(waterLevel);
//    frequencyAppend = frequencyAppend + "," + String(frequency);

//    getLocalTime();

//    String cTime = String(timeinfo.tm_hour) + "." + String(timeinfo.tm_min) + "." + String(timeinfo.tm_sec);
//    String cDate = String(timeinfo.tm_year + 1900) + "-" + String(timeinfo.tm_mon + 1) + "-" + String(timeinfo.tm_mday);

//    dateAppend += "," + cDate + "#" + cTime;
//    date = cDate + "#" + cTime;

//    // Realtime
//    if (Firebase.RTDB.setString(&fbdo, "SensorRT/SteamFlow", steamFlow)) {
//    } else {
//      Serial.print("steamFlow: ");
//      Serial.println("FAILED");
//      Serial.println("REASON: " + fbdo.errorReason());
//    }
//    if (Firebase.RTDB.setString(&fbdo, "SensorRT/SteamPressure", steamPressure)) {
//    } else {
//      Serial.print("steamPressure: ");
//      Serial.println("FAILED");
//      Serial.println("REASON: " + fbdo.errorReason());
//    }
//    if (Firebase.RTDB.setString(&fbdo, "SensorRT/WaterLevel", waterLevel)) {
//    } else {
//      Serial.print("waterLevel: ");
//      Serial.println("FAILED");
//      Serial.println("REASON: " + fbdo.errorReason());
//    }
//    if (Firebase.RTDB.setString(&fbdo, "SensorRT/Frequency", frequency)) {
//    } else {
//      Serial.print("frequency: ");
//      Serial.println("FAILED");
//      Serial.println("REASON: " + fbdo.errorReason());
//    }

//    if (Firebase.RTDB.setString(&fbdo, "SensorRT/Date", date)) {
//    } else {
//      Serial.print("steamFlowAppend: ");
//      Serial.println("FAILED");
//      Serial.println("REASON: " + fbdo.errorReason());
//    }

//      //Commulative
//  if (Firebase.RTDB.setString(&fbdo, "Sensor/SteamFlow", steamFlowAppend)) {
//  } else {
//    Serial.print("steamFlowAppend: ");
//    Serial.println("FAILED");
//    Serial.println("REASON: " + fbdo.errorReason());
//  }
//  if (Firebase.RTDB.setString(&fbdo, "Sensor/SteamPressure", steamPressureAppend)) {
//  } else {
//    Serial.print("steamPressureAppend: ");
//    Serial.println("FAILED");
//    Serial.println("REASON: " + fbdo.errorReason());
//  }
//  if (Firebase.RTDB.setString(&fbdo, "Sensor/WaterLevel", waterLevelAppend)) {
//  } else {
//    Serial.print("waterLevelAppend: ");
//    Serial.println("FAILED");
//    Serial.println("REASON: " + fbdo.errorReason());
//  }
//  if (Firebase.RTDB.setString(&fbdo, "Sensor/Frequency", frequencyAppend)) {
//  } else {
//    Serial.print("frequencyAppend: ");
//    Serial.println("FAILED");
//    Serial.println("REASON: " + fbdo.errorReason());
//  }

//  if (Firebase.RTDB.setString(&fbdo, "Sensor/Date", dateAppend)) {
//  } else {
//    Serial.print("dateAppend: ");
//    Serial.println("FAILED");
//    Serial.println("REASON: " + fbdo.errorReason());
//  }

//    vTaskDelay(pdMS_TO_TICKS(2000));  // Delay for 2 seconds
//  }
// }

// void taskFirebase(void* pvParameters) {
//  while (true) {
//    // Activation activation monitoring
//    if ((steamFlow > 31.0) && (steamPressure > 31.0) && (waterLevel > 50.0) && (frequency > 50.0)) {
//      activation = true;
//    }

//    Serial.print("Activation: ");
//    Serial.println(activation);

//    // Push notification if low than threshold
//    if (activation == true) {
//      Serial.println("In Activation loop");

//      if (steamFlow < steamFlowTH) {
//        message += "Steam Flow,";
//        Serial.println("In steamFlow");
//        messageTrigger = true;
//      }
//      if (steamPressure < steamPressureTH) {
//        message += "Steam Pressure,";
//        Serial.println("In steamPressure");
//        messageTrigger = true;
//      }
//      if (waterLevel < waterLevelTH) {
//        message += "Water Level,";
//        Serial.println("In waterLevel");
//        messageTrigger = true;
//      }
//      if (frequency < frequencyTH) {
//        message += "Turbine Frequency,";
//        Serial.println("In frequency");
//        messageTrigger = true;
//      }
//      if (messageTrigger == true) {
//        Serial.println("Going to push");
//        message = "The value for " + message + " is lower than the DEFAULT THRESHOLD!";
//        sendFCMNotification("ALERT!", message);
//        messageTrigger = false;
//        message = "";
//      }
//    }

//    vTaskDelay(pdMS_TO_TICKS(1000));  // Delay for 1 second
//  }
// }

// void setup() {
//  Serial.begin(115200);
//  connectToWiFi();
//  configFB();
//  getToken();
//  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
//  getLocalTime();
//  getThreshold();
//  Serial.println("Done fetch threshold value");

//  // Create and start the tasks
//  xTaskCreatePinnedToCore(
//    taskReadSensors,
//    "ReadSensors",
//    4096,
//    NULL,
//    1,
//    NULL,
//    APP_CPU_NUM);

//  xTaskCreatePinnedToCore(
//    taskFirebase,
//    "Firebase",
//    8192,
//    NULL,
//    1,
//    NULL,
//    APP_CPU_NUM);
// }

// void loop() {
// }

// // Connect to WiFi
// void connectToWiFi() {

//  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

//  Serial.println("Wifi connecting: ");
//  while (WiFi.status() != WL_CONNECTED) {
//    delay(500);
//    Serial.print(".");
//  }

//  Serial.println("\nWiFi connected!");
//  Serial.println();
//  Serial.print("Connected with IP: ");
//  Serial.println(WiFi.localIP());
//  Serial.println();

//  // Connected with IP
//  IPAddress localIP = WiFi.localIP();
//  String wifiIP = localIP.toString();
//  Serial.println(wifiIP);
// }

// // Setup for Firebase
// void configFB() {

//  /* Assign the api key (required) */
//  config.api_key = API_KEY;

//  /* Assign the RTDB URL (required) */
//  config.database_url = DATABASE_URL;

//  /* Sign up */
//  if (Firebase.signUp(&config, &auth, "", "")) {
//    Serial.println("FB Connection okay");
//    signupOK = true;
//  } else {
//    Serial.printf("%s\n", config.signer.signupError.message.c_str());
//  }

//  /* Assign the callback function for the long-running token generation task */
//  config.token_status_callback = tokenStatusCallback;  // see addons/TokenHelper.h

//  Firebase.begin(&config, &auth);
//  Firebase.reconnectWiFi(true);
// }

// void getLocalTime() {
//  if (!getLocalTime(&timeinfo)) {
//    Serial.println("Failed to obtain time");
//    return;
//  }
// }

// void getThreshold() {
//  if (Firebase.RTDB.getFloat(&fbdo, "Threshold/steamFlow")) {
//    if (fbdo.dataType() == "float") {
//      steamFlowTH = fbdo.floatData();
//      Serial.print("steamFlowTH: ");
//      Serial.println(steamFlowTH);
//    }
//  } else {
//    Serial.print("steamFlowTH: ");
//    Serial.println(fbdo.errorReason());
//  }

//  if (Firebase.RTDB.getFloat(&fbdo, "Threshold/steamPressure")) {
//    if (fbdo.dataType() == "float") {
//      steamPressureTH = fbdo.floatData();
//      Serial.print("steamPressureTH: ");
//      Serial.println(steamPressureTH);
//    }
//  } else {
//    Serial.print("steamPressureTH: ");
//    Serial.println(fbdo.errorReason());
//  }
//  if (Firebase.RTDB.getFloat(&fbdo, "Threshold/turbineFrequency")) {
//    if (fbdo.dataType() == "float") {
//      frequencyTH = fbdo.floatData();
//      Serial.print("frequencyTH: ");
//      Serial.println(frequencyTH);
//    }
//  } else {
//    Serial.print("frequencyTH: ");
//    Serial.println(fbdo.errorReason());
//  }

//  if (Firebase.RTDB.getFloat(&fbdo, "Threshold/waterLevel")) {
//    if (fbdo.dataType() == "float") {
//      waterLevelTH = fbdo.floatData();
//      Serial.print("waterLevelTH: ");
//      Serial.println(waterLevelTH);
//    }
//  } else {
//    Serial.print("waterLevelTH: ");
//    Serial.println(fbdo.errorReason());
//  }
// }

// //void sendFCMNotification(const char* title, const char* body) {
// void sendFCMNotification(const String title, const String body) {
//  HTTPClient http;
//  http.begin("https://fcm.googleapis.com/fcm/send");
//  http.addHeader("Content-Type", "application/json");
//  http.addHeader("Authorization", "key=" + String(serverKey));

//  // Construct the FCM notification payload
//  String jsonData = "{\"to\":\"" + String(token) + "\",\"notification\":{\"title\":\"" + String(title) + "\",\"body\":\"" + String(body) + "\"}}";

//  int httpResponseCode = http.POST(jsonData);

//  if (httpResponseCode > 0) {
//    String response = http.getString();
//    Serial.println("FCM Notification Sent Successfully!");
//    Serial.println(response);
//  } else {
//    Serial.print("Error sending FCM Notification. HTTP Error code: ");
//    Serial.println(httpResponseCode);
//  }

//  http.end();
// }

// get token value for smartphone
// void getToken() {

//  Serial.println("Requesting Token...");
//  if (Firebase.RTDB.getString(&fbdo, "/SmartPhone/Token")) {
//    if (fbdo.dataType() == "string") {
//      token = fbdo.stringData();
//      Serial.print("Success\ntoken: ");
//      Serial.println(token);
//    }
//  } else {
//    Serial.println(fbdo.errorReason());
//  }
// }

// void readSensor() {
//  potValueSF = analogRead(potPinSF);
//  potValueSP = analogRead(potPinSP);
//  potValueWL = analogRead(potPinWL);
//  potValueF = analogRead(potPinF);
// }