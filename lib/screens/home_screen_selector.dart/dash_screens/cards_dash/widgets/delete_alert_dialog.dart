import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:provider/provider.dart';

Future deleteAlertDialog(BuildContext context,int rowIndex) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: AppColors.primaryColor,
            title: const Text('Do you want to delete'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    context.read<SelfAppliedCompaniesProvider>().deleteRowFromSheet(rowIndex);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'YES',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ));
}
