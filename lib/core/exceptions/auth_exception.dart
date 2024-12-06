
// class ApiException implements Exception {
//   final String? message;
//   final int? statusCode;

//   ApiException(this.message, {this.statusCode});

//   @override
//   String toString() {
//     return 'ApiException: $message';
//   }

//   // You can add more logic here to handle different error cases
//   static ApiException fromDioError(DioException error) {
//     // Here you can transform Dio error into your custom ApiException
//     return ApiException(error.message, statusCode: error.response?.statusCode);
//   }
// }
 