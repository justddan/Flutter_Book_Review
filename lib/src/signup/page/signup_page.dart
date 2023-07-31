import 'dart:io';

import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/svg/icons/icon_close.svg"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _UserProfileImageField(),
            const SizedBox(height: 50),
            const _NicknameField(),
            const SizedBox(height: 30),
            const _DescriptionField(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            Expanded(
              child: Btn(
                onTap: () {},
                text: "가입",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Btn(
                onTap: () {},
                backgroundColor: const Color(0xFF212121),
                text: "취소",
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UserProfileImageField extends StatelessWidget {
  _UserProfileImageField();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var profileFile =
        context.select<SignupCubit, File?>((cubit) => cubit.state.profileFile);
    return Center(
      child: GestureDetector(
        onTap: () async {
          var image = await _picker.pickImage(source: ImageSource.gallery);
          context.read<SignupCubit>().changeProfileImage(image);
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage: profileFile == null
              ? Image.asset("assets/images/default_avatar.png").image
              : Image.file(profileFile).image,
        ),
      ),
    );
  }
}

class _NicknameField extends StatelessWidget {
  const _NicknameField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppFont(
          "닉네임",
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF232323),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppFont(
          "한줄 소개",
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          maxLength: 50,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF232323),
            counterStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
