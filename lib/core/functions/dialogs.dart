import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success, warning }

showMyDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: type == DialogType.error
          ? AppColors.redColor
          : type == DialogType.success
          ? AppColors.primaryColor
          : AppColors.cardColor,
      content: Text(
        message,
        style: TextStyles.styleSize16(color: AppColors.whiteColor),
      ),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.darkColor.withValues(alpha: .7),
    builder: (context) {
      return Center(
        child: Lottie.asset("assets/images/loading.json", width: 250),
      );
    },
  );
}

// showDialog(
//   context: context,
//   builder: (context) {
//     return SimpleDialog(
//       children: [
//         MainButton(
//           width: 300,
//           onPressed: () async {
//             await uploadImage(isCamera: true);
//           },
//           text: 'Upload From Camera',
//         ),
//         Gap(15),
//         MainButton(
//           width: 300,
//           onPressed: () async {
//             await uploadImage(isCamera: false);
//           },
//           text: 'Upload From Gallery',
//         ),
//       ],
//     );
//   },
// );
