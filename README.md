<div align="center">

# Local Notifications in Flutter

### Reference implementation for immediate and scheduled local notifications

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Notifications](https://img.shields.io/badge/Local-Notifications-8B5CF6?style=flat-square)](#features)
[![Timezone](https://img.shields.io/badge/Scheduling-Timezone-10B981?style=flat-square)](#features)

</div>

## Overview

This project demonstrates the core setup needed to initialize, display, schedule, and respond to local notifications in a Flutter application.

## Features

- Android and iOS initialization settings.
- Android notification-channel creation.
- Runtime notification-permission request.
- Immediate and timezone-aware scheduled notifications.
- Notification response and payload callbacks.
- List-style notification content example.

## Key files

- `lib/notification_service.dart` - initialization, channels, scheduling, and callbacks.
- `lib/main.dart` - permission request and example notification actions.
- `lib/model.dart` - notification item model used by the demo.

## Getting started

```bash
flutter pub get
flutter run
```

Review the Android manifest and iOS notification capabilities before using the reference in a production application. Test scheduling behavior on a physical device because platform power-management rules can affect delivery.

## Maintainer

[Abdelrahman Dandash](https://github.com/27dandash) - Flutter Developer
