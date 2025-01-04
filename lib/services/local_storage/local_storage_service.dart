abstract class LocalStorageService {
  Future<void> saveString({required String key, required String value});

  getString({required String key, String? defaultValue});

  Future<void> saveInt({required String key, required int value});

  getInt({required String key, int? defaultValue});

  Future<bool> removeValue({required String key});

  Future<void> saveMap({required String key, required Map<String, dynamic> jsonMap});

  getMap<T>({required String key});

  Future<void> saveBool({required String key, required bool value});

  getBool({required String key, bool? defaultValue});
}
