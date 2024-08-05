import 'package:api_test/features/search_user/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/search_user/data/repositories/user_repository.dart';
import 'features/search_user/data/services/github_service.dart';
import 'features/search_user/domain/use_cases/get_user.dart';
import 'features/search_user/presentation/blocs/users/user_bloc.dart';
import 'features/search_user/presentation/pages/user_search_page.dart';
import 'package:http/http.dart' as http;

void main() {
  final gitHubService = GitHubService(client: http.Client());
  final userRepository = UserRepositoryImpl(gitHubService);
  final getUser = GetUser(userRepository);

  runApp(GitHubSearchApp(getUser: getUser));
}

class GitHubSearchApp extends StatelessWidget {
  final GetUser? getUser;
  const GitHubSearchApp({super.key,this.getUser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider<UserBloc>(
         create: (context) => UserBloc(getUser!),
       ),
     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prime Minds Task',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            accentColor: Colors.grey[800], // Accent color for certain UI elements
            backgroundColor: Colors.grey[900], // Background color
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
              headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
              bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
              bodyText2: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.grey[700],
              textTheme: ButtonTextTheme.primary,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey[400],
            ),
          ),
        home: UserSearchPage(),
      ),
    );
  }
}
