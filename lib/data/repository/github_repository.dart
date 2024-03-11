import 'dart:convert';
import 'package:leadsoft_test_app/data/model/response.dart';
import 'package:http/http.dart' as http;

abstract class GitHubRepository{
  Future<Response> getRepositories(String str);
}

class GitHubRepositoryImpl implements GitHubRepository{
  final String baseUrl = 'https://api.github.com';
  @override
  Future<Response> getRepositories(String query) async {
    final url = Uri.parse('$baseUrl/search/repositories?q=$query&per_page=15');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // print(response.body);
      return Response.fromJson(jsonResponse);
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to search repositories');
    }
  }
}