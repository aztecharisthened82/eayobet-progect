part of "../cardyfie_create_card_screen.dart";

class CardyfieCreateCardWidget extends StatelessWidget {
  CardyfieCreateCardWidget({super.key});
  final controller = Get.put(VirtualCardyfieCardController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _inputWidget(context),
        _walletWidget(context),
        _chargeWidget(context),
        _buttonWidget(context),
        _buttonCustomerUpdateWidget(context),
      ],
    );
  }

  _walletWidget(BuildContext context) {
    return Column(
      children: [
        // card currency also support wallet are same
        Obx(
          () => Container(
            margin: EdgeInsets.only(bottom: Dimensions.heightSize),
            child: CustomDropDown<SupportedCurrency>(
              dropDownHeight: Dimensions.inputBoxHeight * 0.75,
              items: controller.supportedCurrencyList,
              title: Strings.cardCurrency,
              hint: controller.supportedCurrencyCode.value,
              onChanged: (value) {
                controller.selectSupportedCurrency.value = value!;
                controller.supportedCurrencyCode.value = value.currencyCode
                    .toString();
                print(controller.fromCurrency.value);
              },
              dropDownColor: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.whiteColor,
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.5,
                right: Dimensions.paddingSize * 0.4,
              ),
              titleTextColor: Get.isDarkMode
                  ? CustomColor.whiteColor
                  : CustomColor.blackColor,
              borderEnable: true,
              dropDownFieldColor: Colors.transparent,
              dropDownIconColor: CustomColor.blackColor,
            ),
          ),
        ),

        // from currency come to user wallet
        Obx(
          () => Container(
            margin: EdgeInsets.only(bottom: Dimensions.heightSize),
            child: CustomDropDown<UserWallet>(
              dropDownColor: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.whiteColor,
              dropDownHeight: Dimensions.inputBoxHeight * 0.75,
              items: controller.walletsList,
              title: Strings.fromWallet,
              hint: controller.selectMainWallet.value!.title,
              onChanged: (value) {
                controller.selectMainWallet.value = value!;
                controller.fromCurrency.value = value.currency.code.toString();
                print(controller.fromCurrency.value);
              },
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.5,
                right: Dimensions.paddingSize * 0.4,
              ),
              titleTextColor: Get.isDarkMode
                  ? CustomColor.whiteColor
                  : CustomColor.blackColor,
              borderEnable: true,
              dropDownFieldColor: Colors.transparent,
              dropDownIconColor: CustomColor.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        verticalSpace(Dimensions.heightSize),
        PrimaryInputWidget(
          controller: controller.cardHolderNameController,
          hint: Strings.cardHolder,
          label: Strings.cardHolder,
        ),
        verticalSpace(Dimensions.heightSize),
        CustomDropDown<StringDropdownModel>(
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.5,
            right: Dimensions.paddingSize * 0.4,
          ),
          titleTextColor: Get.isDarkMode
              ? CustomColor.whiteColor
              : CustomColor.blackColor,
          dropDownColor: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.whiteColor,
          dropDownHeight: Dimensions.inputBoxHeight * 0.75,
          title: Strings.cardTier,
          hint: controller.selectTierName.value,

          items: controller.cardTierList
              .map(
                (e) => StringDropdownModel(title: e['name']!, slug: e['slug']!),
              )
              .toList(),
          onChanged: (value) {
            controller.selectTierName.value = value!.title;
            if (controller.selectTierName.value == "Universal") {
              controller.totalCharge.value = double.parse(
                controller
                    .cardyfieCardModel
                    .data
                    .cardCharge
                    .universalCardIssuesFee
                    .toString(),
              );

              print(controller.totalCharge);
            } else {
              controller.totalCharge.value = double.parse(
                controller
                    .cardyfieCardModel
                    .data
                    .cardCharge
                    .platinumCardIssuesFee
                    .toString(),
              );
            }

            controller.selectTierSlug.value = value.slug!;
          },
        ),
        verticalSpace(Dimensions.heightSize),
        CustomDropDown<StringDropdownModel>(
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.5,
            right: Dimensions.paddingSize * 0.4,
          ),
          titleTextColor: Get.isDarkMode
              ? CustomColor.whiteColor
              : CustomColor.blackColor,
          dropDownColor: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.whiteColor,
          dropDownHeight: Dimensions.inputBoxHeight * 0.75,
          title: Strings.cardType,
          hint: controller.selectCardTypeName.value,
          items: controller.cardTypeList
              .map(
                (e) => StringDropdownModel(title: e['name']!, slug: e['slug']!),
              )
              .toList(),
          onChanged: (value) {
            controller.selectCardTypeName.value = value!.title;
            controller.selectCardTypeSlug.value = value.slug!;
          },
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  _chargeWidget(BuildContext context) {
    var userData = controller.cardyfieCardModel.data;
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            const TitleHeading4Widget(text: Strings.totalCharge),
            Obx(
              () => TitleHeading4Widget(
                text: "${controller.totalCharge.value} ${userData.baseCurr}",
                fontSize: Dimensions.headingTextSize5,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize * 0.4),
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            const TitleHeading4Widget(text: Strings.totalPay),
            Obx(
              () => TitleHeading4Widget(
                text: "${controller.totalCharge.value} ${userData.baseCurr}",
                fontSize: Dimensions.headingTextSize5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.paddingSize * 1.4,
        // bottom: Dimensions.paddingSize * 4.8,
      ),
      child: Obx(
        () => controller.isBuyCardLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  controller.issueCardProcess(context);
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }

  _buttonCustomerUpdateWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.paddingSize,
        bottom: Dimensions.paddingSize * 4.8,
      ),
      child: Obx(
        () => controller.isCustomerCreateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.updateCustomer,
                onPressed: () {
                  print(controller.listFieldName);
                  print(controller.listImagePath);

                  Get.toNamed(Routes.cardyfieUpdateCustomerScreen);
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
