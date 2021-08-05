# digitizing_prescriptions

<p>A Flutter application that converts prescriptions to text.</p>

- Pick any image in your gallery and get it displayed as text.
- Take a photo of your prescription and get it converted it as text.
- Share the text as pdf or copy and share it anywhere you want.

### Packages Used

- [camera](https://pub.dev/packages/camera)
- [path_provider](https://pub.dev/packages/path_provider)
- [intl](https://pub.dev/packages/intl)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [firebase_ml_vision](https://pub.dev/packages/firebase_ml_vision)
- [firebase_storage](https://pub.dev/packages/firebase_storage)
- [image_picker](https://pub.dev/packages/image_picker)
- [pdf](https://pub.dev/packages/pdf)

## Installation

1.  First you need to have [Android Studio](https://developer.android.com/studio/install)/[VS Code](https://code.visualstudio.com/) installed in your device.
2.  Clone this repo using this command below <br/>
    `git clone https://github.com/arungovindm2001/digitizing-prescriptions`
3.  Open the project with Android Studio/VS Code.
4.  Sign into [Firebase Console](https://console.firebase.google.com/).
5.  Create an app.
6.  Add your SHA1 key in project settings. Click [here](https://developers.google.com/android/guides/client-auth) to know how to get it.
7.  Enable Firebase Authentication and Firebase Storage.
8.  Install the required dependencies by the following command<br>
    `flutter pub get`
7.  Run the app using `flutter run`
