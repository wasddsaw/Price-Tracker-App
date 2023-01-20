import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

class App extends StatelessWidget with AppRoutes {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: const [],
    //   child: GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Price Tracker',
    //     locale: Get.deviceLocale,
    //     initialRoute: AppRoutes.initial,
    //     getPages: AppRoutes.pages(),
    //   ),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Tracker',
      locale: Get.deviceLocale,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages(),
    );
  }
}
