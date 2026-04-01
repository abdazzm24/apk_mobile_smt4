import 'package:dio/dio.dart';
import 'package:week4/features/dosen/data/models/dosen_model.dart';
import 'package:week4/core/network/dio_client.dart';

class DosenRepositories {
  final DioClient _dioClient;

  DosenRepositories({DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient();

  // get data daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    try {
      final Response response = await _dioClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal memuat data dosen: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}