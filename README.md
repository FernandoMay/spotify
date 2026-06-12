# Spotify

Unofficial Flutter Spotify client with audio playback.

## Stack

- **Flutter** — Cross-platform mobile app (Material 3, dark theme)
- **Spotify SDK** — Native Spotify authentication & playback
- **Audio Players** — Local audio playback support
- **Dotenv** — Environment configuration

## Quick Start

```bash
flutter pub get
cp .env.example .env
# Edit .env with your Spotify API credentials
flutter run
```

## Tests

```bash
flutter test
```

## CI/CD

GitHub Actions workflow runs on push/PR to `main`, `develop`, `master`:
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
