import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  SharedPreferences? _sharedPreferences;
  LocalStorageServiceImpl();

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveString({required String key, required String value}) async {
    if (_sharedPreferences == null) await init();
    _sharedPreferences?.setString(key, value);
  }

  @override
  Future<String?> getString({required String key, String? defaultValue}) async {
    if (_sharedPreferences == null) await init();
    return _sharedPreferences?.getString(key) ?? defaultValue;
  }

  @override
  Future<void> saveInt({required String key, required int value}) async {
    if (_sharedPreferences == null) await init();
    _sharedPreferences?.setInt(key, value);
  }

  @override
  Future<int?> getInt({required String key, int? defaultValue}) async {
    if (_sharedPreferences == null) await init();
    return _sharedPreferences?.getInt(key) ?? defaultValue;
  }

  @override
  Future<void> saveMap(
      {required String key, required Map<String, dynamic> jsonMap}) async {
    if (_sharedPreferences == null) await init();
    await _sharedPreferences?.setString(key, json.encode(jsonMap));
  }

  @override
  Future<bool?> removeValue({required String key}) async {
    if (_sharedPreferences == null) await init();
    return _sharedPreferences?.remove(key);
  }

  @override
  Future<Map<String, dynamic>?> getMap<T>({required String key}) async {
    if (_sharedPreferences == null) await init();
    final String? value = _sharedPreferences?.getString(key);
    if (value != null) {
      return json.decode(_sharedPreferences?.getString(key) ?? '')
          as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  @override
  Future<bool?> getBool({required String key, bool? defaultValue}) async {
    if (_sharedPreferences == null) await init();

    return _sharedPreferences?.getBool(key) ?? defaultValue;
  }

  @override
  Future<void> saveBool({required String key, required bool value}) async {
    if (_sharedPreferences == null) await init();

    await _sharedPreferences?.setBool(key, value);
  }
}

class AppSecureStorageImpl implements LocalStorageService {
  AppSecureStorageImpl(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> saveString({required String key, required String value}) async {
    _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getString({required String key, String? defaultValue}) async {
    return await _secureStorage.read(key: key) ?? defaultValue;
  }

  @override
  Future<void> saveInt({required String key, required int value}) async {
    _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<int?> getInt({required String key, int? defaultValue}) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? defaultValue : int.parse(value);
  }

  @override
  Future<void> saveMap(
      {required String key, required Map<String, dynamic> jsonMap}) async {
    await _secureStorage.write(key: key, value: json.encode(jsonMap));
  }

  @override
  Future<bool> removeValue({required String key}) async {
    return _secureStorage.delete(key: key).then((value) => true);
  }

  @override
  Future<Map<String, dynamic>?> getMap<T>({required String key}) async {
    final value = await _secureStorage.read(key: key);

    return value == null ? null : json.decode(value) as Map<String, dynamic>;
  }

  @override
  Future<bool?> getBool({required String key, bool? defaultValue}) async {
    final value = await _secureStorage.read(key: key);
    return value == null
        ? defaultValue
        : value.toLowerCase() == 'true'
            ? true
            : false;
  }

  @override
  Future<void> saveBool({required String key, required bool value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }
}
