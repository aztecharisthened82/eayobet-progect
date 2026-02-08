import 'package:get/get.dart';

import '../../../../backend/model/virtual_card/card_charges_model.dart';
import '../../../../backend/model/virtual_card/my_card_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../routes/routes.dart';

class CreateCardController extends GetxController {
  List<SupportedCurrency> supportedCurrencyList = [];


  RxDouble cardChare = 0.0.obs;
  RxDouble percentCharge = 0.0.obs;
  RxDouble totalCharge = 0.0.obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    _getCardChargesData();
    super.onInit();
  }

  goToCreateNewCardPreviewScreen() {
    Get.toNamed(Routes.createNewCardPreviewScreen);
  }

  RxString selectItem = ''.obs;
  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];
  List currencyList = ['USD', 'BDT'];
  List gatewayList = ['Paypal', 'Stripe'];


  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  // card charges info
  late CardChargesModel _cardChargesModel;

  CardChargesModel get cardChargesModel => _cardChargesModel;

  Future<CardChargesModel> _getCardChargesData() async {
    _isLoading.value = true;
    update();

    await ApiServices.cardChargesApi().then((value) {
      _cardChargesModel = value!;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
      update();
    });

    _isLoading.value = false;
    update();
    return _cardChargesModel;
  }



  // getter
  get getCardChargesData => _getCardChargesData();
}
