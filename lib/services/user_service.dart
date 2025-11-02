import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://yourapiurl.com/api'), // غيريها حسب API مشروعك
  );

  Future<void> sendOtp(String email) async {
    try {
      await _dio.post('/auth/send-otp', data: {'email': email});
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      await _dio.post('/auth/verify-otp', data: {'otp': otp});
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }

  Future<void> resetPassword(String newPassword) async {
    try {
      await _dio.post('/auth/reset-password', data: {'password': newPassword});
    } catch (e) {
      throw Exception('Error resetting password: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      final response = await _dio.get('/user');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
