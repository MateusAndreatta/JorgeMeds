# JorgeMeds
<img src="https://s3-us-west-1.amazonaws.com/udacity-content/rebrand/svg/logo.min.svg" width="150" alt="Udacity logo">

Application developed during the iOS Developer Nanodegree by Udacity.

This app is used for medication stock control and reminders through push notifications.

![App Icon](https://github.com/MateusAndreatta/JorgeMeds/blob/main/JorgeMeds/Assets.xcassets/AppIcon.appiconset/mac256.png)

## 🚀 Features:

* Login/Register with Firebase Auth
* Edit profile name
* Medication management
* Allergies management
* Push notifications
* Multiple language support (currently only Portuguese and English)

## 🎬 Preview

<details>
  <summary>Sign in / Sign up</summary>
  
  ![Sign in / Sign up](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/Sign%20In%20%3A%20Sign%20Up.png)
</details>

<details>
  <summary>Home</summary>
 
  ![Home](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/Home.png)
</details>

<details>
  <summary>Add Medication</summary>
 
  ![Add Medication](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/add%20medication%20screen.gif)
</details>

<details>
  <summary>Information Screen</summary>
 
  ![Information Screen](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/information%20screen.png)
</details>

<details>
  <summary>Add Allergy</summary>
 
  ![Add Allergy](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/add%20allergy.gif)
</details>

<details>
  <summary>Settings</summary>
 
  ![Settings](https://github.com/MateusAndreatta/JorgeMeds/blob/main/Preview/Settings.png)
</details>

## 💥 Compatibility

  * iOS 16.4 +
  * Swift 5
  * Xcode 15.4

## 🧪 How to test?

1. Clone this project using

`git clone https://github.com/MateusAndreatta/JorgeMeds.git`

2. Open the project in Xcode
3. Build it on a simulator or real device
4. You can create a new account or use this one for testing:
   * Email: test@udacity.com
   * Password: udacity123

#### Testing Push

⚠️ For this test, you must run the app on a real device!

1. Go to settings screen, and make sure that notifications are on.
2. Add a new medication or edit one, setting time for when you want to receive
3. Click the save button.
4. That's all! Just close the app and wait for the push notification.

#### Testing multiple languages support

For the best UX, the app uses the device's preferred language. For example:
If the device's preferred language is English, the app will be in english as well.
If the device's preferred language is Brazilian Portuguese, the app will be in Portuguese.
For any other language, the app will use English as the default language.

Changing your device's preferred language
1. Open the 'Settings' app
2. Go to 'General'
3. Tap on 'Language & Region'
4. Then 'Add Language...'

## ✔️ Changelog

### Version: 1.0

  * Initial build
