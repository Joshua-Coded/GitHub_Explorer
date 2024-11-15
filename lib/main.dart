// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/search_users_screen.dart';
import 'services/github_service.dart';
import 'models/github_user.dart';
import 'models/repository.dart';
import 'models/commit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchUsersScreen(),
    );
  }
}
