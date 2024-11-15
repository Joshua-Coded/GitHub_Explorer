import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';
import '../models/repository.dart';
import '../models/commit.dart';

class GitHubService {
  static const String baseUrl = 'https://api.github.com';
  

  static const String _token = String.fromEnvironment('GITHUB_TOKEN', defaultValue: '');

  Map<String, String> get headers => {
    'Accept': 'application/vnd.github.v3+json',
    'Content-Type': 'application/json',
    if (_token.isNotEmpty) 'Authorization': 'Bearer $_token',
  };

  Future<List<GithubUser>> searchUsers(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search/users?q=$query'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> items = data['items'];
        return items.map((json) => GithubUser.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<GithubUser> getUser(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$username'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return GithubUser.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Repository>> getUserRepositories(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$username/repos?sort=updated'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Repository.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Commit>> getRepositoryCommits(String username, String repo) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/repos/$username/$repo/commits'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Commit>.from(data.map((json) => Commit.fromJson(json)));
      } else {
        throw Exception('Failed to load commits: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}