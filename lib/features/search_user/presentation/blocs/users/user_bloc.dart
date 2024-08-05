// lib/presentation/blocs/user/user_bloc.dart

import 'dart:async';
import 'package:api_test/features/search_user/domain/use_cases/get_user.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc(this.getUser) : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    // Checking for internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(NoInternet());
      return;
    }
    try {
      final user = await getUser(event.username);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('$e'));
    }
  }
}
