import 'package:bookreview/src/common/components/app_divider.dart';
import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/common/components/review_slider_bar.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReviewPage extends StatelessWidget {
  final NaverBookInfo naverBookInfo;
  const ReviewPage(this.naverBookInfo, {super.key});

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
          "리뷰 작성",
          size: 18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _HeaderBookInfo(naverBookInfo),
          const AppDivider(),
          const Expanded(child: _ReviewBox()),
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
          onTap: () {},
          text: "저장",
        ),
      ),
    );
  }
}

class _HeaderBookInfo extends StatelessWidget {
  final NaverBookInfo bookInfo;
  const _HeaderBookInfo(this.bookInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: SizedBox(
              width: 71,
              height: 106,
              child: Image.network(
                bookInfo.image ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppFont(
                  bookInfo.title ?? "",
                  size: 16,
                  fontWeight: FontWeight.bold,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppFont(
                  bookInfo.author ?? "",
                  size: 12,
                  color: const Color(0xff878787),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReviewSliderBar(
                  onChange: (double value) {
                    print(value);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ReviewBox extends StatelessWidget {
  const _ReviewBox();

  @override
  Widget build(BuildContext context) {
    return TextField(
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
      onChanged: (value) {},
    );
  }
}
