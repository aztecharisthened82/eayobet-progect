import 'package:stripcard/backend/utils/custom_loading_api.dart';
import 'package:stripcard/widgets/appbar/appbar_widget.dart';
import 'package:stripcard/utils/basic_screen_import.dart';
import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';

import '../../controller/navbar/money_transfer/money_transfer_controller.dart';
import '../../controller/navbar/money_transfer/money_transfer_info_controller.dart';

class MoneyTransferPreviewScreen extends StatelessWidget {
  MoneyTransferPreviewScreen({super.key});

  final controller = Get.put(MoneyTransferController());
  final infoController = Get.put(MoneyTransferInfoController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.preview),
        body: Obx(
          () => infoController.isLoading
              ? CustomLoadingAPI(
                  color: CustomColor.primaryLightColor,
                )
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        _previewWidget(),
        _buttonWidget(context),
      ],
    );
  }

  _previewWidget() {
    var data = infoController.transferMoneyInfoModel.data;
    var _fixedCharge = data.transferMoneyCharge.fixedCharge * data.baseCurrRate;
    double amount = controller.amount.value;

    double percentCharge =
        (amount / 100) * data.transferMoneyCharge.percentCharge;

    double totalCharge = _fixedCharge + percentCharge;
    double totalPayable = amount + totalCharge;
    int precision =
        controller.remainingController.dashboardController.precision.value;

    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.4),
      decoration: BoxDecoration(
          color: CustomColor.primaryLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
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
              color: Get.isDarkMode
                  ? CustomColor.whiteColor
                  : CustomColor.primaryLightTextColor,
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
                      text: Strings.enterAmount,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${amount.toStringAsFixed(precision)} ${data.baseCurr}',
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
                      text: Strings.exchangeRate,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '1 ${data.baseCurr} = ${data.baseCurrRate.toStringAsFixed(precision)} ${data.baseCurr}',
                      textAlign: TextAlign.left,
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
                      text: Strings.feesAndCharges,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalCharge.toStringAsFixed(precision)} ${data.baseCurr}',
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
                      text: Strings.recipientReceived,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${amount.toStringAsFixed(precision)} ${data.baseCurr}',
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
                      text: Strings.totalPayable,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalPayable.toStringAsFixed(precision)} ${data.baseCurr}',
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _amountWidget(BuildContext context) {
    var data = infoController.transferMoneyInfoModel.data;

    return previewAmount(
        amount:
            "${controller.amount.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${data.baseCurr}");
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => controller.isConfirmLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryLightColor,
              )
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  controller.transferMoneyConfirmProcess(context);
                }),
      ),
    );
  }
}
