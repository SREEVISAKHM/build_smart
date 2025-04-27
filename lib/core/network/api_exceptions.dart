// Exception handling class
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? response;

  ApiException({
    required this.message,
    this.statusCode,
    this.response,
  });

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
  }

  // Helper method to get user-friendly error message
  static String getUserFriendlyMessage(int statusCode) {
    String message = '';
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Authentication failed. Please login again.';
      case 403:
        return 'You don\'t have permission to access this resource.';
      case 404:
        return 'The requested resource was not found.';
      case 500:
      case 501:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      case null:
        return 'Network error. Please check your connection.';
      default:
        return message;
    }
  }

  // Factory constructors for different error types
  factory ApiException.fromResponse(int statusCode, String response) {
    String message = getUserFriendlyMessage(statusCode);

    return ApiException(
      message: message,
      statusCode: statusCode,
      response: response,
    );
  }

  factory ApiException.network() {
    return ApiException(
      message: 'Network error occurred',
    );
  }

  factory ApiException.timeout() {
    return ApiException(
      message: 'Request timed out',
    );
  }

  /// Factory for unknown/unexpected errors
  factory ApiException.unknown([String? error]) {
    return ApiException(
      message: error ?? 'An unknown error occurred.',
    );
  }
}
