import 'package:api_test/features/search_user/data/services/github_service.dart';
import 'package:api_test/features/search_user/domain/entities/user.dart';
import 'package:api_test/features/search_user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final GitHubService service;

  UserRepositoryImpl(this.service);

  @override
  Future<User> getUser(String username) async {
    return await service.fetchUser(username);
  }
}
