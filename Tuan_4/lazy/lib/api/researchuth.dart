import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchUTH() async {
  final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/tasks')); // Cập nhật đúng API của bạn

  if (response.statusCode == 200) {
    final data = json.decode(response.body); // Giải mã JSON

    // Kiểm tra dữ liệu hợp lệ
    if (data is Map<String, dynamic> && data.containsKey('data')) {
      if (data['data'] is List) {
        return data['data']; // Trả về danh sách từ "data"
      } else {
        throw Exception('Dữ liệu "data" không phải là danh sách');
      }
    } else {
      throw Exception('API trả về dữ liệu không hợp lệ');
    }
  } else {
    throw Exception('Lỗi khi gọi API: ${response.statusCode}');
  }
}
