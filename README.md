# note-pro

[![Flutter CI](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml/badge.svg)](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml)

A Flutter notes application that stores notes locally on the device. This project demonstrates Flutter UI composition, local JSON persistence, note creation, editing, reading, deletion, timestamps, and themed note cards.

## Features

- View locally stored notes in a two-column grid
- Create notes with a title and body
- Open and read a note
- Edit an existing note
- Delete a note
- Assign a color to each note
- Display note creation dates

## Technology

- Flutter and Dart
- Shared Preferences for local persistence
- Material Design
- Google Fonts
- intl for date formatting

## Current repository status

The repository includes a standard Flutter application scaffold, a local notes repository under `lib/services/`, the note screens and widgets under `lib/`, dependency metadata, and a basic Flutter test. No Firebase project, account, or credentials are required.

## Required next steps

1. Run `flutter pub get` to install dependencies.
2. Run the app on an Android, iOS, desktop, or web target.
3. Notes are saved locally on the device and are not synchronized between devices.
4. Run `flutter analyze` and `flutter test` before publishing a release.

## Build for the web

```powershell
flutter build web --release
```

The generated web app is written to `build/web`. Browser notes are stored in that browser's local storage and are not shared with the mobile or desktop versions.

The GitHub Actions workflow also uploads the generated `build/web` directory as a downloadable `notes-pro-web-build` artifact for successful CI runs.

## Optional GitHub Pages deployment

The repository includes a manual [GitHub Pages workflow](./.github/workflows/deploy-pages.yml). To publish the web app, enable **GitHub Pages** with **GitHub Actions** as the source in the repository settings, then run **Deploy note-pro web app** from the Actions tab. The published URL will be:

```text
https://abjahid525.github.io/note-pro/
```

The current version intentionally prioritizes a simple offline-first experience. Cloud synchronization and authentication can be added later as a separate feature.
