
import 'package:api_test/features/search_user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String login, required String avatarUrl, required int publicRepos})
      : super(login: login, avatarUrl: avatarUrl, publicRepos: publicRepos);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json['public_repos']);
    return UserModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      publicRepos: json['public_repos'],
    );
  }
}
