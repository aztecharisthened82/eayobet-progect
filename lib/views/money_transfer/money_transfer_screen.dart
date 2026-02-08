import 'package:stripcard/backend/utils/custom_loading_api.dart';
import 'package:stripcard/widgets/inputs/primary_input_filed.dart';
import 'package:stripcard/widgets/others/money_transfer_amount_widget.dart';
import '../../../utils/basic_screen_import.dart';
import '../../controller/navbar/money_transfer/money_transfer_controller.dart';
import '../../controller/navbar/money_transfer/money_transfer_info_controller.dart';
import '../../widgets/others/limit_information_widget (1).dart';

class MonetTransferScreen extends StatelessWidget {
  MonetTransferScreen({super.key});

  final controller = Get.put(MoneyTransferController());
  final infoController = Get.put(MoneyTransferInfoController());

  final moneyTransferFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: TitleHeading4Widget(
            text: Strings.moneyTransfer,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor
                : CustomColor.primaryDarkTextColor,
            fontSize: Dimensions.headingTextSize2,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Get.isDarkMode
              ? CustomColor.primaryDarkScaffoldBackgroundColor
              : CustomColor.bgLightColor,
          actions: [],
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = infoController.transferMoneyInfoModel.data.transferMoneyCharge;
    var baseCurrency = infoController.transferMoneyInfoModel.data.baseCurr;
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      children: [
        _walletBalance(),
        TransactionDetailsWidget(),
        MoneyTransferAmountWidget(),
        // RecentRecipientsWidget(),
        _inputWidget(context),
        LimitInformationWidget(
          dailyLimit:
              '${data.dailyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} $baseCurrency',
          remainingDailyLimit:
              '${controller.remainingController.remainingDailyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} $baseCurrency',
          monthlyLimit:
              '${data.monthlyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} $baseCurrency',
          remainingMonthLimit:
              '${controller.remainingController.remainingDailyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} $baseCurrency',
        ),
        _buttonWidget(context),
      ],
    );
  }

  _walletBalance() {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading4Widget(
          padding: EdgeInsets.only(
            top: Dimensions.marginSizeVertical * 0.5,
            bottom: Dimensions.marginSizeVertical * 0.3,
          ),
          text: Strings.selectWallet,
          color: Get.isDarkMode
              ? CustomColor.primaryLightTextColor
              : CustomColor.primaryDarkTextColor,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
            child: Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CustomColor.primaryLightScaffoldBackgroundColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.marginSizeVertical * 0.4,
                        top: Dimensions.marginSizeVertical * 0.5,
                        bottom: Dimensions.marginSizeVertical * 0.4,
                        right: Dimensions.marginSizeVertical * 0.2,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColor.primaryLightColor.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.8,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: mainCenter,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: crossCenter,
                        children: [
                          TitleHeading3Widget(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.marginSizeVertical * 0.2,
                            ),
                            text: 'S',
                            fontSize: Dimensions.headingTextSize2 * 1.5,
                            fontWeight: FontWeight.w700,
                            color: CustomColor.primaryLightColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(Dimensions.marginSizeHorizontal * 0.4),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: crossStart,
                      mainAxisAlignment: mainCenter,
                      children: [
                        Row(
                          children: [
                            TitleHeading4Widget(
                              text: controller.moneyInfoController.balance.value
                                  .toStringAsFixed(
                                    controller
                                        .remainingController
                                        .dashboardController
                                        .precision
                                        .value,
                                  ),
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: Dimensions.headingTextSize4 + 2,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode
                                  ? CustomColor.whiteColor
                                  : CustomColor.primaryDarkTextColor,
                            ),
                            horizontalSpace(Dimensions.widthSize * 0.3),
                            TitleHeading4Widget(   
                              text:   
                                  controller.moneyInfoController.currency.value,       

                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: Dimensions.headingTextSize4 + 2,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode
                                  ? CustomColor.primaryLightColor
                                  : CustomColor.primaryLightColor,
                            ),
                          ],
                        ),
                        verticalSpace(Dimensions.widthSize * 0.2),
                        CustomTitleHeadingWidget(
                          text: Strings.availabeBlance,   
                          style: CustomStyle.darkHeading4TextStyle.copyWith(
                            fontSize: Dimensions.headingTextSize5,
                            fontWeight: FontWeight.w400,
                            color: CustomColor.grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: moneyTransferFormKey,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
           verticalSpace(Dimensions.heightSize * 0.8),
          Divider(
            color: CustomColor.grayColor.withValues(alpha: 0.15),
          
          ),
          verticalSpace(Dimensions.heightSize * 1),
          PrimaryInputWidget(
            keyboardInputType: TextInputType.emailAddress,
            controller: controller.receiverEmailController,
            hint: Strings.enterReceiverEmailAddress,
            label: Strings.receiverEmail,
          ),
          verticalSpace(Dimensions.heightSize),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.marginSizeVertical * 3,
        top: Dimensions.marginSizeVertical * 0.2,
      ),
      child: Obx(
        () => controller.isLoading
            ? CustomLoadingAPI(color: CustomColor.primaryLightColor)
            : PrimaryButton(
                title: Strings.moneyTransfer,
                onPressed: () {
                  controller.transferCheckUserProcess();
                },
              ),
      ),
    );
  }
}
