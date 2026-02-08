import 'package:intl/intl.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../controller/navbar/dashboard_controller.dart';
import 'package:stripcard/utils/basic_screen_import.dart';

import '../../widgets/bottom_navbar/transaction_history_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBar(
          title: TitleHeading1Widget(
            text: Strings.notification,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? CustomColor.whiteColor
                : CustomColor.primaryDarkTextColor,
          ),
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
    var data = dashBoardController.dashBoardModel.data.transactions;
    return data.isNotEmpty
        ? RefreshIndicator(
            color: CustomColor.primaryLightColor,
            onRefresh: () async {
              dashBoardController.getDashboardData();
            },
            child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.marginSizeHorizontal * 0.9,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.marginSizeVertical * 0.5),
                    child: TransactionWidget(
                      amount: data[index].requestAmount,
                      title: data[index].transactionType,
                      dateText: DateFormat.d().format(data[index].dateTime),
                      transaction: data[index].trx,
                      monthText: DateFormat.MMM().format(data[index].dateTime),
                    ),
                  );
                }),
          )
        : Center(
            child: TitleHeading1Widget(
              text: Strings.noRecordFound,
              color: CustomColor.primaryLightColor,
            ),
          );
  }
}
