class User {
  final String username;
  final String id;
  final String provider;
  final String providerId;
  String token;

  User(this.username, this.id, this.provider, this.providerId) : token = '';

  User.copySetToken(User existingUser, String newToken)
      : username = existingUser.username,
        id = existingUser.id,
        provider = existingUser.provider,
        providerId = existingUser.providerId,
        token = newToken;
}
