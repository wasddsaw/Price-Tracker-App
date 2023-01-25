import 'package:get/get.dart';
import 'package:price_tracker/features/presentation/screens/main/home/home_screen.dart';

class AppRoutes {
  static const initial = HomeScreen.routeName;

  static List<GetPage> pages() {
    return [
      GetPage(
        name: HomeScreen.routeName,
        page: () =>  HomeScreen(),
      ),
    ];
  }
}
