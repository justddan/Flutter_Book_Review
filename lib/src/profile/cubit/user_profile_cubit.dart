import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/common/model/user_model.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository _userRepository;
  final String uid;
  UserProfileCubit(this._userRepository, this.uid)
      : super(const UserProfileState()) {
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    emit(state.copyWith(status: CommonStateStatus.loading));
    var userInfo = await _userRepository.findUserOne(uid);
    if (userInfo == null) {
      emit(state.copyWith(status: CommonStateStatus.error));
    } else {
      emit(
          state.copyWith(userInfo: userInfo, status: CommonStateStatus.loaded));
    }
  }

  void followToggleEvent(String myUid) async {
    if (state.userInfo!.followers != null &&
        state.userInfo!.followers!.contains(myUid)) {
      var result =
          await _userRepository.followEvent(false, state.userInfo!.uid!, myUid);
      if (result) {
        _unfollow(myUid);
      }
    } else {
      var result =
          await _userRepository.followEvent(true, state.userInfo!.uid!, myUid);
      if (result) {
        _follow(myUid);
      }
    }
  }

  _follow(uid) {
    if (state.userInfo!.followers == null) {
      emit(
        state.copyWith(
          userInfo: state.userInfo!.copyWith(
            followers: List.unmodifiable([uid]),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          userInfo: state.userInfo!.copyWith(
            followers: List.unmodifiable([...state.userInfo!.followers!, uid]),
          ),
        ),
      );
    }
  }

  _unfollow(uid) {
    emit(
      state.copyWith(
        userInfo: state.userInfo!.copyWith(
          followers: List.unmodifiable(
            [...state.userInfo!.followers!.where((tUid) => tUid != uid)],
          ),
        ),
      ),
    );
  }
}

class UserProfileState extends Equatable {
  final CommonStateStatus status;
  final UserModel? userInfo;

  const UserProfileState({
    this.userInfo,
    this.status = CommonStateStatus.init,
  });

  UserProfileState copyWith({
    UserModel? userInfo,
    CommonStateStatus? status,
  }) {
    return UserProfileState(
      userInfo: userInfo ?? this.userInfo,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [];
}
