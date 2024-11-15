// lib/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import '../services/github_service.dart';
import '../models/github_user.dart';
import '../models/repository.dart';
import 'commits_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;

  const UserProfileScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GitHubService _gitHubService = GitHubService();
  late Future<GithubUser> _userFuture;
  late Future<List<Repository>> _repositoriesFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _gitHubService.getUser(widget.username);
    _repositoriesFuture = _gitHubService.getUserRepositories(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF161B22),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2DBA4E),
                      const Color(0xFF161B22).withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<GithubUser>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF2DBA4E)),
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final user = snapshot.data!;
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    Hero(
                      tag: user.avatarUrl,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2DBA4E),
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(user.avatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name ?? user.login,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (user.bio != null) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          user.bio!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    _buildStatsCard(user),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.book, color: Color(0xFF2DBA4E), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Repositories',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
          _buildRepositoriesList(),
        ],
      ),
    );
  }

  Widget _buildStatsCard(GithubUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('Repositories', user.publicRepos, Icons.book),
              _buildStatDivider(),
              _buildStat('Followers', user.followers, Icons.people),
              _buildStatDivider(),
              _buildStat('Following', user.following, Icons.person_add),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, int value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF2DBA4E)),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[800],
    );
  }

  Widget _buildRepositoriesList() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: FutureBuilder<List<Repository>>(
        future: _repositoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2DBA4E)),
              )),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                  child: Text(
                'No repositories',
                style: TextStyle(color: Colors.grey),
              )),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final repo = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: const Color(0xFF161B22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommitsScreen(
                            username: widget.username,
                            repository: repo,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            repo.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          if (repo.description != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              repo.description!,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: _getLanguageColor(repo.language),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                repo.language,
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.star_border,
                                size: 16,
                                color: Color(0xFF2DBA4E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                repo.stargazersCount.toString(),
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFF2DBA4E),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: snapshot.data!.length,
            ),
          );
        },
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Colors.blue;
      case 'javascript':
        return Colors.yellow;
      case 'python':
        return Colors.green;
      case 'java':
        return Colors.orange;
      case 'kotlin':
        return Colors.purple;
      case 'swift':
        return Colors.orange;
      case 'typescript':
        return Colors.blue;
      case 'html':
        return Colors.red;
      case 'css':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
