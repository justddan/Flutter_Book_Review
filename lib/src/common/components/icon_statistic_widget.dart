import 'package:bookreview/src/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconStatisticWidget extends StatelessWidget {
  final String iconPath;
  final int value;
  const IconStatisticWidget({
    super.key,
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(iconPath),
      const SizedBox(
        width: 6,
      ),
      AppFont(
        value.toString(),
        size: 13,
        color: const Color(0xff5f5f5f),
      ),
    ]);
  }
}
