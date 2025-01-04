import 'dart:io';

abstract class ApiService {
  Future<T> get<T>(
      String path, {
        required JsonConverterResponse<T> fromMap,
        Map<String, dynamic>? queryParameters,
      });

  Future<List<T>> getList<T>(
      String path, {
        required JsonConverterResponse<T> fromMap,
        String? key,
        Map<String, dynamic>? queryParameters,
      });

  Future<T> post<T>(
      String path, {
        dynamic data,
        required JsonConverterResponse<T> fromMap,
      });

  Future<T> put<T>(
      String path, {
        dynamic data,
        required JsonConverterResponse<T> fromMap,
      });

  Future<T> delete<T>(
      String path, {
        required JsonConverterResponse<T> fromMap,
      });

  Future<T> uploadFile<T>(
      String path, {
        required JsonConverterResponse<T> fromMap,
        File? file,
      });
}

typedef JsonConverterResponse<T> = T Function(Map<String, dynamic>);