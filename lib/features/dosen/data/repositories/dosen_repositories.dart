import 'package:dio/dio.dart';
import 'package:week4/features/dosen/data/models/dosen_model.dart';

class DosenRepositories {
  final Dio _dio = Dio();

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      final List data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat data dosen: $e');
    }
  }
}