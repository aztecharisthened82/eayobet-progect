import '../../../backend/utils/custom_loading_api.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/text_labels/title_subtitle_widget.dart';
import '../../controller/two_fa/enable_two_controller.dart';
import '../../utils/basic_screen_import.dart';

class Enable2FaScreen extends StatelessWidget {
  Enable2FaScreen({super.key});

  final controller = Get.put(TwoFaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: "",
      ),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        _qrCodeWidget(context),
        _titleSubTitleWidget(context),
        _enableButtonWidget(context),
      ],
    ).paddingSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.8);
  }

  _enableButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isSubmitLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: controller.status.value == 0
                    ? Strings.enable
                    : Strings.disable,
                onPressed: () {
                  controller.twoFaSubmitApiProcess();
                },
              ),
      ),
    );
  }

  _titleSubTitleWidget(BuildContext context) {
    return TitleSubTitleWidget(
      title: Strings.enableFasecurity,
      subtitle: controller.alert.value,
      crossAxisAlignment: crossCenter,
    );
  }

  _qrCodeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        Dimensions.paddingSize,
      ),
      child: Image.network(
        controller.qrCode.value,
        scale: 1,
      ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.5),
    );
  }
}
