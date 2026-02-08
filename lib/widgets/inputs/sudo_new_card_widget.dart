import 'dart:io';
import 'package:stripcard/widgets/inputs/primary_input_filed.dart';
import 'package:stripcard/widgets/others/date_picker.dart';
import 'package:stripcard/widgets/supported_currency_widget.dart';
import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/categories/virtual_card/sudo_card/create_card/sudo_create_card_controller.dart';
import '../../controller/categories/virtual_card/sudo_card/sudo_my_card_controller.dart';
import '../../utils/basic_screen_import.dart';
import '../identity_type_dropdown.dart';
import '../others/limit_information_widget (1).dart';

class SudoCreateCardWidget extends StatelessWidget {
  final createCardKey = GlobalKey<FormState>();

  SudoCreateCardWidget({
    Key? key,
    required this.buttonText,
  }) : super(key: key);
  final String buttonText;
  final controller = Get.put(SudoCreateCardController());
  final sudoCardController = Get.put(VirtualSudoCardController());

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    sudoCardController.getRemainingMonthlyLimit.value =
        sudoCardController.remainingController.remainingMonthLyLimit.value;
    sudoCardController.getRemainingDailyLimit.value =
        sudoCardController.remainingController.remainingDailyLimit.value;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sudoCardController.isExtraField == true) ...[
            _firstTimeCreate(),
            _limitInfoShow(),
            _buttonWidget(context),
          ] else ...[
            _inputFieldWidget(context),
            _limitInfoShow(),
            _buttonWidget(context),
          ]
        ],
      ),
    );
  }

  _limitInfoShow() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.5,
      ),
      child: Obx(
        () => LimitInformationWidget(
          transactionLimit:
              '${controller.sudoCardController.limitMin.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value} - ${controller.sudoCardController.limitMax.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
          dailyLimit:
              '${controller.sudoCardController.dailyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
          remainingDailyLimit:
              '${sudoCardController.getRemainingDailyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
          monthlyLimit:
              '${controller.sudoCardController.monthlyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
          remainingMonthLimit:
              '${sudoCardController.getRemainingMonthlyLimit.value.toStringAsFixed(controller.remainingController.dashboardController.precision.value)} ${controller.sudoCardController.selectedSupportedCurrencyCode.value}',
        ),
      ),
    );
  }

  _firstTimeCreate() {
    var data =
        controller.sudoCardController.dashboardController.dashBoardModel.data;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.5,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          verticalSpace(Dimensions.marginBetweenInputBox),
          TitleHeading4Widget(
            text: Strings.dateOfBirth,
            fontWeight: FontWeight.w600,
          ),
          verticalSpace(7),
          CustomDatePicker(
              selectedDate: controller.selectedDateOfBirth, showBorder: true),
          verticalSpace(Dimensions.marginBetweenInputBox),
          PrimaryInputWidget(
              controller: controller.amountTextController,
              hint: Strings.amount,
              keyboardInputType: TextInputType.number,
              label: Strings.cardAmount),
          verticalSpace(Dimensions.marginBetweenInputBox),
          SupportedCurrencyWidget(
            itemsList: sudoCardController.supportedCurrencyList,
            selectMethod: sudoCardController.selectedSupportedCurrencyCode,
            onChanged: (type) {
              sudoCardController.selectedSupportedCurrencyName.value =
                  type!.currencyName;
              sudoCardController.selectedSupportedCurrencyCode.value =
                  type.currencyCode;

              sudoCardController.selectedSupportedCurrencyRate.value =
                  type.rate.toString();

              sudoCardController.updateLimits();
            },
          ),
          verticalSpace(Dimensions.marginBetweenInputBox),
          TitleHeading4Widget(
            text: Strings.identityType,
            fontWeight: FontWeight.w600,
          ),
          verticalSpace(7),
          IdentityTypeDropDown(
            itemsList: sudoCardController.identityTypeList,
            selectMethod: sudoCardController.selectedIdentityType,
            onChanged: (option) {
              sudoCardController.selectedIdentityType.value = option!.name;
              sudoCardController.selectedIdentityTypeCode.value = option.value;
              print(sudoCardController.selectedIdentityTypeCode.value);
            },
          ),
          verticalSpace(Dimensions.marginBetweenInputBox),
          PrimaryInputWidget(
              controller: controller.NumberTextController,
              hint: Strings.number,
              keyboardInputType: TextInputType.number,
              label: Strings.number),
          verticalSpace(Dimensions.marginBetweenInputBox),
          PrimaryInputWidget(
              controller: controller.IdentityTextController,
              hint: Strings.identity,
              keyboardInputType: TextInputType.number,
              label: Strings.identity),
          verticalSpace(Dimensions.marginBetweenInputBox),
          TitleHeading4Widget(
            text: Strings.fromWallet,
            fontWeight: FontWeight.w600,
          ),
          verticalSpace(7),
          SupportedCurrencyWidget(
            itemsList: RxList(),
            selectMethod: RxString(
                '${sudoCardController.supportedCurrencyList.first.currencyName} (${data.userWallet[0].balance.toString()} ${data.userWallet[0].currency.code})'),
            onChanged: (type) {
              sudoCardController.selectedSupportedCurrencyName.value =
                  type!.currencyName;
              sudoCardController.selectedSupportedCurrencyCode.value =
                  type.currencyCode;
            },
          ),
        ],
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    var data =
        controller.sudoCardController.dashboardController.dashBoardModel.data;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.5,
          vertical: Dimensions.marginSizeVertical * 0.5),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          PrimaryInputWidget(
              controller: controller.amountTextController,
              hint: Strings.amount,
              keyboardInputType: TextInputType.number,
              label: Strings.cardAmount),
          verticalSpace(Dimensions.marginBetweenInputBox),
          SupportedCurrencyWidget(
            itemsList: sudoCardController.supportedCurrencyList,
            selectMethod: sudoCardController.selectedSupportedCurrencyCode,
            onChanged: (type) {
              sudoCardController.selectedSupportedCurrencyName.value =
                  type!.currencyName;
              sudoCardController.selectedSupportedCurrencyCode.value =
                  type.currencyCode;
              print(sudoCardController.selectedSupportedCurrencyCode.value);
            },
          ),
          verticalSpace(Dimensions.marginBetweenInputBox),
          TitleHeading4Widget(
            text: Strings.fromWallet,
            fontWeight: FontWeight.w600,
          ),
          verticalSpace(7),
          SupportedCurrencyWidget(
            itemsList: RxList(),
            selectMethod: RxString(
                '${sudoCardController.supportedCurrencyList.first.currencyName} (${data.userWallet[0].balance.toString()} ${data.userWallet[0].currency.code})'),
            onChanged: (type) {
              sudoCardController.selectedSupportedCurrencyName.value =
                  type!.currencyName;
              sudoCardController.selectedSupportedCurrencyCode.value =
                  type.currencyCode;
              print(sudoCardController.selectedSupportedCurrencyCode.value);
            },
          ),
        ],
      ),
    );
  }

  // _customNumKeyBoardWidget(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 6),
  //     child: GridView.count(
  //       physics: const NeverScrollableScrollPhysics(),
  //       crossAxisCount: 3,
  //       crossAxisSpacing: 10.0,
  //       mainAxisSpacing: 10.0,
  //       childAspectRatio: 3 / 1.7,
  //       shrinkWrap: true,
  //       children: List.generate(
  //         controller.keyboardItemList.length,
  //         (index) {
  //           return controller.inputItem(index);
  //         },
  //       ),
  //     ),
  //   );
  // }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.8,
        right: Dimensions.marginSizeHorizontal * 0.8,
        top: Platform.isAndroid ? Dimensions.marginSizeVertical : 0.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              title: buttonText,
              onPressed: () {
                if (controller.amountTextController.text.isNotEmpty) {
                  sudoCardController.calculation();
                  controller.goToCreateNewCardPreviewScreen();
                } else {
                  CustomSnackBar.error(Strings.plzEnterAmount);
                }
              },
              borderColor: Theme.of(context).primaryColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

// _currencyDropDownWidget(BuildContext context) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.25,
//     height: Dimensions.buttonHeight * 0.65,
//     alignment: Alignment.center,
//     margin: EdgeInsets.symmetric(
//         horizontal: Dimensions.marginSizeHorizontal * 0.1,
//         vertical: Dimensions.marginSizeVertical * 0.2),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(Dimensions.radius * 3),
//         color: CustomColor.primaryBGDarkColor),
//     child: Row(children: [
//       SizedBox(
//         width: Dimensions.widthSize,
//       ),
//       ClipRRect(
//         borderRadius: BorderRadius.circular(Dimensions.radius * 1.2),
//         child: CustomImageWidget(
//           path: Assets.qr.usa.path,
//           height: Dimensions.heightSize * 2.3,
//           width: Dimensions.widthSize * 2.3,
//           color: Colors.blue,
//         ),
//       ),
//       horizontalSpace(Dimensions.widthSize),
//       TitleHeading3Widget(
//         text: LocalStorage.getBaseCurrency() ?? 'USD',
//         color: CustomColor.whiteColor,
//         fontWeight: FontWeight.w500,
//       ),
//     ]),
//   );
// }
}
