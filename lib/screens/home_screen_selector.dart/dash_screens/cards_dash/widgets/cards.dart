import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';

Widget cards() {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date: 00/00/0000',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            Text(
              'Connected Date: 00/00/0000',
              style: TextStyle(color: AppColors.primaryColor),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Name',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text('Email: example@gmail.com',
                style: TextStyle(color: AppColors.primaryColor)),
          ],
        ),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Person: Example person',
                style: TextStyle(color: AppColors.primaryColor)),
            Row(
              children: [
                Text('Contact Number: 0000000000',
                    style: TextStyle(color: AppColors.primaryColor)),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.mic,
                  color: AppColors.dangerColor,
                  size: 15,
                )
              ],
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No response after application',
                style: TextStyle(color: AppColors.primaryColor)),
          ],
        )
      ],
    ),
  );
}
