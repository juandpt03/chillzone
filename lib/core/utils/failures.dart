import 'package:dio/dio.dart';

class HttpRequestFailure {
  final _HttpRequestFailureType _type;

  const HttpRequestFailure._(this._type);

  static const HttpRequestFailure network =
      HttpRequestFailure._(_HttpRequestFailureType.network);
  static const HttpRequestFailure notFound =
      HttpRequestFailure._(_HttpRequestFailureType.notFound);
  static const HttpRequestFailure server =
      HttpRequestFailure._(_HttpRequestFailureType.server);
  static const HttpRequestFailure unauthorized =
      HttpRequestFailure._(_HttpRequestFailureType.unauthorized);
  static const HttpRequestFailure badRequest =
      HttpRequestFailure._(_HttpRequestFailureType.badRequest);
  static const HttpRequestFailure local =
      HttpRequestFailure._(_HttpRequestFailureType.local);

  static HttpRequestFailure fromCode(int? code) {
    if (code == null) return HttpRequestFailure.badRequest;

    if (code >= 500) return HttpRequestFailure.server;

    if (code == 404) return HttpRequestFailure.notFound;

    if (code == 401 || code == 403) return HttpRequestFailure.unauthorized;

    return HttpRequestFailure.local;
  }

  static HttpRequestFailure fromException(Object e) {
    if (e is HttpRequestFailure) return e;
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        return HttpRequestFailure.fromCode(e.response?.statusCode);
      }
      return HttpRequestFailure.network;
    }
    return HttpRequestFailure.local;
  }

  T when<T>({
    required T Function() network,
    required T Function() notFound,
    required T Function() server,
    required T Function() unauthorized,
    required T Function() badRequest,
    required T Function() local,
  }) {
    switch (_type) {
      case _HttpRequestFailureType.network:
        return network();
      case _HttpRequestFailureType.notFound:
        return notFound();
      case _HttpRequestFailureType.server:
        return server();
      case _HttpRequestFailureType.unauthorized:
        return unauthorized();
      case _HttpRequestFailureType.badRequest:
        return badRequest();
      case _HttpRequestFailureType.local:
        return local();
    }
  }

  T map<T>({
    required T Function(HttpRequestFailure) network,
    required T Function(HttpRequestFailure) notFound,
    required T Function(HttpRequestFailure) server,
    required T Function(HttpRequestFailure) unauthorized,
    required T Function(HttpRequestFailure) badRequest,
    required T Function(HttpRequestFailure) local,
  }) {
    switch (_type) {
      case _HttpRequestFailureType.network:
        return network(this);
      case _HttpRequestFailureType.notFound:
        return notFound(this);
      case _HttpRequestFailureType.server:
        return server(this);
      case _HttpRequestFailureType.unauthorized:
        return unauthorized(this);
      case _HttpRequestFailureType.badRequest:
        return badRequest(this);
      case _HttpRequestFailureType.local:
        return local(this);
    }
  }
}

enum _HttpRequestFailureType {
  network,
  notFound,
  server,
  unauthorized,
  badRequest,
  local,
}
