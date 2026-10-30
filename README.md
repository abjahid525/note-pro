# note-pro

[![Flutter CI](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml/badge.svg)](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml)
[![Live Demo](https://img.shields.io/badge/Live%20Demo-Notes%20Pro-00acc1?logo=googlechrome&logoColor=white)](https://abjahid525.github.io/note-pro/)

A Flutter notes application that stores notes locally on the device. This project demonstrates Flutter UI composition, local JSON persistence, note creation, editing, reading, deletion, timestamps, and themed note cards.

## Try it online

Open the [live web demo](https://abjahid525.github.io/note-pro/) to try the application without installing Flutter. Notes created in the demo are stored only in your current browser.

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

The repository includes a standard Flutter application scaffold, a local notes repository under `lib/services/`, the note screens and widgets under `lib/`, dependency metadata, automated tests, and a live web demo. No Firebase project, account, or credentials are required.

## Run locally

1. Run `flutter pub get` to install dependencies.
2. Run the app on an Android, iOS, desktop, or web target.
3. Notes are saved locally on the device and are not synchronized between devices.

## Quality checks

Run the same checks used by GitHub Actions before opening a pull request:

```powershell
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

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
