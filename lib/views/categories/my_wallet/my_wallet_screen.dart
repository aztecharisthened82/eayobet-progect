import 'package:stripcard/utils/basic_screen_import.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/navbar/dashboard_controller.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({super.key});

  final dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBar(
          title: TitleHeading1Widget(
              text: Strings.myWallet,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? CustomColor.whiteColor
                  : CustomColor.primaryDarkTextColor),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Get.isDarkMode
              ? CustomColor.primaryDarkScaffoldBackgroundColor
              : CustomColor.bgLightColor,
          leading: Container(),
        ),
        body: Obx(
          () => dashBoardController.isLoading
              ? CustomLoadingAPI(
                  color: CustomColor.primaryLightColor,
                )
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
            dashBoardController.getDashboardData();
          },
          child: ListView(
            children: [
              verticalSpace(Dimensions.marginSizeVertical * 0.6),
              _appBarContainer(context),
              _buttonWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  _appBarContainer(BuildContext context) {
    var data = dashBoardController.dashBoardModel.data;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.5,
          vertical: Dimensions.marginSizeVertical * 0.3),
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
          color: CustomColor.primaryBGLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8)),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          CustomTitleHeadingWidget(
            text: data.userWallet.isNotEmpty
                ? "${data.userWallet[0].balance.toStringAsFixed(dashBoardController.precision.value)} ${data.userWallet[0].currency.code}"
                : '',
            style: CustomStyle.darkHeading1TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize4 * 2,
              fontWeight: FontWeight.w800,
              color: CustomColor.whiteColor,
            ),
          ),
          CustomTitleHeadingWidget(
            text: Strings.currentBalance,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.whiteColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    final data = dashBoardController.dashBoardModel.data.moduleAccess;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.5,
          vertical: Dimensions.marginSizeVertical * 0.9),
      child: Row(mainAxisAlignment: mainSpaceBet, children: [
        data.addMoney == true
            ? Expanded(
                child: PrimaryButton(
                  height: Dimensions.buttonHeight * 0.9,
                  title: Strings.deposit,
                  onPressed: () {
                    Get.toNamed(Routes.depositScreen);
                  },
                ),
              )
            : Container(),
        horizontalSpace(Dimensions.widthSize),
        data.withdrawMoney == true
            ? Expanded(
                child: PrimaryButton(
                  height: Dimensions.buttonHeight * 0.9,
                  // borderColor: CustomColor.primaryLightColor,
                  borderWidth: 2,
                  title: Strings.withdraw,
                  buttonColor: CustomColor.primaryLightScaffoldBackgroundColor,
                  onPressed: () {
                    Get.toNamed(Routes.moneyOutScreen);
                  },
                ),
              )
            : Container(),
      ]),
    );
  }
}
