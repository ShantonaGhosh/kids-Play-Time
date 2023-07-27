class ResponseObject {
  int id;
  Object object;

  ResponseObject({this.id = ResponseCode.NO_INTERNET_CONNECTION, required this.object});
}

class APIResponseCode {
  static const int OK = 200;
  static const int CREATED = 201;
  static const int BAD_REQUEST = 400;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int UNAUTHORIZED_ERROR = 401;
}

class ResponseCode {
  static const int NO_INTERNET_CONNECTION = 0;
  static const int AUTHORIZATION_FAILED = 401;
  static const int SUCCESSFUL = 500;
  static const int FAILED = 501;
  static const int NOT_FOUND = 502;
}
