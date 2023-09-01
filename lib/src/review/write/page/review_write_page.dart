import 'package:bookreview/src/common/components/app_divider.dart';
import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/book_review_header_widget.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/common/components/loading.dart';
import 'package:bookreview/src/common/components/review_slider_bar.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:bookreview/src/review/write/cubit/review_write_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReviewWrtiePage extends StatelessWidget {
  final NaverBookInfo naverBookInfo;
  const ReviewWrtiePage(this.naverBookInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: context.pop,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset("assets/svg/icons/icon_arrow_back.svg"),
              ),
            ),
            title: const AppFont(
              "리뷰 작성",
              size: 18,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              BookReviewHeaderWidget(
                naverBookInfo: naverBookInfo,
                reviewCountDisplayWidget:
                    BlocBuilder<ReviewWriteCubit, ReviewWriteState>(
                        builder: (context, state) {
                  return ReviewSliderBar(
                    initValue: state.reviewInfo?.value ?? 0,
                    onChange: context.read<ReviewWriteCubit>().changeValue,
                  );
                }),
              ),
              const AppDivider(),
              Expanded(
                child: BlocBuilder<ReviewWriteCubit, ReviewWriteState>(
                  buildWhen: (previous, current) =>
                      current.isEditMode != previous.isEditMode,
                  builder: (context, state) {
                    return _ReviewBox(
                      initReview: state.reviewInfo?.review,
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20 + MediaQuery.of(context).padding.bottom,
            ),
            child: Btn(
              onTap: context.read<ReviewWriteCubit>().save(),
              text: "저장",
            ),
          ),
        ),
        BlocConsumer<ReviewWriteCubit, ReviewWriteState>(
          listener: (context, state) async {
            if (state.status == CommonStateStatus.loaded &&
                state.message != null) {
              await showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    content: AppFont(
                      state.message ?? "",
                      size: 18,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: context.pop,
                        child: const AppFont(
                          "확인",
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              );
              context.pop<bool>(true);
            }
          },
          builder: (context, state) {
            if (state.status == CommonStateStatus.loading) {
              return const Loading();
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}

class _ReviewBox extends StatefulWidget {
  final String? initReview;
  const _ReviewBox({this.initReview});

  @override
  State<_ReviewBox> createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<_ReviewBox> {
  TextEditingController editingController = TextEditingController();

  @override
  void didUpdateWidget(covariant _ReviewBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    editingController.text = widget.initReview ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "리뷰를 입력해주세요.",
        hintStyle: TextStyle(
          color: Color(0xFF585858),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: context.read<ReviewWriteCubit>().changeReview,
    );
  }
}
