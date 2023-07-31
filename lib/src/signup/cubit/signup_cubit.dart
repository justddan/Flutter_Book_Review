import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());

  changeProfileImage(XFile? image) {
    if (image == null) return;
    var file = File(image.path);
    emit(state.copyWith(profileFile: file));
  }
}

class SignupState extends Equatable {
  final File? profileFile;

  const SignupState({
    this.profileFile,
  });

  SignupState copyWith({File? profileFile}) {
    return SignupState(profileFile: profileFile ?? this.profileFile);
  }

  @override
  List<Object?> get props => [profileFile];
}
