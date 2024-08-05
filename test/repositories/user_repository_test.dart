import 'package:api_test/features/search_user/data/models/user_model.dart';
import 'package:api_test/features/search_user/data/repositories/user_repository.dart';
import 'package:api_test/features/search_user/data/services/github_service.dart';
import 'package:api_test/features/search_user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Manually create a mock class for GitHubService
class MockGitHubService extends Mock implements GitHubService {}

void main() {
  group('UserRepository', () {
    late UserRepositoryImpl repository;
    late MockGitHubService mockService;

    setUp(() {
      mockService = MockGitHubService();
      repository = UserRepositoryImpl(mockService);
    });

    test('getUser returns a User if the call to GitHubService is successful', () async {
      final userModel = UserModel(
        login: 'octocat',
        avatarUrl: 'https://avatars.githubusercontent.com/u/583231?v=4',
        publicRepos: 10,
      );

      when(mockService.fetchUser('octocat')).thenAnswer((_) async => userModel);

      final user = await repository.getUser('octocat');

      expect(user, isA<User>());
      expect(user.login, 'octocat');
      expect(user.avatarUrl, 'https://avatars.githubusercontent.com/u/583231?v=4');
      expect(user.publicRepos, 10);
    });

    test('getUser throws an exception if the call to GitHubService fails', () {
      when(mockService.fetchUser('unknown')).thenThrow(Exception('Failed to fetch user'));

      expect(repository.getUser('unknown'), throwsException);
    });
  });
}
