class GithubRepoModel {
  final int id;
  final String name;
  final bool private;
  final String fullName;
  final String? description;
  final String htmlUrl;
  final int stargazersCount;
  final int forksCount;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GithubOwner owner;

  bool isFavouriteRepo;

  GithubRepoModel({
    required this.id,
    required this.private,
    required this.name,
    required this.fullName,
    this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
    this.isFavouriteRepo = false,
  });

  factory GithubRepoModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoModel(
      id: json['id'],
      name: json['name'],
      private: json['private'],
      fullName: json['full_name'],
      description: json['description'],
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      language: json['language'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      owner: GithubOwner.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'private': private,
      'full_name': fullName,
      'description': description,
      'html_url': htmlUrl,
      'stargazers_count': stargazersCount,
      'forks_count': forksCount,
      'language': language,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'owner': owner.toJson(),
      'is_favourite_repo': isFavouriteRepo,
    };
  }

  GithubRepoModel copyWith({
    int? id,
    String? name,
    String? fullName,
    String? description,
    bool? private,
    String? htmlUrl,
    int? stargazersCount,
    int? forksCount,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
    GithubOwner? owner,
    bool? isFavouriteRepo,
  }) {
    return GithubRepoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      private: private?? this.private,
      fullName: fullName ?? this.fullName,
      description: description ?? this.description,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      forksCount: forksCount ?? this.forksCount,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      owner: owner ?? this.owner,
      isFavouriteRepo: isFavouriteRepo ?? this.isFavouriteRepo,
    );
  }

  @override
  String toString() {
    return 'GithubRepoModel{id: $id, name: $name, owner: ${owner.login}, isFavourite: $isFavouriteRepo}';
  }
}

class GithubOwner {
  final String login;
  final int id;
  final String? avatarUrl;
  final String htmlUrl;

  GithubOwner({
    required this.login,
    required this.id,
    this.avatarUrl,
    required this.htmlUrl,
  });

  factory GithubOwner.fromJson(Map<String, dynamic> json) {
    return GithubOwner(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }
}
