class Repository {
  final String name;
  final String? description;
  final int stargazersCount;
  final String defaultBranch;
  final String language;
  final DateTime updatedAt;

  Repository({
    required this.name,
    this.description,
    required this.stargazersCount,
    required this.defaultBranch,
    required this.language,
    required this.updatedAt,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'],
      stargazersCount: json['stargazers_count'],
      defaultBranch: json['default_branch'],
      language: json['language'] ?? 'Unknown',
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
