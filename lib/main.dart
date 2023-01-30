import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/presentation/cubit/asset/asset_cubit.dart';
import 'package:price_tracker/features/presentation/cubit/market/market_cubit.dart';

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

  final socketClient = SocketClient();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarketCubit>(
          create: (context) => MarketCubit(socketClient)..connect(),
        ),
        BlocProvider<AssetCubit>(
          create: (context) => AssetCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Price Tracker',
        locale: Get.deviceLocale,
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.pages(),
      ),
    );
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Price Tracker',
    //   locale: Get.deviceLocale,
    //   initialRoute: AppRoutes.initial,
    //   getPages: AppRoutes.pages(),
    // );
  }
}
