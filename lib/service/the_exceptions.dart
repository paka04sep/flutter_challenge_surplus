class TheException implements Exception {
  final String message;
  final int? statusCode;

  TheException(this.message, {this.statusCode});

  String displayError() => message;
}
