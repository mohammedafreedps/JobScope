import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/constants/graph_dash_values.dart';
import 'package:jobscope/screens/home_screen_selector.dart/dash_screens/graphs_dash/widgets/chart_side_label.dart';

List<Widget> createChartSideLable(){
  return List.generate(status.length, (i){
    return chartSideLabel(title: status[i],color: StatusColors.statusColors[i]);
  });
}