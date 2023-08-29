// ignore_for_file: deprecated_member_use, unused_import

import 'dart:io';
import 'dart:math';
import 'package:infocom_task/constants/colorConstant.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalFunction {
  static createAlert(BuildContext context, error, errormsg) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(error),
            content: Text(errormsg),
          );
        });
  }

  static willpopAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tlightGray,
          title: const Text(
            'Are you sure you want to exit?',
            style: TextStyle(color: tWhite),
          ),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: const <Widget>[
          //       Text('This is a demo alert dialog.'),
          //       Text('Would you like to approve of this message?'),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateBack(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                        // gradient: tPrimaryGradientColor,
                        border: Border.all(width: 1, color: tPrimaryColor),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: tPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        // gradient: tPrimaryGradientColor,
                        border: Border.all(width: 1, color: tPrimaryColor),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      'Ok',
                      style: TextStyle(color: tPrimaryColor),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  static navigateTo(BuildContext context, page) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static navigateBack(BuildContext context) async {
    Navigator.pop(context);
  }

  static forceNavigateTo(BuildContext context, page) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static errorHandler(BuildContext context, errorRes) async {
    switch (errorRes) {
      case 301:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Moved Permanently'),
        ));
        break;
      case 302:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Found'),
        ));
        break;
      case 401:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Unauthorized'),
        ));
        break;
      case 403:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Forbidden'),
        ));

        break;
      case 404:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Not Found'),
        ));
        break;
      case 500:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Internal Server Error'),
        ));
        break;
      case 502:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Bad Gateway'),
        ));
        break;
      case 503:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Service Unavailable'),
        ));

        break;
      case 504:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gateway Timeout'),
        ));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops!...'),
        ));
    }
  }

// Date Formate
  static dateFormate(now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

// Date Formate
  static timeFormate(now) {
    final DateFormat formatter = DateFormat('HH:mm');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  // Day Formate
  static dayFormate(now) {
    final DateFormat formatter =
        DateFormat('EEEE, d MMM,').format(now) as DateFormat;

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  //time format
  static DatetimeFormate(now) {
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');
    final dateTime = inputFormat.parse(now);
    return outputFormat.format(dateTime);
  }
}
