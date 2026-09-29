# KabadiMitra (Android prototype)

Phone-style Flutter app for informal scrap collectors.

Chain: COLLECT → IDENTIFY → VALUE → MATCH → HANDOVER → VERIFY → GET PAID → TRACE

Roles: Collector, Recycler, Admin

Platform: Android only

Languages: Hindi (default), English

## Setup

```bash
flutter create . --project-name kabadiwala_connect --platforms=android
flutter pub get
```

### Camera permissions

In android/app/src/main/AndroidManifest.xml inside manifest, above application:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
```

Set android:label="KabadiMitra" on the application tag.

## Run

```bash
flutter run
```

## Build APK

```bash
flutter build apk --release
```

APK path: build/app/outputs/flutter-apk/app-release.apk

## Notes

- Demo auth only (no backend)
- State is in-memory (resets on restart)
- Themes: Default (light) and Dark
