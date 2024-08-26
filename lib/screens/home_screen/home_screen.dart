import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/home_screen_selector.dart';
import 'package:jobscope/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
void initState() {
  super.initState();
  context.read<SelfAppliedCompaniesProvider>().fechDataFromSheet();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WindowBorder(
      color: AppColors.secondaryColor,
      child: Column(
        children: [
          topBar(context),
          context.watch<SelfAppliedCompaniesProvider>().isCardDataLoading
              ? const Text('Loading....')
              : homeScreenSelector(context)
        ],
      ),
    ));
  }
}
