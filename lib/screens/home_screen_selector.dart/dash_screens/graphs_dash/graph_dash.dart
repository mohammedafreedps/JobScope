import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/utils/create_chart_side_lable.dart';
import 'package:provider/provider.dart';

class GraphDash extends StatefulWidget {
  const GraphDash({super.key});

  @override
  State<GraphDash> createState() => _GraphDashState();
}

class _GraphDashState extends State<GraphDash> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      context.read<SelfAppliedCompaniesProvider>().setUpGrandGraphData();
    });
    super.initState();
  }
  @override
  void dispose() {
    if(_timer != null){
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Text(
                'Today',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          context.watch<SelfAppliedCompaniesProvider>().doHaveTodayData
              ? Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: PieChart(PieChartData(
                          sections: todayShowingSections(context))),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: createChartSideLable()),
                    )
                  ],
                )
              : const Center(child: Text('No datas')),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Grand',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          context.watch<SelfAppliedCompaniesProvider>().doHaveGrandData
              ? Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: PieChart(PieChartData(
                          sections: grandShowingSections(context))),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: createChartSideLable()),
                    ),
                  ],
                )
              : const Center(child: Text('No datas')),
           const Divider(),
              
           const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> grandShowingSections(BuildContext context) {
  return List.generate(
      context.watch<SelfAppliedCompaniesProvider>().pieChartPercentage.length,
      (i) {
    return PieChartSectionData(
        borderSide: BorderSide(width: 2, color: AppColors.greyColor),
        color: StatusColors.statusColors[i],
        value: context
            .watch<SelfAppliedCompaniesProvider>()
            .pieChartPercentage[i], 
        title: context
                    .watch<SelfAppliedCompaniesProvider>()
                    .pieChartPercentage[i] >
                1
            ? ' ${context.watch<SelfAppliedCompaniesProvider>().pieChartPercentage[i].round().toString()} %'
            : '', 
        radius: 150,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ));
  });
}

List<PieChartSectionData> todayShowingSections(BuildContext context) {
  return List.generate(
      context
          .watch<SelfAppliedCompaniesProvider>()
          .todayPieChartPercentage
          .length, (i) {
    return PieChartSectionData(
        borderSide: BorderSide(width: 2, color: AppColors.greyColor),
        color: StatusColors.statusColors[i],
        value: context
            .watch<SelfAppliedCompaniesProvider>()
            .todayPieChartPercentage[i], // Value for the section
        title: context
                    .watch<SelfAppliedCompaniesProvider>()
                    .todayPieChartPercentage[i] >
                1
            ? ' ${context.watch<SelfAppliedCompaniesProvider>().todayPieChartPercentage[i].round().toString()} %'
            : '', // Title for the section
        radius: 150,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ));
  });
}
