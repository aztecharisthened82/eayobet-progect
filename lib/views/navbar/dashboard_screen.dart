import '../../backend/model/dashboard/dashboard_model.dart';
import '../../controller/categories/virtual_card/cardyfie_card/cardyfie_info_controller.dart';
import '../../controller/categories/virtual_card/stripe_card/stripe_two_controller.dart';
import '../../controller/navbar/navbar_controller.dart';
import '../../widgets/bottom_navbar/card_widget.dart';
import '../../widgets/bottom_navbar/cardyfie_card_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '/backend/utils/custom_loading_api.dart';
import '/controller/categories/virtual_card/flutter_wave/flutterwave_card_controller.dart';
import '/utils/basic_screen_import.dart';
import '/views/categories/virtual_card/sudo_virtual_card/sudo_add_fund_screen.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../controller/categories/virtual_card/strowallet_card/strowallelt_info_controller.dart';
import '../../controller/categories/virtual_card/sudo_card/sudo_my_card_controller.dart';
import '../../controller/navbar/dashboard_controller.dart';
import '../../controller/navbar/usefull_link_controller.dart';
import '../../data/categories_stripe_data.dart';
import '../../data/flutter_wave_data.dart';
import '../../widgets/bottom_navbar/categorie_widget.dart';
import '../../widgets/bottom_navbar/flutter_card.dart';
import '../../widgets/bottom_navbar/stripe_slider_card.dart';
import '../../widgets/bottom_navbar/sudo_slider_card.dart';
import '../../widgets/bottom_navbar/transaction_history_widget.dart';
import 'package:intl/intl.dart';
import '../categories/virtual_card/strowallet_card/strowallet_slider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final dashBoardController = Get.put(DashBoardController());
  final myCardController = Get.put(StripeTwoController());
  final stripTwoController = Get.put(StripeTwoController());
  final sudoCardController = Get.put(VirtualSudoCardController());
  final flutterWaveCardController = Get.put(FlutterWaveCardController());
  final cardyfieCardController = Get.put(VirtualCardyfieCardController());
  final useFullLinkController = Get.put(UseFullLinkController());
  final strowalletCardController = Get.put(VirtualStrowalletCardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Get.isDarkMode
            ? CustomColor.blackColor
            : CustomColor.bgLightColor,
        body: Obx(
          () => dashBoardController.isLoading
              ? CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          color: CustomColor.primaryLightColor,
          onRefresh: () async {
            dashBoardController.getDashboardData().then((value) {
              if (dashBoardController.dashBoardModel.data.activeVirtualSystem ==
                  'flutterwave') {
                flutterWaveCardController.getCardData();
              } else if (dashBoardController
                      .dashBoardModel
                      .data
                      .activeVirtualSystem ==
                  'sudo') {
                sudoCardController.getCardData();
              } else if (dashBoardController
                      .dashBoardModel
                      .data
                      .activeVirtualSystem ==
                  'strowallet') {
                strowalletCardController.getStrowalletCardData();
              } else if (dashBoardController
                      .dashBoardModel
                      .data
                      .activeVirtualSystem ==
                  'cardyfie') {
                cardyfieCardController.getCardyfieCardData();
              } else {
                stripeCardController.getStripeCardData();
              }
            });
          },
          child: ListView(
            children: [
              _appBarContainer(context),
              dashBoardController
                          .dashBoardModel
                          .data
                          .moduleAccess
                          .virtualCard ==
                      true
                  ? dashBoardController
                                .dashBoardModel
                                .data
                                .activeVirtualSystem ==
                            'sudo'
                        ? sudoCardController.isLoading
                              ? CustomLoadingAPI(color: CustomColor.transparent)
                              : _cardSudoWidget(context)
                        : dashBoardController
                                  .dashBoardModel
                                  .data
                                  .activeVirtualSystem ==
                              'stripe'
                        ? myCardController.isLoading
                              ? CustomLoadingAPI(color: CustomColor.transparent)
                              : _stripeCardWidget(context)
                        : dashBoardController
                                  .dashBoardModel
                                  .data
                                  .activeVirtualSystem ==
                              'cardyfie'
                        ? cardyfieCardController.isLoading ||
                                  cardyfieCardController.isCreateCardInfoLoading
                              ? CustomLoadingAPI(color: CustomColor.transparent)
                              : CardyfieCardWidget()
                        : dashBoardController
                                  .dashBoardModel
                                  .data
                                  .activeVirtualSystem ==
                              'flutterwave'
                        ? flutterWaveCardController.isLoading
                              ? CustomLoadingAPI(color: CustomColor.transparent)
                              : flutterWaveCardController
                                    .myCardModel
                                    .data
                                    .myCards
                                    .isNotEmpty
                              ? _cardWidget(context)
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.marginSizeHorizontal,
                                  ),
                                  child: CardWidget(
                                    cardNumber: 'xxxx xxxx xxxx xxxx',
                                    expiryDate: 'xx/xx',
                                    balance: 'xx',
                                    validAt: 'xx',
                                    cvv: 'xxx',
                                    logo: Assets.logo.appLauncher.path,
                                    isNetworkImage: false,
                                  ),
                                )
                        : strowalletCardController.isLoading
                        ? CustomLoadingAPI(color: CustomColor.transparent)
                        : _strowalletCardWidget(context)
                  : Container(),
            ],
          ),
        ),
        _draggableSheet(context),
      ],
    );
  }

  _draggableSheet(BuildContext context) {
    var data = dashBoardController.dashBoardModel.data.transactions;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Visibility(
      visible: data.isNotEmpty,
      child: DraggableScrollableSheet(
        builder: (_, scrollController) {
          return _transactionWidget(context, scrollController);
        },
        initialChildSize: 0.30,
        minChildSize: 0.30,
        maxChildSize: 1,
      ),
    );
  }

  _appBarContainer(BuildContext context) {
    var data = dashBoardController.dashBoardModel.data;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.5,
      ),
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.5,
        right: Dimensions.marginSizeHorizontal * 0.5,
        top: Dimensions.marginSizeVertical * 0.4,
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? CustomColor.primaryLightScaffoldBackgroundColor
            : CustomColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 2)),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading4Widget(
            text: Strings.currentBalance,
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor
                : CustomColor.grayColor,
          ),
          verticalSpace(Dimensions.marginSizeVertical * 0.2),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.marginSizeVertical * 0.2,
                  horizontal: Dimensions.paddingSize * 0.4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2),
                  color: Get.isDarkMode
                      ? CustomColor.grayColor.withAlpha(77)
                      : CustomColor.bgLightColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                      padding: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkScaffoldBackgroundColor
                            : CustomColor.primaryLightColor,
                      ),
                      child: Icon(
                        Icons.power_settings_new,
                        size: Dimensions.iconSizeSmall * 1.5,
                        color: Get.isDarkMode
                            ? CustomColor.primaryLightTextColor
                            : CustomColor.whiteColor,
                      ),
                    ),
                    TitleHeading4Widget(
                      fontWeight: FontWeight.bold,
                      text: data.userWallet.isNotEmpty
                          ? "${data.userWallet[0].balance.toStringAsFixed(dashBoardController.precision.value)}"
                          : "",
                      color: Get.isDarkMode
                          ? CustomColor.primaryLightTextColor
                          : CustomColor.grayColor,
                    ),
                    TitleHeading4Widget(
                      padding: EdgeInsets.only(
                        left: Dimensions.paddingSize * 0.2,
                      ),
                      fontWeight: FontWeight.bold,
                      text: '${data.userWallet[0].currency.code}',
                      color: CustomColor.primaryLightColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.depositScreen);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: Dimensions.marginSizeHorizontal * 1.5,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.marginSizeVertical * 0.2,
                      horizontal: Dimensions.marginSizeHorizontal * 0.5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 2,
                      ),
                      color: Get.isDarkMode
                          ? CustomColor.grayColor.withAlpha(77)
                          : CustomColor.primaryLightColor,
                    ),
                    child: TitleHeading4Widget(
                      text: Strings.addMoney,
                      fontSize: Dimensions.headingTextSize4,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode
                          ? CustomColor.primaryLightTextColor
                          : CustomColor.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(Dimensions.marginSizeVertical * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: crossStart,
                children: [
                  Row(
                    children: [
                      CustomTitleHeadingWidget(
                        text: '${dashBoardController.totalAddMoney.value}',
                        style: CustomStyle.darkHeading1TextStyle.copyWith(
                          fontSize: Dimensions.headingTextSize4,
                          fontWeight: FontWeight.w800,
                          color: Get.isDarkMode
                              ? CustomColor.primaryLightTextColor
                              : CustomColor.grayColor,
                        ),
                      ),
                    ],
                  ),
                  CustomTitleHeadingWidget(
                    text: Strings.totalDeposit,
                    style: CustomStyle.lightHeading4TextStyle.copyWith(
                      fontSize: Dimensions.headingTextSize5,
                      color: Get.isDarkMode
                          ? CustomColor.primaryLightTextColor
                          : CustomColor.grayColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CustomTitleHeadingWidget(
                        text: "${dashBoardController.totalTransactions.value}",
                        style: CustomStyle.darkHeading1TextStyle.copyWith(
                          fontSize: Dimensions.headingTextSize5,
                          fontWeight: FontWeight.w800,
                          color: Get.isDarkMode
                              ? CustomColor.primaryLightTextColor
                              : CustomColor.grayColor,
                        ),
                      ),
                    ],
                  ),
                  CustomTitleHeadingWidget(
                    text: Strings.transactionAmount,
                    style: CustomStyle.lightHeading4TextStyle.copyWith(
                      fontSize: Dimensions.headingTextSize5,
                      color: Get.isDarkMode
                          ? CustomColor.primaryLightTextColor
                          : CustomColor.grayColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///>>>flutter widget

  _cardWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: flutterWaveCardController.myCardModel.data.myCards.isNotEmpty,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
          color: CustomColor.primaryLightColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.8,
          vertical: Dimensions.marginSizeVertical * 0.4,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * 0.4,
          vertical: Dimensions.paddingSize * 0.2,
        ),
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            _cardRowWidget(context),
            FlutterWaveSlider(),
            _cardCategories(context),
          ],
        ),
      ),
    );
  }

  _transactionWidget(BuildContext context, ScrollController scrollController) {
    var data = dashBoardController.dashBoardModel.data.transactions;
    final screenWidth = MediaQuery.of(context).size.width;
    return data.isEmpty
        ? Container()
        : Container(
            color: Get.isDarkMode
                ? CustomColor.primaryDarkScaffoldBackgroundColor
                : CustomColor.bgLightColor,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize * 0.8,
              ),
              physics: NeverScrollableScrollPhysics(),
              children: [
                verticalSpace(Dimensions.heightSize),
                CustomTitleHeadingWidget(
                  text: Strings.recentTransaction,
                  style: Get.isDarkMode
                      ? CustomStyle.lightHeading3TextStyle.copyWith(
                          fontSize: screenWidth >= 600
                              ? Dimensions.headingTextSize4
                              : Dimensions.headingTextSize2,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.primaryLightTextColor,
                        )
                      : CustomStyle.darkHeading3TextStyle.copyWith(
                          fontSize: screenWidth >= 600
                              ? Dimensions.headingTextSize4
                              : Dimensions.headingTextSize2,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.grayColor,
                        ),
                ),
                verticalSpace(Dimensions.widthSize),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TransactionWidget(
                        amount: data[index].requestAmount,
                        title: data[index].transactionType,
                        dateText: DateFormat.d().format(data[index].dateTime),
                        transaction: data[index].trx,
                        monthText: DateFormat.MMM().format(
                          data[index].dateTime,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  _cardRowWidget(BuildContext context) {
    final controller = Get.put(NavbarController());
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.marginSizeVertical * 0.3,
        top: Dimensions.marginSizeVertical * 0.2,
      ),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          TitleHeading3Widget(
            text: Strings.myCard.tr,
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor
                : CustomColor.grayColor,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: () {
              controller.selectedIndex.value = 3;
            },
            child: TitleHeading5Widget(
              color: Get.isDarkMode
                  ? CustomColor.primaryLightTextColor
                  : CustomColor.grayColor,
              text: Strings.viewMore.tr,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _cardCategories(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.3),
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      children: List.generate(
        flutterCategoriesData.length,
        (index) => CategoriesWidget(
          onTap: flutterCategoriesData[index].onTap,
          icon: flutterCategoriesData[index].icon,
          text: flutterCategoriesData[index].text,
          color: CustomColor.whiteColor,
        ),
      ),
    );
  }

  _stripeCardCategories(BuildContext context) {
    return Visibility(
      visible: myCardController.stripeCardModel.data.myCard.isNotEmpty,
      child: GridView.count(
        padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.3),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(
          categoriesStripeData.length,
          (index) => CategoriesWidget(
            onTap: categoriesStripeData[index].onTap,
            icon: categoriesStripeData[index].icon,
            text: categoriesStripeData[index].text,
            color: CustomColor.whiteColor,
          ),
        ),
      ),
    );
  }

  ///>>>>>>stripe card
  _stripeCardWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        color: Get.isDarkMode
            ? CustomColor.primaryLightScaffoldBackgroundColor
            : CustomColor.whiteColor,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.8,
        vertical: Dimensions.paddingSize * 0.2,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        mainAxisSize: mainMin,
        children: [
          _cardRowWidget(context),
          DashboardSlider(),
          _stripeCardCategories(context),
        ],
      ),
    );
  }

  ///>>> sudo widget
  _cardSudoWidget(BuildContext context) {
    final data = sudoCardController.sudoMyCardModel.data.myCard;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        color: Get.isDarkMode
            ? CustomColor.primaryLightScaffoldBackgroundColor
            : CustomColor.whiteColor,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
        vertical: Dimensions.marginSizeVertical * 0.4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.8,
        vertical: Dimensions.paddingSize * 0.4,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          _cardRowWidget(context),
          SudoDashboardSlider(),
          Visibility(
            visible: sudoCardController.sudoMyCardModel.data.myCard.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(
                bottom: Dimensions.marginSizeVertical * 0.4,
                top: Dimensions.marginSizeVertical * 0.2,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoriesWidget(
                      icon: Assets.icon.details,
                      text: Strings.details,
                      onTap: () {
                        if (sudoCardController
                            .sudoMyCardModel
                            .data
                            .myCard
                            .isNotEmpty) {
                          Get.toNamed(Routes.sudoCardDetailsScreen);
                        } else {
                          CustomSnackBar.error(Strings.youDonNotBuyCard);
                        }
                        ;
                      },
                      color: CustomColor.whiteColor,
                    ),
                    Obx(
                      () => sudoCardController.isDefaultLoading
                          ? CustomLoadingAPI(
                              color: CustomColor.primaryLightColor,
                            )
                          : CategoriesWidget(
                              icon: Assets.icon.torch,
                              text:
                                  data[dashBoardController.current.value]
                                          .isDefault ==
                                      true
                                  ? Strings.removeDefault
                                  : Strings.makeDefault,
                              onTap: () {
                                sudoCardController.defaultProcess();
                              },
                              color: CustomColor.whiteColor,
                            ),
                    ),
                    CategoriesWidget(
                      icon: Assets.icon.fundCard,
                      text: Strings.addFund,
                      onTap: () {
                        if (sudoCardController
                            .sudoMyCardModel
                            .data
                            .myCard
                            .isNotEmpty) {
                          Get.to(
                            () =>
                                SudoAddFundScreen(appBarTitle: Strings.addFund),
                          );
                        } else {
                          CustomSnackBar.error(Strings.youDonNotBuyCard);
                        }
                      },
                      color: CustomColor.whiteColor,
                    ),
                    CategoriesWidget(
                      icon: Assets.icon.transactionCard,
                      text: Strings.transactions,
                      onTap: () {
                        if (sudoCardController
                            .sudoMyCardModel
                            .data
                            .myCard
                            .isNotEmpty) {
                          Get.toNamed(Routes.sudoTransactionHistoryScreen);
                        } else {
                          CustomSnackBar.error(Strings.youDonNotBuyCard);
                        }
                      },
                      color: CustomColor.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _strowalletCardWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        color: Get.isDarkMode
            ? CustomColor.primaryLightScaffoldBackgroundColor
            : CustomColor.whiteColor,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
        vertical: Dimensions.marginSizeVertical * 0.4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.5,
        vertical: Dimensions.paddingSize * 0.4,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        mainAxisSize: mainMin,
        children: [StrowalletSlider(), _strowalletCardCategoryWidget(context)],
      ),
    );
  }

  _strowalletCardCategoryWidget(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(VirtualStrowalletCardController());
    return Visibility(
      visible: controller.strowalletCardModel.data.myCards.isNotEmpty,
      child: GridView.count(
        padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.3),
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        crossAxisCount: 4,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: screenWidth >= 600 ? 1.5 : 0.8,
        shrinkWrap: true,
        children: [
          CategoriesWidget(
            icon: Assets.icon.details,
            text: Strings.details,
            color: CustomColor.whiteColor,
            onTap: () {
              controller.getStrowalletCardData();
              if (controller.strowalletCardModel.data.myCards.isNotEmpty) {
                Get.toNamed(Routes.strowalletCardDetailsScreen);
              } else {
                CustomSnackBar.error(Strings.youDonNotBuyCard);
              }
            },
          ),
          CategoriesWidget(
            icon: Assets.icon.fundCard,
            text: Strings.fund,
            color: CustomColor.whiteColor,
            onTap: () {
              controller.getStrowalletCardData();
              if (controller.strowalletCardModel.data.myCards.isNotEmpty) {
                Get.toNamed(Routes.strowalletAddFundScreen);
              } else {
                CustomSnackBar.error(Strings.youDonNotBuyCard);
              }
            },
          ),
          Obx(
            () => controller.isMakeDefaultLoading
                ? const CustomLoadingAPI()
                : CategoriesWidget(
                    icon: Assets.icon.torch,
                    color: CustomColor.whiteColor,
                    text:
                        controller
                            .strowalletCardModel
                            .data
                            .myCards[controller
                                .dashboardController
                                .current
                                .value]
                            .isDefault
                        ? Strings.removeDefault
                        : Strings.makeDefault,
                    onTap: () {
                      controller.makeCardDefaultProcess(
                        controller
                            .strowalletCardModel
                            .data
                            .myCards[controller
                                .dashboardController
                                .current
                                .value]
                            .cardId,
                      );
                    },
                  ),
          ),
          CategoriesWidget(
            icon: Assets.icon.transactionsLog,
            text: Strings.transactions,
            color: CustomColor.whiteColor,
            onTap: () {
              controller.getStrowalletCardData();
              if (controller.strowalletCardModel.data.myCards.isNotEmpty) {
                Get.toNamed(Routes.strowalletTransactionHistoryScreen);
              } else {
                CustomSnackBar.error(Strings.youDonNotBuyCard);
              }
            },
          ),
        ],
      ),
    );
  }
}
