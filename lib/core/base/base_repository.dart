import 'package:dio/dio.dart';

abstract class BaseRepository {
  final Dio dio;
  
  BaseRepository(this.dio);
  
  Future<T> handleRequest<T>(
    Future<Response> request, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await request;
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
  
  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('Connection error');
      default:
        return Exception('Network error');
    }
  }
}

