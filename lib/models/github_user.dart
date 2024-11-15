class GithubUser {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final int publicRepos;
  final int followers;
  final int following;

  GithubUser({
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      bio: json['bio'],
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}
