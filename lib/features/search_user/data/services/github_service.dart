import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class GitHubService {
  final http.Client client;

  GitHubService({required this.client});

  Future<UserModel> fetchUser(String username) async {
    if (username != "") {
      try {
        final response = await client
            .get(Uri.parse('https://api.github.com/users/$username'));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return UserModel.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load user');
        }
      } catch (e) {
        throw Exception('Server issue');
      }
    } else {
      throw 'Please enter username to search';
    }
  }
}
