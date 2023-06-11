import 'package:get/get.dart';
import '../views/home_view/bindings/home_bindings.dart';
import '../views/home_view/index.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBindings(),
    ),
  ];
}
