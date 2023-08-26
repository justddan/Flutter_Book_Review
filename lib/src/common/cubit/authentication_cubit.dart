import 'package:bookreview/src/common/model/user_model.dart';
import 'package:bookreview/src/common/repository/authentication_repository.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>
    with ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  AuthenticationCubit(this._authenticationRepository, this._userRepository)
      : super(const AuthenticationState());

  void init() {
    _authenticationRepository.user.listen((user) {
      _userStateChangedEvent(user);
    });
  }

  void _userStateChangedEvent(UserModel? user) async {
    if (user == null) {
      emit(state.copywith(status: AuthenticationStatus.unknown));
    } else {
      var result = await _userRepository.findUserOne(user.uid!);
      if (result == null) {
        emit(state.copywith(
            user: user, status: AuthenticationStatus.unauthenticated));
      } else {
        emit(state.copywith(
          user: result,
          status: AuthenticationStatus.authentication,
        ));
      }
    }

    notifyListeners();
  }

  void reloadAuth() {
    _userStateChangedEvent(state.user);
  }

  void googleLogin() async {
    await _authenticationRepository.signInWithGoogle();
  }

  void appleLogin() async {
    await _authenticationRepository.signInWithApple();
  }

  void logout() async {
    _authenticationRepository.logout();
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);
    print(change);
  }
}

enum AuthenticationStatus {
  authentication,
  unauthenticated,
  unknown,
  init,
  error,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user;
  const AuthenticationState({
    this.status = AuthenticationStatus.init,
    this.user,
  });

  AuthenticationState copywith({
    AuthenticationStatus? status,
    UserModel? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
