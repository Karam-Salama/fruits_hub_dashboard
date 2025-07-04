class UserEntity {
  final String name;
  final String email;
  final String? password;

  final String uId;
  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
    this.password,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? password,
    String? uId,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      uId: uId ?? this.uId,
      password: password ?? this.password,
    );
  }
}
