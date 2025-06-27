class Token {
  final String jwt;
  final String refreshTkn;

  Token({required this.jwt, required this.refreshTkn});

  @override
  int get hashCode => Object.hashAll([jwt, refreshTkn]);

  @override
  bool operator ==(Object other) {
    if (other is! Token) {
      return false;
    }
    return jwt == other.jwt && refreshTkn == other.refreshTkn;
  }
}