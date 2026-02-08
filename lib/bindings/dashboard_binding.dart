import 'package:get/get.dart';
import 'package:stripcard/controller/navbar/dashboard_controller.dart';

import '../controller/profile/update_profile_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashBoardController());
    Get.put(UpdateProfileController());
  }
}
