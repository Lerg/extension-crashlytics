# Crashlytics Extension for Defold

This extension wraps Firebase Crashlytics SDK for iOS. On other platforms this extension provides stub functions.

# Project Setup

Use admob extension as the dependency because of the shared GoogleUtilities.framework.

Download GoogleService-Info.plist from Firebase console and place it to the bundle resources directory in your project (e.g. `res/ios/`).

When building check the generate debug symbols option and use crashlytics/external/uploda_ios.sh script to uplod a dSYM file to the Firebase console.

# API reference

## crashlytics.init()

Call this function before invoking any other functions.

### `params` reference

- `api_key`, string, required. API key.

### Syntax

```language-lua
crashlytics.init()
```
