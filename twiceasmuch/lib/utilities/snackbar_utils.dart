import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void snackbarError({
  required String title,
  String subTitle = "",
  required BuildContext context,
}) =>
    _snackbar(
      title: title,
      subTitle: subTitle,
      color: const Color(0xffD50525),
      darkColor: const Color(0xff880216),
      context: context,
    );

// ignore: non_constant_identifier_names
void snackbarSuccessful({
  required String title,
  String subTitle = "",
  required BuildContext context,
}) =>
    _snackbar(
      title: title,
      subTitle: subTitle,
      color: const Color(0xff13B674),
      darkColor: const Color(0xff0D7E51),
      context: context,
    );

// ignore: non_constant_identifier_names
void snackbarWarning({
  required String title,
  String subTitle = "",
  required BuildContext context,
}) =>
    _snackbar(
      title: title,
      subTitle: subTitle,
      color: const Color(0xffFFB727),
      darkColor: const Color(0xffB17804),
      context: context,
    );

// ignore: non_constant_identifier_names
void snackbarInfo({
  required String title,
  String subTitle = "",
  required BuildContext context,
}) =>
    _snackbar(
      title: title,
      subTitle: subTitle,
      color: const Color(0xff5B42FF),
      darkColor: const Color(0xff412EB8),
      context: context,
    );

// ignore: non_constant_identifier_names
void _snackbar({
  required String title,
  String subTitle = "",
  required Color color,
  required Color darkColor,
  required BuildContext context,
}) {
  final snackbar = SnackBar(
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 5,
            height: subTitle.isEmpty ? 35 : 40,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: subTitle.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
                if (subTitle.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
    padding: EdgeInsets.zero,
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: darkColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    action: SnackBarAction(
      label: 'Got it!',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      textColor: Colors.white,
    ),
    dismissDirection: DismissDirection.down,
    // animation: Animation,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
