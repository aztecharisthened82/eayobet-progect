import '../../../../../backend/services/api_services.dart';
import '../../../../backend/local_storage.dart';
import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/model/virtual_card/my_card_model.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/others/congratulation_widget.dart';
import '../../../navbar/dashboard_controller.dart';

class FlutterWaveCardController extends GetxController {
  final cardAmountTextController = TextEditingController();
  final RxString cardId = ''.obs;
  final RxString amount = ''.obs;
  final RxString Currency = ''.obs;
  final RxString FromCurrency = ''.obs;
  List<SupportedCurrency> supportedCurrencyList = [];
  RxString selectedSupportedCurrencyCode = "".obs;
  RxString selectedIdentityType = "Select Type".obs;
  RxString selectedIdentityTypeCode = "".obs;
  RxDouble selectedSupportedCurrencyRate = 0.0.obs;
  RxString selectedSupportedCurrencyName = "Select Currency".obs;

  RxString baseCurrency = "".obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  RxDouble dailyLimit = 0.0.obs;
  RxDouble monthlyLimit = 0.0.obs;
  RxDouble getRemainingDailyLimit = 0.0.obs;
  RxDouble getRemainingMonthlyLimit = 0.0.obs;
  RxDouble exchangeRate = 0.0.obs;

  final dashboardController = Get.put(DashBoardController());

  @override
  void onInit() {
    dashboardController.getDashboardData().then((value) {
      if (dashboardController.dashBoardModel.data.activeVirtualSystem ==
          'flutterwave') {
        getCardData();
      }
    });

    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late FlutterMyCardModel _myCardModel;

  FlutterMyCardModel get myCardModel => _myCardModel;

  Future<FlutterMyCardModel> getCardData() async {
    _isLoading.value = true;
    update();

    await ApiServices.myCardApi().then((value) {
      _myCardModel = value!;
      cardId.value = _myCardModel.data.myCards.isNotEmpty
          ? _myCardModel.data.myCards.first.cardId.toString()
          : '';
      Currency.value = _myCardModel.data.myCards.isNotEmpty
          ? _myCardModel.data.baseCurr
          : '';
      FromCurrency.value = _myCardModel.data.myCards.isNotEmpty
          ? _myCardModel.data.baseCurr
          : '';

      LocalStorage.saveVirtualImage(
          virtualImage: _myCardModel.data.myCards.isNotEmpty
              ? _myCardModel.data.cardBasicInfo.cardBg
              : '');

      for (var v in _myCardModel.data.supportedCurrency) {
        supportedCurrencyList.add(SupportedCurrency(
          id: v.id,
          name: v.name,
          status: v.status,
          rate: v.rate,
          currencySymbol: v.currencySymbol,
          currencyCode: v.currencyCode,
          currencyName: v.currencyName,
          mobileCode: v.mobileCode,
        ));
      }
      selectedSupportedCurrencyCode.value =
          _myCardModel.data.supportedCurrency.first.currencyCode;
      dailyLimit.value = _myCardModel.data.cardCharge.dailyLimit.toDouble();
      monthlyLimit.value = _myCardModel.data.cardCharge.monthlyLimit.toDouble();
      limitMin.value = _myCardModel.data.cardCharge.minLimit.toDouble();
      limitMax.value = _myCardModel.data.cardCharge.maxLimit.toDouble();
      baseCurrency.value = _myCardModel.data.baseCurr;
      // exchangeRate.value = _myCardModel.data.baseCurrRate.toDouble();

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _myCardModel;
  }

  void limitCalculation() {
    limitMax.value = limitMax.value * selectedSupportedCurrencyRate.value;
    limitMax.value = limitMax.value * selectedSupportedCurrencyRate.value;
  }

  // create card  process
  late CommonSuccessModel _createCardModel;

  CommonSuccessModel get createCardModel => _createCardModel;

  Future<CommonSuccessModel> createCardProcess(context) async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'card_amount': cardAmountTextController.text,
      'currency': selectedSupportedCurrencyCode.value.isEmpty
          ? baseCurrency.value
          : selectedSupportedCurrencyCode.value,
      'from_currency': baseCurrency.value,
    };
    await ApiServices.createCardApi(body: inputBody).then((value) {
      _createCardModel = value!;
      update();

      StatusScreen.show(
        context: context,
        subTitle: Strings.yourCardSuccess.tr,
        onPressed: () {
          Get.offAllNamed(Routes.bottomNavBarScreen);
        },
      );
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _createCardModel;
  }
}
