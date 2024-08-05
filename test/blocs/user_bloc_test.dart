import 'package:api_test/features/search_user/domain/entities/user.dart';
import 'package:api_test/features/search_user/domain/use_cases/get_user.dart';
import 'package:api_test/features/search_user/presentation/blocs/users/user_bloc.dart';
import 'package:api_test/features/search_user/presentation/blocs/users/user_event.dart';
import 'package:api_test/features/search_user/presentation/blocs/users/user_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetUser extends Mock implements GetUser {}

void main() {
  group('UserBloc', () {
    late MockGetUser mockGetUser;
    late UserBloc userBloc;

    setUp(() {
      mockGetUser = MockGetUser();
      userBloc = UserBloc(mockGetUser);
    });

    tearDown(() {
      userBloc.close();
    });

    final user = User(
      login: 'octocat',
      avatarUrl: 'https://avatars.githubusercontent.com/u/583231?v=4',
      publicRepos: 10,
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when FetchUser is added and getUser succeeds',
      build: () {
        when(mockGetUser(any as String)).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUser('octocat')),
      expect: () => [
        UserLoading(),
        UserLoaded(user),
      ],
      verify: (_) {
        verify(mockGetUser('octocat')).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when FetchUser is added and getUser fails',
      build: () {
        when(mockGetUser(any as String)).thenThrow(Exception('Failed to fetch user'));
        return userBloc;
      },
      act: (bloc) => bloc.add(FetchUser('unknown')),
      expect: () => [
        UserLoading(),
        UserError('Failed to fetch user'),
      ],
      verify: (_) {
        verify(mockGetUser('unknown')).called(1);
      },
    );
  });
}
