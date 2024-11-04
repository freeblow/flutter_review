import 'package:flutter/material.dart';

class TMAlertDialog{

  static void showCustomAlertDialog(BuildContext context, {
      double? width,
      BoxDecoration? contentDecoration,
      EdgeInsets? contentPadding,
      String? title,
      TextStyle? titleStyle,
      Widget? contentW,
      String? content,
      TextStyle? contentStyle,
      double titleAndContentPadding = 0,
      double contentAndBtnPadding = 0,
      Widget? btn,
      ButtonStyle? btnStyle
    }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Remove default padding for clean image edges
          backgroundColor: Colors.transparent, // Make the background transparent
          content: Container(
            width: width??double.maxFinite, // Allows the image to stretch
            decoration:contentDecoration?? BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: contentPadding ?? EdgeInsets.zero, // Add padding if needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(title != null && title.isNotEmpty)
                  Text(
                    title,
                    style: titleStyle??TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: titleAndContentPadding),
                  contentW??Text(
                    content ?? "",
                    style: contentStyle ?? TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: contentAndBtnPadding),
                  btn??ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}