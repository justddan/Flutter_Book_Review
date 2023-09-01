import 'package:bookreview/src/common/components/app_divider.dart';
import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/book_review_header_widget.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:bookreview/src/common/util/data_util.dart';
import 'package:bookreview/src/review/detail/cubit/review_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReviewDetailPage extends StatelessWidget {
  final NaverBookInfo naverBookInfo;
  const ReviewDetailPage(this.naverBookInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: context.pop,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset("assets/svg/icons/icon_arrow_back.svg"),
          ),
        ),
        title: const AppFont(
          "리뷰",
          size: 18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BookReviewHeaderWidget(
            naverBookInfo: naverBookInfo,
            reviewCountDisplayWidget: Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/icons/icon_star.svg",
                  width: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
                    builder: (context, state) {
                  return AppFont(
                    (state.review?.value ?? 0).toStringAsFixed(2),
                    color: const Color(0xfff4aa2b),
                    size: 16,
                  );
                }),
              ],
            ),
          ),
          const AppDivider(),
          const Expanded(child: _ReviewInfoWidget()),
        ],
      ),
    );
  }
}

class _ReviewInfoWidget extends StatelessWidget {
  const _ReviewInfoWidget();

  Widget _profile(ReviewDetailState state) {
    if (state.review == null) return Container();
    return Row(
      children: [
        CircleAvatar(
          radius: 33,
          backgroundColor: Colors.grey,
          backgroundImage: state.userInfo?.profile == null
              ? Image.asset("assets/images/default_avatar.png").image
              : Image.network(state.userInfo!.profile!).image,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFont(
                state.userInfo?.name ?? "",
                size: 18,
                color: const Color(0xffc9c9c9),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFont(
                    "공감 ${state.review!.likedUsers?.length ?? 0}개",
                    size: 15,
                    color: const Color(0xffc9c9c9),
                    fontWeight: FontWeight.bold,
                  ),
                  AppFont(
                    AppDataUtil.dateFormat(
                        "yyyy.MM.dd", state.review!.createdAt!),
                    size: 12,
                    color: const Color(0xff878787),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
        builder: (context, state) {
          var myUid = context.read<AuthenticationCubit>().state.user!.uid!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _profile(state),
              const SizedBox(
                height: 30,
              ),
              AppFont(
                state.review?.review ?? "",
                size: 14,
                color: const Color(0xffa7a7a7),
              ),
              GestureDetector(
                onTap: () {
                  context.read<ReviewDetailCubit>().toggleLikedReview(myUid);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SvgPicture.asset(
                    "assets/svg/icons/icon_liked.svg",
                    width: 30,
                    colorFilter:
                        state.review?.likedUsers?.contains(myUid) ?? false
                            ? const ColorFilter.mode(
                                Color(0xfff4aa2b),
                                BlendMode.srcIn,
                              )
                            : const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
