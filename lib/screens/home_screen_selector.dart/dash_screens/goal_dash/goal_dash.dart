import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/goal_dash/widgets/goal_card.dart';
import 'package:provider/provider.dart';

class GoalDash extends StatefulWidget {
  const GoalDash({super.key});

  @override
  State<GoalDash> createState() => _GoalDashState();
}

class _GoalDashState extends State<GoalDash> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 1), () {
      context.read<SelfAppliedCompaniesProvider>().setGoalCount();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Daily Goal',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                goalCard(
                    'Applied Companies',
                    context
                        .watch<SelfAppliedCompaniesProvider>()
                        .todayAppliedCompany
                        .toString(),
                    '10',
                    context
                        .watch<SelfAppliedCompaniesProvider>()
                        .isGoalAchived),
                const SizedBox(
                  width: 50,
                ),
                goalCard(
                    'Total Calls',
                    context
                        .watch<SelfAppliedCompaniesProvider>()
                        .todayCalledCompany
                        .toString(),
                    '2',
                    context.watch<SelfAppliedCompaniesProvider>().isGoalAchived)
              ],
            )
          ],
        ),
      ),
    );
  }
}
