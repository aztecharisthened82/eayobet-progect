import 'package:stripcard/backend/local_storage.dart';
import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/categories/virtual_card/stripe_card/stripe_two_controller.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/appbar/appbar_widget.dart';

class StripCardPreview extends StatelessWidget {
  StripCardPreview({super.key});

  final controller = Get.put(StripeTwoController());

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
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        previewInfo(),
        _buttonWidget(context),
      ],
    );
  }

  previewInfo() {
    var _cardCharge = controller.stripeCardModel.data.cardCharge;
    var baseCurrency = controller.stripeCardModel.data.baseCurr;

    // Get user input amount
    double amount = double.parse(controller.fundAmountController.text);

    // Get exchange rate
    double exchangeRate = controller.selectedSupportedCurrencyRate.value;

    double normalizedExchangeRate =
        (controller.selectedSupportedCurrency.value == baseCurrency)
            ? exchangeRate
            : (1 / exchangeRate);

    double roundToFourDecimals(double value) {
      return double.parse(value.toStringAsFixed(4));
    }

    // Convert amount to base currency
    double convertedAmount =
        roundToFourDecimals(amount * normalizedExchangeRate);

    // Calculate percentage charge (1% of converted amount)
    double percentCharge = roundToFourDecimals(
        (convertedAmount / 100) * _cardCharge.percentCharge);

    // Calculate total charge (fixed charge + percent charge)
    double totalCharge =
        roundToFourDecimals(_cardCharge.fixedCharge + percentCharge);

    // Calculate total payable amount
    double totalPayable = roundToFourDecimals(convertedAmount + totalCharge);

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
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.4),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${amount.toStringAsFixed(4)} ${controller.selectedSupportedCurrency.value}',
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.6),
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
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.4),
                    ),
                    TitleHeading4Widget(
                      text:
                          '1 ${controller.selectedSupportedCurrency.value} = ${normalizedExchangeRate.toStringAsFixed(8)} ${LocalStorage.getBaseCurrency()}',
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.marginSizeVertical * 0.2),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: Strings.totalCharge,
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.4),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalCharge.toStringAsFixed(4)} ${LocalStorage.getBaseCurrency()}',
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.6),
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
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.4),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalPayable.toStringAsFixed(4)} ${LocalStorage.getBaseCurrency()}',
                      color: CustomColor.primaryLightTextColor
                          .withValues(alpha: 0.6),
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
            "${controller.fundAmountController.text} ${controller.selectedSupportedCurrency.value}");
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isBuyCardLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryDarkColor,
              )
            : PrimaryButton(
                title: Strings.buyNow,
                onPressed: () {
                  controller.buyCardProcess(context);
                },
              ),
      ),
    );
  }
}
