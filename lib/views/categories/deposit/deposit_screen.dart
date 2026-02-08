import 'package:stripcard/backend/utils/custom_loading_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/controller/app_settings/app_settings_controller.dart';
import '../../../backend/local_storage.dart';
import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/navbar/deposit/deposit_controller.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/inputs/deposit_method_drop_down.dart';
import '../../../widgets/others/limit_information_widget (1).dart';
import '../../../widgets/others/limit_widget.dart';
import '../../../utils/basic_screen_import.dart';
import '../../../widgets/inputs/input_with_text.dart';

class DepositScreen extends StatelessWidget {
  DepositScreen({super.key});

  final controller = Get.put(DepositController());
  final appSettingController = Get.put(AppSettingsController());

  // final depositFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.limitCalculation();
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.deposit),
        body: Obx(
          () => controller.isLoading
              ? CustomLoadingAPI(color: CustomColor.primaryLightColor)
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      children: [
        _inputWidget(context),
        LimitInformationWidget(
          transactionLimit:
              '${controller.minLimCal.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value} - ${controller.maxLimCal.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value}',
          dailyLimit:
              '${controller.dallyLimit.value.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value}',
          remainingDailyLimit:
              '${controller.remainingController.remainingDailyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
          monthlyLimit:
              '${controller.monthlyLimit.value.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value}',
          remainingMonthLimit:
              '${controller.remainingController.remainingMonthLyLimit.value.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value}',
        ),
        _buttonWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: crossStart,
          children: [
            verticalSpace(Dimensions.heightSize),
            TitleHeading4Widget(
              text: Strings.depositMethod,
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(Dimensions.heightSize * 0.6),
            DepositMethodDropDown(
              itemsList: controller.currencyList,
              selectMethod: controller.selectedCurrencyName,
              onChanged: (currency) {
                controller.selectedCurrencyName.value = currency!.name;
                controller.selectedCurrencyAlias.value = currency.alias;
                controller.selectedCurrencyType.value = currency.type
                    .toString();
                controller.code.value = currency.currencyCode;
                controller.crypto.value = int.parse(currency.crypto);
                controller.selectedFee.value = currency.fixedCharge.toDouble();
                controller.supportedRate.value = currency.rate;
                controller.percentCharge.value = currency.percentCharge
                    .toDouble();
                controller.dallyLimit.value = currency.dailyLimit.toDouble();
                controller.monthlyLimit.value = currency.monthlyLimit
                    .toDouble();
                controller.limitMin.value = currency.minLimit.toDouble();
                controller.limitMax.value = currency.maxLimit.toDouble();

                print(controller.selectedCurrencyAlias.value);

                controller.limitCalculation();
                controller.remainingController.getRemainingBalanceProcess();
              },
            ),
            limitWidget(
              fee:
                  "${controller.selectedFee.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.baseCurrency.value}",
            ),
            Row(
              children: [
                TitleHeading4Widget(
                  text: Strings.exchangeRate,
                  textAlign: TextAlign.left,
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode
                      ? CustomColor.grayColor
                      : CustomColor.primaryDarkTextColor,
                ),
                Text(
                  " : 1 ${controller.baseCurrency.value} = ${controller.supportedRate.value.toStringAsFixed(controller.crypto.value == '1' ? appSettingController.cryptoPrecisionValue.value : appSettingController.fiatPrecisionValue.value)} ${controller.code.value}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize5,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? CustomColor.grayColor
                        : CustomColor.primaryDarkTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        InputWithText(
          controller: controller.amountController,
          hint: Strings.zero00,
          label: Strings.amount,
          suffixText: LocalStorage.getBaseCurrency() ?? 'USD',
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 1.6,
      ),
      child: PrimaryButton(
        title: Strings.proceed,
        onPressed: () {
          controller.amount.value = double.parse(
            controller.amountController.text,
          );

          if (controller.amountController.text.isNotEmpty) {
            if (controller.minLimCal.value <= controller.amount.value &&
                controller.maxLimCal.value >= controller.amount.value) {
              if (controller.selectedCurrencyAlias.value.contains(
                "authorize",
              )) {
                controller.authorizeSubmitProcess();
              } else {
                print("test2");
                Get.toNamed(Routes.depositPreviewScreen);
              }
            } else {
              CustomSnackBar.error(Strings.pleaseFollowTheLimit);
            }
          } else {
            CustomSnackBar.error(Strings.pleaseFillTheAmount);
          }
          print(controller.limitMin.value);
          print('---------------------------------------');
        },
      ),
    );
  }
}
