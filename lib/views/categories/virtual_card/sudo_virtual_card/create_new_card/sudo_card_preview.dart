import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';
import 'package:stripcard/widgets/others/preview/information_amount_widget.dart';

import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/categories/virtual_card/sudo_card/create_card/sudo_create_card_controller.dart';
import '../../../../../utils/basic_screen_import.dart';
import '../../../../../widgets/appbar/appbar_widget.dart';

class SudoCreateNewCardPreviewScreen extends StatelessWidget {
  SudoCreateNewCardPreviewScreen({super.key});

  final controller = Get.put(SudoCreateCardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: Scaffold(
      appBar: AppBarWidget(text: Strings.preview),
      body: Obx(
        () => controller.isLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryDarkColor,
              )
            : _bodyWidget(context),
      ),
    ));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        AmountPreviewInfoWidget(),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(
        amount:
            "${controller.amountTextController.text} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}");
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 1.5,
      ),
      child: Obx(
        () => controller.isLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryDarkColor,
              )
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  if (controller.sudoCardController.isExtraField == true) {
                    controller.firstCreateCardProcess(context);
                  } else {
                    controller.CrateCardProcess(context);
                  }
                },
              ),
      ),
    );
  }
}
