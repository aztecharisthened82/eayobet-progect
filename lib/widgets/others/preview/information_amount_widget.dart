import 'package:get/get.dart';
import 'package:stripcard/controller/navbar/dashboard_controller.dart';
import 'package:stripcard/widgets/text_labels/title_heading4_widget.dart';
import 'package:flutter/material.dart';
import '../../../controller/categories/virtual_card/sudo_card/create_card/sudo_create_card_controller.dart';
import '../../../controller/categories/virtual_card/sudo_card/sudo_my_card_controller.dart';
import '../../../language/strings.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../text_labels/title_heading3_widget.dart';

extension AmountInformation on Widget {
  Widget amountInformationWidget({
    required information,
    required enterAmount,
    required enterAmountRow,
    required fee,
    required feeRow,
    required exChange,
    required exChangeRow,
    received,
    receivedRow,
    total,
    totalRow,
  }) {
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
              text: information,
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
                      text: enterAmount,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading3Widget(
                      text: enterAmountRow,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: exChange,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading3Widget(
                      text: exChangeRow,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: fee,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading3Widget(
                      text: feeRow,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: received,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading3Widget(
                      text: receivedRow,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                      text: total,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading3Widget(
                      text: totalRow,
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
}

class AmountPreviewInfoWidget extends StatelessWidget {
  AmountPreviewInfoWidget({super.key});

  final controller = Get.put(SudoCreateCardController());
  final sudoController = Get.put(VirtualSudoCardController());
  final dashboardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    var _cardCharge = controller.cardChargesModel.data.cardCharge;
    var baseCurrency = controller.cardChargesModel.data.baseCurr;

// Get exchange rate
    double exchangeRate = controller.sudoCardController.exchangeRate.value;

// Get user input amount
    double amount = double.parse(controller.amountTextController.text);

    double roundToFourDecimals(double value) {
      return double.parse(value.toStringAsFixed(4));
    }

// Convert amount to base currency
    double convertedAmount = roundToFourDecimals(amount * exchangeRate);

// Calculate percentage charge
    double percentCharge = roundToFourDecimals((convertedAmount / 100) * _cardCharge.percentCharge);

// Calculate total charge
    double totalCharge = roundToFourDecimals(_cardCharge.fixedCharge + percentCharge);

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
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${double.tryParse(controller.amountTextController.text)?.toStringAsFixed(dashboardController.precision.value) ?? '0.00'} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
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
                          '1 ${controller.sudoCardController.selectedSupportedCurrencyCode.value} = ${controller.sudoCardController.exchangeRate.toStringAsFixed(8)} $baseCurrency',
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
                      text: Strings.transferFee,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${_cardCharge.fixedCharge.toStringAsFixed(dashboardController.precision.value)} $baseCurrency',
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
                          '${amount.toStringAsFixed(dashboardController.precision.value)} $baseCurrency',
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
                      text: Strings.totalCharge,
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${totalCharge.toStringAsFixed(controller.sudoCardController.dashboardController.precision.value)} $baseCurrency',
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
                          '${totalPayable.toStringAsFixed(dashboardController.precision.value)} $baseCurrency',
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
}
