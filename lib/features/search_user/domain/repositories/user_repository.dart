import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUser(String username);
}
