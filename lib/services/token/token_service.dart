abstract class TokenService {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String accessToken);

  Future<bool?> clearAccessToken();

  Future<String?> getRefreshToken();

  Future<void> setRefreshToken(String refreshToken);

  Future<bool> clearRefreshToken();

  Future<bool> isAlreadyLoggedIn();
}
