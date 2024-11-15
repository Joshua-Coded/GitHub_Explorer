class Commit {
  final String sha;
  final String message;
  final String authorName;
  final DateTime date;

  Commit({
    required this.sha,
    required this.message,
    required this.authorName,
    required this.date,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      sha: json['sha'],
      message: json['commit']['message'],
      authorName: json['commit']['author']['name'],
      date: DateTime.parse(json['commit']['author']['date']),
    );
  }
}
