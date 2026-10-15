# StreetBite Appium tests

Java 17+, Maven, JUnit 5 and Appium (UiAutomator2) tests for the StreetBite Android app. A shared `BaseTest` creates the driver for the APK and saves a screenshot after every test, and each feature has its own class: `LoginTest` (valid login, invalid credentials, empty fields), `HomeTest` (scrolling the meals grid) and `CartTest` (adding a meal and checking the SnackBar).

## Before running

1. Build the APK from `flutter_app`: `flutter build apk --debug`. The default path in `src/test/resources/config.properties` points at the debug APK.
2. Sign up once in the app with the email and password from `config.properties`, so the valid login test has an account to use. Use a name that starts with a capital letter.
3. Connect a device or start the emulator and check `adb devices` shows it as `device`.
4. Start the Appium server in its own terminal: `appium`.

## Running

Run everything on one device:

```
mvn test -Dudid=<serial from adb devices> -Ddevice.name=Pixel_7_emulator
```

Run only the login tests on the physical phone:

```
mvn test -Dtest=LoginTest -Dudid=<phone serial> -Ddevice.name=Samsung_A366B
```

Screenshots land in `screenshots/` named after the device and the test, so runs on different devices do not overwrite each other. Any value in `config.properties` can be overridden with `-D`.

The app exposes two test hooks through `Semantics.identifier`: `add_to_cart_<id>` on the add buttons and `app_snackbar` on every SnackBar. Tests find them by `resource-id`.
