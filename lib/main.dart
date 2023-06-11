import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marvel/routes/app_pages.dart';
import 'package:marvel/translations/my_localization.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marvellous app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
      initialRoute: AppPages.pages.first.name,
      translations: MyLocalization(),
      locale: Locale(GetStorage().read("Locale") ?? 'en', 'JO'),
    );
  }
}
