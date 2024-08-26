import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/services/exel_date_convertor.dart';
import 'package:provider/provider.dart';

Widget cards(
    {required BuildContext context,
    required int index,
    required String companyName,
    required String date,
    required String status,
    required String email,
    required String connectedDate,
    required String contactedPerson,
    required String contactNumber,
    required bool isRecorded,
    required String remarks,
    required bool showRemark}) {
  return showRemark
      ? Container(
          decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                remarks,
                style: TextStyle(color: AppColors.primaryColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<SelfAppliedCompaniesProvider>()
                            .setShowRemark(index);
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: AppColors.greyColor,
                      ))
                ],
              )
            ],
          ),
        )
      : Container(
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
                    'Date: ${exelDateConvertor(int.tryParse(date) ?? 1)}',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  Text(
                    'Connected Date: ${exelDateConvertor(int.tryParse(connectedDate) ?? 1)}',
                    style: TextStyle(color: AppColors.primaryColor),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(companyName,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Text('Email: $email',
                      style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Person: $contactedPerson',
                      style: TextStyle(color: AppColors.primaryColor)),
                  Row(
                    children: [
                      Text('Contact Number: $contactNumber',
                          style: TextStyle(color: AppColors.primaryColor)),
                      const SizedBox(
                        width: 10,
                      ),
                      isRecorded
                          ? Icon(
                              Icons.mic,
                              color: AppColors.dangerColor,
                              size: 15,
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(status, style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Remark',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<SelfAppliedCompaniesProvider>()
                            .setShowRemark(index);
                      },
                      icon: Icon(
                        Icons.arrow_outward_sharp,
                        color: AppColors.greyColor,
                      ))
                ],
              )
            ],
          ),
        );
}
