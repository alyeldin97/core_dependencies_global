import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../token/token_model.dart';
import '../token/token_service.dart';
import 'network_service.dart';
import 'failure.dart';

class DioNetworkServiceImpl implements NetworkService {
  final Dio _dio;
  TokenService tokenService;

  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  DioNetworkServiceImpl(this._dio, this.tokenService) {
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    ));

    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    _dio.httpClientAdapter = DefaultHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        client = httpClient;
        return client;
      };
  }

  @override
  Future<T> get<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()));
    if (response.statusCode! > 300) throw _handleError(response);
    return fromMap(response.data);
  }

  @override
  Future<List<T>> getList<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    String? key,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()));
    if (response.statusCode! > 300) throw _handleError(response);

    return (response.data[key ?? 'data'] as List<dynamic>)
        .map((e) => fromMap(e))
        .toList();
  }

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    required JsonConverterResponse<T> fromMap,
  }) async {
    final response = await _dio.post(path,
        data: data, options: Options(headers: await _getHeaders()));
    if (response.statusCode! > 300) throw _handleError(response);

    return fromMap(response.data);
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    required JsonConverterResponse<T> fromMap,
  }) async {
    final response = await _dio.put(path,
        data: data, options: Options(headers: await _getHeaders()));
    if (response.statusCode! > 300) throw _handleError(response);

    return fromMap(response.data);
  }

  @override
  Future<T> delete<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
  }) async {
    final response =
        await _dio.delete(path, options: Options(headers: await _getHeaders()));
    if (response.statusCode! > 300) throw _handleError(response);

    return fromMap(response.data);
  }

  @override
  Future<T> uploadFile<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    File? file,
  }) async {
    FormData? formData = file == null
        ? null
        : FormData.fromMap(
            {
              "image": await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              )
            },
          );

    final response = await _dio.post(
      path,
      options: Options(contentType: "multipart/form-data", headers: {
        'Authorization': 'Bearer {AppGlobalData.ACCESS_TOKEN ?? ' '}'
      }),
      data: formData,
    );

    if (response.statusCode! > 300) throw _handleError(response);

    return fromMap(response.data);
  }

  Failure _handleError(response) {
    try {
      Map errorBody = jsonDecode(response.data);
      String key = errorBody.entries.first.key;
      String message = errorBody[key];
      Failure failure = ServerFailure(
        response.statusCode,
        errorMessage: message,
      );
      return failure;
    } catch (exception) {
      return UnknownFailure(errorMessage: exception.toString());
    }
  }

  DateTime? _getExpiryDate(String? accessToken) {
    try {
      final parts = accessToken?.split('.') ?? [];
      if (parts.length != 3) {
        return null;
      }
      final payload = parts[1];
      var normalized = base64Url.normalize(payload);
      var resp = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(resp);
      if (payloadMap is! Map<String, dynamic>) {
        return null;
      }

      return DateTime.fromMillisecondsSinceEpoch(payloadMap['exp'] * 1000);
    } catch (e) {
      return null;
    }
  }

  Future<Failure?> _refreshToken() async {
    /// refreshToken won't be null unless
    /// the previous response for the refresh api returned a null refresh_token
    /// and the user still haven't got out of the secured route

    String? refreshToken = await tokenService.getRefreshToken();
    if (refreshToken == null) {
      return ServerFailure(401);
    }

    final TokenModel response = await post("token/refresh",
        data: {"refresh_token": refreshToken}, fromMap: TokenModel.fromMap);

    tokenService.setAccessToken(response.accessToken);

    return null;
  }

  Future<Map<String, String>> _getHeaders({
    Map<String, String>? headers,
    String? version,
    bool? skipToken,
  }) async {
    Map<String, String> requestHeaders = {};

    requestHeaders.addAll(defaultHeaders);

    if (headers != null) requestHeaders.addAll(headers);

    if (version != null) {
      requestHeaders['accept-version'] = version;
    }

    if (skipToken != true) {
      if (_getExpiryDate(await tokenService.getAccessToken())
              ?.isBefore(DateTime.now()) ??
          true) {
        await _refreshToken();
      }
      requestHeaders["Authorization"] =
          "Bearer ${await tokenService.getAccessToken()}";
    }

    return requestHeaders;
  }
}

class DummyNetworkService implements NetworkService {
  @override
  Future<List<T>> getList<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    String? key,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _delay();
    return List.generate(
            10, (index) => fromMap({"sad": "adsdsa"} as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<T> get<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _delay();

    return fromMap({"sad": "adsdsa"} as Map<String, dynamic>);
  }

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    required JsonConverterResponse<T> fromMap,
  }) async {
    await _delay();

    return fromMap({"sad": "adsdsa"} as Map<String, dynamic>);
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    required JsonConverterResponse<T> fromMap,
  }) async {
    await _delay();

    return fromMap({"sad": "adsdsa"} as Map<String, dynamic>);
  }

  @override
  Future<T> delete<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
  }) async {
    await _delay();

    return fromMap({"sad": "adsdsa"} as Map<String, dynamic>);
  }

  @override
  Future<T> uploadFile<T>(
    String path, {
    required JsonConverterResponse<T> fromMap,
    File? file,
  }) async {
    await _delay();
    return fromMap({"sad": "adsdsa"} as Map<String, dynamic>);
  }

  _delay() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
