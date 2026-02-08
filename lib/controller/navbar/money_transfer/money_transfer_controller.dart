import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../utils/basic_screen_import.dart';
import '../../../widgets/others/congratulation_widget.dart';
import '../../remaing_balance/remaing_balance_controller.dart';
import 'money_transfer_info_controller.dart';

class MoneyTransferController extends GetxController {
  final receiverEmailController = TextEditingController();
  final amountController = TextEditingController();
  final remainingController = Get.put(RemainingBalanceController());
  final moneyInfoController = Get.put(MoneyTransferInfoController());

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  ///  >>>>>> Start check user  process
  var amount = 0.0.obs; // Observable variable
  List<double> presetAmounts = [10, 20, 50, 100, 200];

  @override
  void onInit() {
    super.onInit();
    amountController.text = amount.value.toStringAsFixed(2);
  }

  void setAmount(double value) {
    amount.value = value;
    amountController.text = value.toStringAsFixed(2);
  }

  void increment() {
    amount.value += 1;
    amountController.text = amount.value.toStringAsFixed(2);
  }

  void decrement() {
    if (amount.value > 0) {
      amount.value -= 1;
      amountController.text = amount.value.toStringAsFixed(2);
    }
  }

  late CommonSuccessModel _transferCheckModel;

  CommonSuccessModel get transferCheckModel => _transferCheckModel;

  Future<CommonSuccessModel> transferCheckUserProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {"email": receiverEmailController.text};
    await ApiServices.transferMoneyCheckUserApi(body: inputBody)
        .then((value) {
          _transferCheckModel = value!;
          update();
          Get.toNamed(Routes.moneyTransferPreviewScreen);
          update();
        })
        .catchError((onError) {
          log.e(onError);
          update();
        });

    _isLoading.value = false;
    update();
    return _transferCheckModel;
  }

  //transfer confirm
  final _isConfirmLoading = false.obs;

  bool get isConfirmLoading => _isConfirmLoading.value;
  late CommonSuccessModel _transferConfirmModel;

  CommonSuccessModel get buyCardModel => _transferConfirmModel;

  Future<CommonSuccessModel> transferMoneyConfirmProcess(context) async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "email": receiverEmailController.text,
      "amount": amountController.text,
    };
    await ApiServices.transferMoneyConfirmApi(body: inputBody)
        .then((value) {
          _transferConfirmModel = value!;
          update();

          StatusScreen.show(
            context: context,
            subTitle: Strings.transferSuccessText.tr,
            onPressed: () {
              Get.offAllNamed(Routes.bottomNavBarScreen);
            },
          );
          update();
        })
        .catchError((onError) {
          log.e(onError);
          update();
        });

    _isConfirmLoading.value = false;
    update();
    return _transferConfirmModel;
  }
}
