import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../backend/utils/custom_snackbar.dart';
import '../../../../controller/categories/virtual_card/stripe_card/stripe_two_controller.dart';
import '../../../../controller/remaing_balance/remaing_balance_controller.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/inputs/primary_input_filed.dart';
import '../../../../widgets/others/all_supported_currency_widget/supported_currecny_dropdown.dart';
import '../../../../widgets/others/flip_card_widget.dart';
import '../../../../widgets/others/limit_information_widget (1).dart';

class StripeCreateCardScreen extends StatelessWidget {
  StripeCreateCardScreen({super.key, required this.controller});

  final StripeTwoController controller;

  final remainingController = Get.put(RemainingBalanceController());

  @override
  Widget build(BuildContext context) {
    controller.percentCharge.value =
        controller.stripeCardModel.data.cardCharge.percentCharge.toDouble();
    controller.updateLimits();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: Dimensions.marginSizeVertical * 3.5,
            right: Dimensions.marginSizeHorizontal * 0.5,
            left: Dimensions.marginSizeHorizontal * 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              title: Strings.confirm,
              onPressed: () {
                if (controller.fundAmountController.text.isNotEmpty) {
                  controller.calculation();
                  Get.toNamed(Routes.stripCardPreview);
                } else {
                  CustomSnackBar.error(Strings.plzEnterAmount);
                }
              },
              borderColor: Theme.of(context).primaryColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.isLoading ? CustomLoadingAPI() : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var baseCurrency = controller.stripeCardModel.data.baseCurr;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.7),
      children: [
        _imageWidget(context),
        verticalSpace(Dimensions.marginBetweenInputBox),

        StripSupportedCurrency(
          itemsList: controller.supportedCurrencyList,
          selectMethod: controller.selectedSupportedCurrency,
          onChanged: (type) {
            controller.selectedSupportedCurrency.value = type!.currencyCode;
            controller.code.value = type.currencyCode;
            controller.selectedSupportedCurrencyRate.value =
                type.rate.toDouble();
            controller.updateLimits();
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingSize),
          child: PrimaryInputWidget(
            controller: controller.fundAmountController,
            hint: Strings.amount,
            keyboardInputType: TextInputType.number,
            label: Strings.cardAmount,
            onChanged: (p0) {
              controller.calculation();
            },
          ),
        ),
        verticalSpace(Dimensions.marginBetweenInputBox),
        LimitInformationWidget(
          transactionLimit:
              '${controller.getLimitMin.value.toStringAsFixed(remainingController.dashboardController.precision.value)} ${controller.code.value} - ${controller.getLimitMax.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.code.value}',
          dailyLimit:
              '${controller.getDallyLimit.value.toStringAsFixed(remainingController.dashboardController.precision.value)} ${controller.code.value}',
          remainingDailyLimit:
              '${controller.getRemainingDailyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.code.value}',
          monthlyLimit:
              '${controller.getMonthlyLimit.value.toStringAsFixed(remainingController.dashboardController.precision.value)} ${controller.code.value}',
          remainingMonthLimit:
              '${controller.getRemainingMonthLyLimit.value.toStringAsFixed(remainingController.dashboardController.precision.value)} ${controller.code.value}',
        ),
        // _balance(context),
      ],
    );
  }

  _imageWidget(BuildContext context) {
    return CrateFlipCardWidget(
      title: Strings.visa,
      availableBalance: Strings.cardHolder,
      cardNumber: 'xxxx xxxx xxxx xxxx',
      expiryDate: 'xx/xx',
      balance: 'xx',
      validAt: 'xx',
      cvv: 'xxx',
      logo: Assets.logo.appLauncher.path,
      isNetworkImage: false,
    );
  }

  _balance(BuildContext context) {
    var userData = controller.stripeCardModel.data.userWallet;
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 0.3,
        bottom: Dimensions.marginSizeVertical * 2,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              TitleHeading4Widget(
                text: Strings.balance,
                color: CustomColor.grayColor,
              ),
              TitleHeading4Widget(
                text:
                    ": ${userData.first.balance.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${userData.first.currency.code}",
                color: CustomColor.primaryDarkTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
