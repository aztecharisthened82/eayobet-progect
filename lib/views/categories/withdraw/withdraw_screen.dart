import 'package:stripcard/backend/utils/custom_loading_api.dart';
import '../../../backend/local_storage.dart';
import '../../../controller/navbar/withdraw/withdraw_controller.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/dropdown/withdraw_method_drop_down.dart';
import '../../../widgets/others/limit_information_widget (1).dart';
import '../../../widgets/others/limit_widget.dart';
import '../../../utils/basic_screen_import.dart';
import '../../../widgets/inputs/input_with_text.dart';

class MoneyOutScreen extends StatelessWidget {
  MoneyOutScreen({super.key});

  final controller = Get.put(MoneyOutController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.withdraw),
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
              '${controller.limitMin.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value} - ${controller.limitMax.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
          dailyLimit:
              '${controller.dallyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
          remainingDailyLimit:
              '${controller.remainingController.remainingDailyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
          monthlyLimit:
              '${controller.monthlyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
          remainingMonthLimit:
              '${controller.remainingController.remainingMonthLyLimit.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}',
        ),
        _buttonWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize),
        InputWithText(
          controller: controller.moneyOutAmountTextController,
          hint: Strings.zero00,
          label: Strings.amount,
          suffixText: LocalStorage.getBaseCurrency() ?? 'USD',
        ),
        Column(
          crossAxisAlignment: crossStart,
          children: [
            verticalSpace(Dimensions.heightSize),
            TitleHeading4Widget(
              text: Strings.depositMethod,
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(Dimensions.heightSize * 0.6),
            WithdrawMethodDropDown(
              itemsList: controller.allCurrencyList,
              selectMethod: controller.selectedCurrencyName,
              onChanged: (currency) {
                controller.selectedCurrencyName.value = currency!.name;
                controller.selectedCurrencyAlias.value = currency.alias;
              },
            ),
            limitWidget(
              fee:
                  "${controller.fixesCharge.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.baseCurrency.value}",
            ),
          ],
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 1.6,
      ),
      child: Obx(
        () => controller.isInsertLoading
            ? CustomLoadingAPI(color: CustomColor.primaryLightColor)
            : PrimaryButton(
                title: Strings.proceed,
                onPressed: () {
                  print(controller.limitMin);
                  print(controller.limitMax);
                  controller.manualPaymentGetGatewaysProcess();
                },
              ),
      ),
    );
  }
}
