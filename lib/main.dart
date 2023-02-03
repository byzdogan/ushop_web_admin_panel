import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushop_admin_panel/consts/theme_data.dart';
import 'package:ushop_admin_panel/controllers/MenuController.dart';
import 'package:ushop_admin_panel/inner_screens/add_product.dart';
import 'package:ushop_admin_panel/providers/dark_theme_provider.dart';
import 'package:ushop_admin_panel/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}) ;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          }
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "USHOP",
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const MainScreen(),

          );
          },
    ),
    );
  }
}