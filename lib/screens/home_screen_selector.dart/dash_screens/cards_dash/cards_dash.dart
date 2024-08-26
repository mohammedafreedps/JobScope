import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/cards_dash/widgets/cards.dart';
import 'package:provider/provider.dart';

class CardsDash extends StatelessWidget {
  const CardsDash({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    // ignore: unused_local_variable
    double maxCrossAxisExtent;

    if (screenWidth < 600) {
      crossAxisCount = 1;
      maxCrossAxisExtent = screenWidth;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      crossAxisCount = 2;
      maxCrossAxisExtent = screenWidth / 2;
    } else if (screenWidth >= 1200 && screenWidth < 1500) {
      crossAxisCount = 3;
      maxCrossAxisExtent = screenWidth / 3;
    } else {
      crossAxisCount = 4;
      maxCrossAxisExtent = screenWidth / 4;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              onChanged: (value) => context
                  .read<SelfAppliedCompaniesProvider>()
                  .searchByTitle(value),
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.secondaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor)),
                  disabledBorder: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: context
                  .watch<SelfAppliedCompaniesProvider>()
                  .selfAppliedCompaniesList
                  .length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2.5,
              ),
              itemBuilder: (context, index) {
                return cards(
                  index: index,
                  context: context,
                  companyName: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .companyName,
                  date: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .date,
                  status: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .currentStatus,
                  email: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .emailId,
                  connectedDate: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .companyConnectedDate,
                  contactedPerson: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .contactPersonName,
                  contactNumber: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .contactPersonNumber,
                  isRecorded: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .callRecording
                      .isNotEmpty,
                  showRemark: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .showRemark,
                  remarks: context
                      .watch<SelfAppliedCompaniesProvider>()
                      .selfAppliedCompaniesList[index]
                      .remarks,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
