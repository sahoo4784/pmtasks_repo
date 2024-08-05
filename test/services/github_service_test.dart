import 'package:api_test/features/search_user/data/models/user_model.dart';
import 'package:api_test/features/search_user/data/services/github_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('GitHubService', () {
    test('fetchUser returns a UserModel if the http call completes successfully', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '{"login": "octocat", "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4", "public_repos": 10}',
          200,
        );
      });

      final service = GitHubService(client: mockClient);
      final user = await service.fetchUser('octocat');

      expect(user, isA<UserModel>());
      expect(user.login, 'octocat');
      expect(user.avatarUrl, 'https://avatars.githubusercontent.com/u/583231?v=4');
      expect(user.publicRepos, 10);
    });

    test('fetchUser throws an exception if the http call completes with an error', () {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final service = GitHubService(client: mockClient);

      expect(service.fetchUser('unknown'), throwsException);
    });
  });
}
