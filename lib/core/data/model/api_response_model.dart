import 'package:equatable/equatable.dart';

class ApiResponseModel extends Equatable {
  final String url;
  final Map<String, String> headers;
  final String body;
  final int statusCode;

  const ApiResponseModel({
    required this.url,
    required this.headers,
    required this.body,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        url,
        headers,
        body,
        statusCode,
      ];
}
