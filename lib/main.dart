import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/contact_provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/counter_provider.dart';
import 'package:rwa1_adv_flutter_5pm/controllers/providers/theme_provider.dart';
import 'package:rwa1_adv_flutter_5pm/utils/themes.dart';
import 'package:rwa1_adv_flutter_5pm/views/screens/add_contact_page.dart';
import 'package:rwa1_adv_flutter_5pm/views/screens/detail_page.dart';
import 'package:rwa1_adv_flutter_5pm/views/screens/hidden_contacts_page.dart';
import 'package:rwa1_adv_flutter_5pm/views/screens/home_page.dart';
import 'package:rwa1_adv_flutter_5pm/views/screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isIntroScreenVisited = prefs.getBool("isIntroScreenVisited") ?? false;

  runApp(
    MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context) => CounterProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => ContactProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MyAppTheme.lightTheme,
            darkTheme: MyAppTheme.darkTheme,
            themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: (isIntroScreenVisited) ? '/' : 'intro_screen',
            routes: {
              '/': (context) => HomePage(),
              'add_contact_page': (context) => AddContactPage(),
              'intro_screen': (context) => IntroScreen(),
              'detail_page': (context) => DetailPage(),
              'hidden_contacts_page': (context) => HiddenContactsPage(),
            },
          );
        }),
  );
}
