import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:flutter/material.dart';

class BookReviewHeaderWidget extends StatelessWidget {
  final NaverBookInfo naverBookInfo;
  final Widget reviewCountDisplayWidget;
  const BookReviewHeaderWidget({
    super.key,
    required this.naverBookInfo,
    required this.reviewCountDisplayWidget,
  });

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
                naverBookInfo.image ?? "",
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
                  naverBookInfo.title ?? "",
                  size: 16,
                  fontWeight: FontWeight.bold,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppFont(
                  naverBookInfo.author ?? "",
                  size: 12,
                  color: const Color(0xff878787),
                ),
                const SizedBox(
                  height: 10,
                ),
                reviewCountDisplayWidget,
              ],
            ),
          )
        ],
      ),
    );
  }
}
