import 'package:stripcard/backend/utils/custom_loading_api.dart';
import 'package:stripcard/controller/navbar/dashboard_controller.dart';
import 'package:stripcard/controller/navbar/withdraw/withdraw_controller.dart';
import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';
import '../../../utils/basic_screen_import.dart';
import '../../../widgets/appbar/appbar_widget.dart';

class MoneyOutPreviewScreen extends StatelessWidget {
  MoneyOutPreviewScreen({super.key});

  final controller = Get.put(MoneyOutController());
  final dashController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: Scaffold(
      appBar: AppBarWidget(text: Strings.preview),
      body: _bodyWidget(context),
    ));
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
    double amount = controller.moneyOutAmountTextController.text.isEmpty
        ? 0.0
        : double.parse(controller.moneyOutAmountTextController.text);

    var conversionAmount = amount * 1;

    var percentageCharge =
        (1 / 100) * conversionAmount; // Calculate 1% of the converted amount

    var feesAndChargeResult =
        percentageCharge + controller.fixesCharge.value; // Add fixed charge

    double percentCharge = (amount / 100) * 1.toDouble();

    double totalCharge = feesAndChargeResult + percentCharge * 1;
    var totalPayableAmount =
        conversionAmount + feesAndChargeResult; // Final payable amount

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
                          '${amount.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency}',
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
                          " 1 ${controller.baseCurrency.value} = ${1.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency.value}",
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
                          '${feesAndChargeResult.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency.value}',
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
                      text: Strings.conversionAmount,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${amount.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency}',
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
                          '${amount.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency}',
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
                          '${totalPayableAmount.toStringAsFixed(dashController.precision.value)}${controller.baseCurrency.value}',
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
    return previewAmount(
      amount:
          '${controller.moneyOutAmountTextController.text} ${controller.baseCurrency.value}',
    );
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
                  controller.confirmProcess(context);
                }),
      ),
    );
  }
}
