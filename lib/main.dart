import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:jobscope/app_styles/app_styles.dart';
import 'package:jobscope/provider/button_state_provider.dart';
import 'package:jobscope/provider/self_applied_companies_provider.dart';
import 'package:jobscope/screens/home_screen/home_screen.dart';
import 'package:jobscope/services/googe_sheet.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheet.initialiseGoogleSheet(); 
  doWhenWindowReady((){
    var initialFrameSize = const Size(800, 500);
    appWindow.size = initialFrameSize;
    appWindow.minSize = initialFrameSize;
    appWindow.title = 'JobScope';
    appWindow.show();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SelfAppliedCompaniesProvider()),
        ChangeNotifierProvider(create: (context)=>ButtonsStateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.greyColor,
            selectionColor: AppColors.greyColor,
            selectionHandleColor: AppColors.greyColor
          ),
          scaffoldBackgroundColor: AppColors.primaryColor,
          primaryColor: const Color(0xFFF6F4EB),
          fontFamily: GoogleFonts.redHatDisplay().fontFamily
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
