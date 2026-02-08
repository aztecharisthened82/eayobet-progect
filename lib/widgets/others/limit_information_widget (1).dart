import 'package:shimmer/shimmer.dart';
import 'package:stripcard/controller/remaing_balance/remaing_balance_controller.dart';

import '../../utils/basic_screen_import.dart';
import '../text_labels/title_heading5_widget.dart';

class LimitInformationWidget extends StatelessWidget {
  LimitInformationWidget({
    super.key,
    this.transactionLimit,
    required this.dailyLimit,
    required this.remainingDailyLimit,
    required this.monthlyLimit,
    required this.remainingMonthLimit,
    this.showDailyLimit = true, // Controls daily limit visibility
    this.showMonthlyLimit = true, // Controls monthly limit visibility
  });

  final String? transactionLimit;
  final String dailyLimit;
  final String remainingDailyLimit;
  final String monthlyLimit;
  final String remainingMonthLimit;
  final bool showDailyLimit;
  final bool showMonthlyLimit;
  final controller = Get.put(RemainingBalanceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.4),
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 0.4),
      decoration: BoxDecoration(
        color: CustomColor.primaryBGLightColor,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading3Widget(
              text: Strings.limitInformation, color:  Get.isDarkMode
              ? CustomColor.secondaryLightColor
              : CustomColor.whiteColor),
          verticalSpace(Dimensions.heightSize * 0.6),

          if (showDailyLimit)
            Column(
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          TitleHeading5Widget(
                              text: Strings.dailyLimit,
                              color:  Get.isDarkMode
                                  ? CustomColor.secondaryLightColor
                                  : CustomColor.whiteColor),
                          TitleHeading3Widget(
                            text: dailyLimit,
                            fontSize: Dimensions.headingTextSize4 - 1,
                            color: Get.isDarkMode
                                ? CustomColor.secondaryLightColor
                                : CustomColor.whiteColor
                                    .withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: crossEnd,
                        children: [
                          TitleHeading5Widget(
                            text: Strings.remainingDailyLimit,
                            color: Get.isDarkMode
                                ? CustomColor.secondaryLightColor
                                : CustomColor.whiteColor

                          ),
                          Obx(
                            () => controller.isLoading
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 16.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                : TitleHeading3Widget(
                                    fontSize: Dimensions.headingTextSize4 - 1,
                                    text: remainingDailyLimit,
                                    color: Get.isDarkMode
                                        ? CustomColor.secondaryLightColor
                                        : CustomColor.whiteColor
                                            .withValues(alpha: 0.5),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
              ],
            ),

          // Monthly Limit section (only if showMonthlyLimit is true and monthlyLimit is not "0.00")
          if (showMonthlyLimit)
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      TitleHeading5Widget(
                        text: Strings.monthlyLimit,
                        color: Get.isDarkMode
                            ? CustomColor.secondaryLightColor
                            : CustomColor.whiteColor

                      ),
                      TitleHeading3Widget(
                        fontSize: Dimensions.headingTextSize4 - 1,
                        text: monthlyLimit,
                        color:  Get.isDarkMode
                            ? CustomColor.secondaryLightColor
                            : CustomColor.whiteColor.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: crossEnd,
                    children: [
                      TitleHeading5Widget(
                          text: Strings.remainingMonthlyLimit,
                          fontSize: Dimensions.headingTextSize5 - 1,
                          color:  Get.isDarkMode
                              ? CustomColor.secondaryLightColor
                              : CustomColor.whiteColor),
                      Obx(
                        () => controller.isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: Dimensions.heightSize * 1.4,
                                      color: Get.isDarkMode
                                          ? CustomColor.secondaryLightColor
                                          : CustomColor.whiteColor
                                              .withValues(alpha: 0.5),
                                    ),
                                  ],
                                ),
                              )
                            : TitleHeading3Widget(
                                fontSize: Dimensions.headingTextSize4 - 1,
                                text: remainingMonthLimit,
                                color: Get.isDarkMode
                                    ? CustomColor.secondaryLightColor
                                    : CustomColor.whiteColor
                                        .withValues(alpha: 0.5),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          verticalSpace(Dimensions.heightSize * 0.6),

          // Transaction Limit section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transactionLimit != null) ...[
                TitleHeading5Widget(
                  text: Strings.transactionLimit,
                  color:  Get.isDarkMode
    ? CustomColor.secondaryLightColor
        : CustomColor.whiteColor.withValues(alpha: 0.5),
                ),
                TitleHeading3Widget(
                  fontSize: Dimensions.headingTextSize4 - 1,
                  text: transactionLimit!,
                  color: Get.isDarkMode
                      ? CustomColor.secondaryLightColor
                      : CustomColor.whiteColor.withValues(alpha: 0.5),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}
