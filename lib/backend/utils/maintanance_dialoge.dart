import 'package:restart_app/restart_app.dart';

import '../../utils/basic_screen_import.dart';
import '../model/maintainance/maintanance_model.dart';

class SystemMaintenanceController extends GetxController {
  RxBool maintenanceStatus = false.obs;
}

class MaintenanceDialog {
  show({required MaintenanceModel maintenanceModel}) {
    Get.dialog(
      // ignore: deprecated_member_use
      WillPopScope(
        onWillPop: () async {
          Restart.restartApp();
          return false;
        },
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Get.isDarkMode
                ? CustomColor.primaryDarkTextColor.withValues(alpha:0.2)
                : CustomColor.primaryTextColor.withValues(alpha:0.2),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontalSize * 0.8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeVerticalSize * 0.5,
                  ),
                  child: Image.network(
                    "${maintenanceModel.data.baseUrl}/${maintenanceModel.data.imagePath}/${maintenanceModel.data.image}",
                  ),
                ),
                TitleHeading3Widget(
                  text: maintenanceModel.data.title,
                  textAlign: TextAlign.center,
                  color: CustomColor.secondaryLightColor,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeVerticalSize * 0.5,
                  ),
                  child: TitleHeading4Widget(
                    text: maintenanceModel.data.details,
                    textAlign: TextAlign.center,
                    color: CustomColor.secondaryLightColor.withValues(alpha:0.6),
                  ),
                ),
                PrimaryButton(
                  title: Strings.restart,
                  onPressed: () {
                    Restart.restartApp();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
