import 'package:api_test/features/search_user/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  User? user;
  UserCard({Key? key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.network(user!.avatarUrl),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user!.login),
              Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Text('Repositories: ${user!.publicRepos}',style: const TextStyle(color: Colors.white,fontSize: 12))))
            ],
          ),
        ),
      ),
    );
  }
}
