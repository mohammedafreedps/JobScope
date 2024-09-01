import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/constants/graph_dash_values.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:provider/provider.dart';

Future addBottomSheet(
  BuildContext context, {
  bool isToEdit = false,
  int? index,
}) {
  if (isToEdit && index != null) {
    context
        .read<SelfAppliedCompaniesProvider>()
        .updateRowFromSheet(index, true);
  }
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return _bottomSheetContent(context, isToEdit, index);
      });
}

Widget _bottomSheetContent(BuildContext context, bool isToEdit, int? index) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.8,
    decoration: BoxDecoration(color: AppColors.primaryColor),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_drop_down_rounded))
            ],
          ),
          const Text(
            'Fill Companies Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          _addSectionButton(context, 'Set Current Date'),
          const SizedBox(
            height: 20,
          ),
          _addSectionButton(context, 'Set Company Contacted Date'),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 100,
              child: _textField(
                  'Company Name',
                  context
                      .read<SelfAppliedCompaniesProvider>()
                      .companyNameController)),
          SizedBox(
              height: 100,
              child: _textField(
                  'Email ID',
                  context
                      .read<SelfAppliedCompaniesProvider>()
                      .emailIdController)),
          SizedBox(
              height: 100,
              child: _textField(
                  'Contacted Person Name',
                  context
                      .read<SelfAppliedCompaniesProvider>()
                      .contactedPersonNameController)),
          SizedBox(
              height: 100,
              child: _textField(
                  'Contacted Person Number',
                  context
                      .read<SelfAppliedCompaniesProvider>()
                      .contactedPersonNumberController)),
          SizedBox(
              height: 100,
              child: _textField(
                  'Call Recording (link)',
                  context
                      .read<SelfAppliedCompaniesProvider>()
                      .callRecordingLinkController)),
          _textField('Remarks',
              context.read<SelfAppliedCompaniesProvider>().remarksController,
              maxLines: null),
          const SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: 'Current Status',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
                disabledBorder: InputBorder.none,
              ),
              dropdownColor: AppColors.primaryColor,
              items: _dropDownMenuItems(),
              onChanged: (value) {
                context
                    .read<SelfAppliedCompaniesProvider>()
                    .setCurrentStatus(value);
              }),
          const SizedBox(
            height: 50,
          ),
          _addSectionButton(context, 'Save',
              isSaveButton: true, isToEdit: isToEdit, index: index)
        ],
      ),
    ),
  );
}

Widget _textField(String text, TextEditingController controller,
    {int? maxLines = 1}) {
  return TextField(
    controller: controller,
    cursorColor: AppColors.secondaryColor,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: text,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryColor),
      ),
      disabledBorder: InputBorder.none,
    ),
  );
}

List<DropdownMenuItem<String>> _dropDownMenuItems() {
  return status.map((String element) {
    return DropdownMenuItem<String>(
      value: element,
      child: Text(element),
    );
  }).toList();
}

Widget _addSectionButton(
  BuildContext context,
  String label, {
  bool isSaveButton = false,
  bool isToEdit = false,
  int? index,
}) {
  return InkWell(
    onTap: () {
      if (isSaveButton) {
        if (context
            .read<SelfAppliedCompaniesProvider>()
            .companyNameController
            .text
            .isNotEmpty) {
          if (isToEdit) {
            if (index != null) {
              context
                  .read<SelfAppliedCompaniesProvider>()
                  .updateRowFromSheet(index, false);
            }
          } else {
            context.read<SelfAppliedCompaniesProvider>().appendRowToSheet();
          }
          context.read<SelfAppliedCompaniesProvider>().clearInputs();
          Navigator.of(context).pop();
          context
              .read<SelfAppliedCompaniesProvider>()
              .reloadDelaidWithoutLodingIndication();
        }
      } else {
        showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2090));
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        label,
        style: TextStyle(color: AppColors.primaryColor),
      )),
    ),
  );
}
