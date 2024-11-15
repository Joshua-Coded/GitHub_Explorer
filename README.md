# GitHub Explorer

<div align="center">

![GitHub Explorer Logo](insert_logo_url_here)

A Flutter mobile application for exploring GitHub users and repositories, developed as part of the ALU Mobile Development module.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Screenshots](#screenshots) • [Contributing](#contributing)

</div>

## Features

- 🔍 Search GitHub users
- 👤 View detailed user profiles
- 📚 Explore user repositories
- 💻 View commit histories
- 🌙 Dark theme support
- 📱 Responsive design

## Installation

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Git
- GitHub API Token (for higher rate limits)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/Joshua-Coded/GitHub_Explorer_App.git
cd GitHub_Explorer_App
```

2. Install dependencies:
```bash
flutter pub get
```

3. Create a file named `.env` in the root directory and add your GitHub token:
```
GITHUB_TOKEN=your_token_here
```

4. Run the app:
```bash
flutter run
```

## Usage

### Search Users
- Launch the app
- Enter a username in the search bar
- Tap on a user to view their profile

### View Profile
- See user details
- View repositories list
- Check follower and following counts

### Explore Repositories
- Tap on any repository to view details
- Check commit history
- View repository statistics

## Screenshots

<div align="center">

| Search Screen | Profile Screen | Commits Screen |
|--------------|----------------|----------------|
| [Image 1]    | [Image 2]      | [Image 3]      |

</div>

## Project Structure

```
lib/
  ├── models/
  │   ├── github_user.dart
  │   ├── repository.dart
  │   └── commit.dart
  ├── screens/
  │   ├── search_users_screen.dart
  │   ├── user_profile_screen.dart
  │   └── commits_screen.dart
  ├── services/
  │   └── github_service.dart
  └── main.dart
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
  intl: ^0.18.0
```

## Running Tests

```bash
flutter test
```

## Project Status

This project was developed as part of the ALU Mobile Development module and is currently in a completed state for submission. Future updates may be made for educational purposes.

## Author

**Joshua Alana**
- GitHub: [@yourgithub](https://github.com/Joshua-Coded/GitHub_Explorer_App.git)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)

## Acknowledgments

- ALU Mobile Development Course Instructors
- Flutter Development Team
- GitHub API Documentation Team

## Contributing

As this is an educational project, contributions are welcome but should follow these steps:
1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Course Information

- **Institution**: African Leadership University
- **Course**: Mobile Development
- **Term**: 2024
- **Instructor**: [Samiratu]

---

<div align="center">

Made with ❤️ by Joshua Alana

</div>
