import 'dart:async';
import 'package:uuid/uuid.dart';

import '../local_storage/local_storage_service.dart';
import 'token_service.dart';

class TokenServiceImpl extends TokenService {
  TokenServiceImpl(this._appSecureStorage);
  final LocalStorageService _appSecureStorage;

  static const _accessTokenKey = 'access_token_key';
  static const _refreshTokenKey = 'refresh_token_key';

  String? _accessToken;
  String? _refreshToken;

  @override
  Future<String?> getAccessToken() async {
    if (_accessToken == null) {
      final secureStorageKey =
          await _appSecureStorage.getString(key: _accessTokenKey);

      if (secureStorageKey == null) {
        return Future.value(null);
      }
      _accessToken = await _appSecureStorage.getString(key: secureStorageKey);
    }

    return _accessToken;
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    final uuidToken = const Uuid().v4();

    await _appSecureStorage.saveString(key: _accessTokenKey, value: uuidToken);

    await _appSecureStorage.saveString(key: uuidToken, value: accessToken);
  }

  @override
  Future<bool> clearAccessToken() async {
    _accessToken = null;

    final secureStorageKey =
        await _appSecureStorage.getString(key: _accessTokenKey);

    if (secureStorageKey != null) {
      await _appSecureStorage.removeValue(key: secureStorageKey);
    }

    final hasRemoved =
        await _appSecureStorage.removeValue(key: _accessTokenKey);

    return hasRemoved ?? false;
  }

  @override
  Future<bool> isAlreadyLoggedIn() async {
    return (await getAccessToken()) != null;
  }

  @override
  Future<bool> clearRefreshToken() async {
    _refreshToken = null;

    final secureStorageKey =
        await _appSecureStorage.getString(key: _refreshTokenKey);

    if (secureStorageKey != null) {
      await _appSecureStorage.removeValue(key: secureStorageKey);
    }

    final hasRemoved =
        await _appSecureStorage.removeValue(key: _refreshTokenKey);

    return hasRemoved ?? false;
  }

  @override
  Future<String?> getRefreshToken() async {
    if (_refreshToken == null) {
      final secureStorageKey =
          await _appSecureStorage.getString(key: _refreshTokenKey);

      if (secureStorageKey == null) {
        return Future.value(null);
      }
      _refreshToken = await _appSecureStorage.getString(key: secureStorageKey);
    }

    return _refreshToken;
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    final uuidToken = const Uuid().v4();

    await _appSecureStorage.saveString(key: _refreshTokenKey, value: uuidToken);

    await _appSecureStorage.saveString(key: uuidToken, value: refreshToken);
  }
}
