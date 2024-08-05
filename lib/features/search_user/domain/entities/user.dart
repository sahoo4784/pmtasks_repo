import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String login;
  final String avatarUrl;
  final int publicRepos;

  const User({required this.login, required this.avatarUrl, required this.publicRepos});

  @override
  List<Object?> get props => [login, avatarUrl, publicRepos];
}
