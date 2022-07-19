import 'package:dio/dio.dart';
import 'package:movie_app/core/models/result.dart';

class ApiExceptions implements Exception{


  handleErrors(DioError error){
    switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return Result.fail(
            BackendError(
              statusCode: 408,
              description: error.error,
              err: 'TimeOut',
            ),
          );
        default:
          return Result.fail(
            BackendError(
              data: error.response?.data is String
                  ? {"message": ''}
                  : (error.response!.data as Map),
              description: error.message,
              err: error.error.toString(),
              statusCode: error.response?.statusCode ?? -1,
            ),
          );
      }
  }
  

}
