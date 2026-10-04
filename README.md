# Kabadi Mitra — Flutter (Android prototype)

Phone-style Flutter app for informal scrap collectors (college / SIH prototype).

**App name:** Kabadi Mitra / कबाड़ी मित्र / कबाडी मित्र  
**Add button:** कबाड़ जोड़ें / कबाड जोडा / Add scrap

**Chain:** COLLECT → IDENTIFY → VALUE → MATCH → HANDOVER → GET PAID → TRACE

**Roles:** Collector, Recycler, Admin

**Platform:** Android only

**Languages:** Hindi (default), Marathi, English — switch on Login, Onboarding, or Settings. Every label on every page updates immediately.

## Setup (Mac)

If `android/` is missing:

```bash
cd path/to/Kabadi_Mitra_Flutter
flutter create . --project-name kabadiwala_connect --platforms=android
```

Keep this `lib/` and `pubspec.yaml` if `flutter create` asks to overwrite.

### Camera / gallery permissions

In `android/app/src/main/AndroidManifest.xml`, inside `<manifest>`, **above** `<application>`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
```

## Run

Start a Pixel emulator (Android Studio → Device Manager → Play), then:

```bash
flutter pub get
flutter run
```

## Notes

- Demo auth only (no live login server)
- State is in-memory (resets when the app is killed)
- Theme: `lib/theme/app_theme.dart`
