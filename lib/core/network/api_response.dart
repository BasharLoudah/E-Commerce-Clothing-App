// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiResponse {
  final int statusCode;
  final Map<String, dynamic> body; // must be object 
  ApiResponse({
    required this.statusCode,
    required this.body,
  });
}
