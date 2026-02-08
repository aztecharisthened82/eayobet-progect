import 'package:stripcard/backend/utils/custom_loading_api.dart';
import 'package:stripcard/widgets/add_money_preview_amount_info.dart';
import 'package:stripcard/widgets/others/preview/amount_preview_widget.dart';
import '../../../controller/navbar/deposit/deposit_controller.dart';
import '../../../controller/navbar/deposit/manual_gateway_controller.dart';
import '../../../utils/basic_screen_import.dart';
import '../../../widgets/appbar/appbar_widget.dart';

class DepositPreviewScreen extends StatelessWidget {
  DepositPreviewScreen({super.key});

  final depositController = Get.put(DepositController());
  final manualController = Get.put(ManualPaymentController());

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
        AddMoneyPreviewAmountInfo(),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(
      amount:
          "${double.tryParse(depositController.amountController.text)?.toStringAsFixed(depositController.remainingController.dashboardController.precision.value)} ${depositController.baseCurrency}",
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => depositController.isPaypalLoading ||
                depositController.isStripeLoading ||
                manualController.isLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryLightColor,
              )
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  depositController.paymentProceed();
                },
              ),
      ),
    );
  }
}
