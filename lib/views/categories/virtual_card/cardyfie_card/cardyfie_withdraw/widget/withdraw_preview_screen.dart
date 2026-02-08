import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';

import '../../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_info_controller.dart';
import '../../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_withdraw_controller.dart';
import '../../../../../../utils/basic_screen_import.dart';
import '../../../../../../widgets/appbar/appbar_widget.dart';

class CardyfieWithdrawPreviewScreen extends StatelessWidget {
  CardyfieWithdrawPreviewScreen({super.key});
  final controller = Get.put(CardyfieWithdrawFundController());
  final walletController = Get.put(VirtualCardyfieCardController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.preview),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        _previewCalculation(context),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(
      amount:
          "${double.tryParse(controller.amountTextController.text)} ${walletController.baseCurrency}",
    );
  }

  _previewCalculation(BuildContext context) {
    double totalAmount = 0.0;
    double amount =
        double.tryParse(controller.amountTextController.text) ?? 0.0;
    totalAmount = amount - (walletController.totalCharges.value);
    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.4),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSize * 0.7,
              bottom: Dimensions.paddingSize * 0.3,
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
            ),
            child: TitleHeading3Widget(
              text: Strings.amountInformation,
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            thickness: 1,
            color: CustomColor.primaryLightScaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSize * 0.3,
              bottom: Dimensions.paddingSize * 0.6,
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: Strings.totalCharge,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${walletController.totalCharges.value.toStringAsFixed(2)} ${walletController.baseCurrency}',
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.marginSizeVertical * 0.2),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: Strings.totalPay,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalAmount.toStringAsFixed(2)} ${walletController.baseCurrency}',
                      textAlign: TextAlign.left,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.marginSizeVertical * 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 2),
      child: Obx(
        () => controller.isLoading
            ? CustomLoadingAPI(color: CustomColor.primaryLightColor)
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  controller.cardWithdrawProcess(context);
                },
              ),
      ),
    );
  }
}
