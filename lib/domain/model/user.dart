class User {
  final String id;

  User({required this.id});

  @override
  int get hashCode => Object.hashAll([id]);

  @override
  bool operator ==(Object other) {
    if (other is! User) {
      return false;
    }
    return id == other.id;
  }
}
