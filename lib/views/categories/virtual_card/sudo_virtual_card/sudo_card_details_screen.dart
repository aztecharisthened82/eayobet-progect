import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../backend/utils/custom_switch_loading_api.dart';
import '../../../../controller/categories/virtual_card/sudo_card/sudo_card_details_controller.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/appbar/appbar_widget.dart';
import '../../../../widgets/others/preview/details_row_widget.dart';
import '../cvc_vgs_widget.dart';
import 'vgs_widget.dart';

class SudoCardDetailsScreen extends StatelessWidget {
  SudoCardDetailsScreen({super.key});
  final controller = Get.put(SudoCardDetailsController());

  get payload => null;
  @override
  Widget build(
    BuildContext context,
  ) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.details),
        body: Obx(
          () => controller.isLoading
              ? CustomLoadingAPI(
                  color: CustomColor.primaryDarkColor,
                )
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.9,
      ),
      child: Column(
        children: [
          _amountWidget(context),
          _cardDetailsWidget(context),
        ],
      ),
    );
  }

  _amountWidget(BuildContext context) {
    var data = controller.cardDetailsModel.data;
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
      ),
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 0.2),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          CustomTitleHeadingWidget(
            text: '${data.cardDetails.amount} ${data.baseCurr}',
            textAlign: TextAlign.center,
            style: CustomStyle.darkHeading1TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize4 * 2,
              fontWeight: FontWeight.w800,
              color: CustomColor.primaryTextColor,
            ),
          ),
          verticalSpace(Dimensions.heightSize * 0.5),
          TitleHeading4Widget(
            text: Strings.currentAmount,
            textAlign: TextAlign.center,
            color: CustomColor.primaryTextColor.withValues(alpha: 0.6),
          ),
          verticalSpace(Dimensions.heightSize * 0.4),
        ],
      ),
    );
  }

  _cardDetailsWidget(BuildContext context) {
    var myCards = controller.cardDetailsModel.data.cardDetails;
    var cardSecureDate = controller.cardDetailsModel.data.cardSecureDate;

    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.4),
      decoration: BoxDecoration(
          color: CustomColor.primaryLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Column(crossAxisAlignment: crossStart, children: [
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.paddingSize * 0.7,
            bottom: Dimensions.paddingSize * 0.3,
            left: Dimensions.paddingSize * 0.7,
            right: Dimensions.paddingSize * 0.7,
          ),
          child: TitleHeading3Widget(
            text: Strings.cardInformation,
            textAlign: TextAlign.left,
          ),
        ),
        Divider(
          thickness: 1,
          color: CustomColor.primaryLightScaffoldBackgroundColor,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.paddingSize * 0.3,
            bottom: Dimensions.paddingSize * 0.6,
            left: Dimensions.paddingSize * 0.7,
            right: Dimensions.paddingSize * 0.7,
          ),
          child: Column(
            children: [
              DetailsRowWidget(
                variable: Strings.cardHolder,
                value: myCards.cardHolder,
              ),
              DetailsRowWidget(
                variable: Strings.currency,
                value: myCards.currency,
              ),
              DetailsRowWidget(
                variable: Strings.cardType,
                value: myCards.type,
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isRevealedDetails.value,
                  child: DetailsRowWidget(
                    variable: Strings.cardNumber,
                    value: myCards.cardPan,
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isRevealedDetails.value,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: Dimensions.paddingSize * 0.4,
                    ),
                    child: Row(
                      mainAxisAlignment: mainSpaceBet,
                      children: [
                        Expanded(
                          child: CustomTitleHeadingWidget(
                            text: Strings.cardNumber,
                            style: CustomStyle.darkHeading4TextStyle.copyWith(
                              color: CustomColor.primaryLightTextColor
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            width: 150,
                            child: VgsIntegrationWidget(
                              environment: cardSecureDate.apiMode,
                              token: cardSecureDate.cardToken,
                              cardId: myCards.cardId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isRevealedDetails.value,
                  child: DetailsRowWidget(
                    variable: Strings.cvc,
                    value: myCards.cvv,
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isRevealedDetails.value,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: Dimensions.paddingSize * 0.4,
                    ),
                    child: Row(
                      mainAxisAlignment: mainSpaceBet,
                      children: [
                        Expanded(
                          child: CustomTitleHeadingWidget(
                            text: Strings.cvc,
                            style: CustomStyle.darkHeading4TextStyle.copyWith(
                              color: CustomColor.primaryLightTextColor
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            width: 80,
                            child: VgsCVCIntegrationWidget(
                              environment: cardSecureDate.apiMode,
                              token: cardSecureDate.cardToken,
                              cardId: myCards.cardId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DetailsRowWidget(
                variable: Strings.expiration,
                value: "${myCards.expiryMonth}/${myCards.expiryYear}",
              ),
              DetailsRowWidget(
                variable: Strings.brand,
                value: myCards.brand,
              ),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  CustomTitleHeadingWidget(
                    text: Strings.freezeCard,
                    style: CustomStyle.darkHeading4TextStyle.copyWith(
                      color:
                          CustomColor.primaryTextColor.withValues(alpha: 0.4),
                    ),
                  ),
                  Obx(
                    () => controller.isCardStatusLoading
                        ? CustomSwitchLoading(
                            color: CustomColor.whiteColor,
                          )
                        : Switch(
                            activeColor: CustomColor.whiteColor,
                            inactiveThumbColor: CustomColor.whiteColor,
                            value: controller.isSelected.value,
                            onChanged: ((value) {
                              controller.isSelected.toggle();
                              controller.cardToggle;
                            }),
                          ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  CustomTitleHeadingWidget(
                    text: Strings.revealDetails,
                    style: CustomStyle.darkHeading4TextStyle.copyWith(
                      color:
                          CustomColor.primaryTextColor.withValues(alpha: 0.4),
                    ),
                  ),
                  Obx(() => IconButton(
                        icon: Icon(
                          controller.isRevealedDetails.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CustomColor.whiteColor,
                        ),
                        onPressed: () {
                          controller.isRevealedDetails.value =
                              !controller.isRevealedDetails.value;
                        },
                      )),
                ],
              ),
              verticalSpace(Dimensions.heightSize * 0.5),
            ],
          ),
        ),
      ]),
    );
  }
}
