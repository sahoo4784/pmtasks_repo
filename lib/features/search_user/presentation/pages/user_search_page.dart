import 'package:api_test/features/search_user/domain/entities/user.dart';
import 'package:api_test/features/search_user/presentation/blocs/users/user_bloc.dart';
import 'package:api_test/features/search_user/presentation/blocs/users/user_event.dart';
import 'package:api_test/features/search_user/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/user_state.dart';

class UserSearchPage extends StatefulWidget {
  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo+'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (String value){
                context.read<UserBloc>().add(FetchUser(value));
              },
              decoration: InputDecoration(
                hintText: 'Enter GitHub username',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {

                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitial) {
                  return const Center(child: Text('Enter a username to search'));
                } else if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  return UserCard(user: state.user);
                } else if (state is UserError) {
                  return Center(child: Text(state.message));
                }  else if (state is NoInternet) {
                  return const Center(child: Text('No internet connection'));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}
