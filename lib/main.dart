import 'package:contact_diary_app/provider/add_data_provider.dart';
import 'package:contact_diary_app/screen/home_page.dart';
import 'package:contact_diary_app/screen/view_contact_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddDataProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          'viewContact': (context) => const ViewContactInfo(),
        },
      ),
    );
  }
}
