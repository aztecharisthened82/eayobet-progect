

import 'package:intl/intl.dart';

import '../../../../backend/model/virtual_card/strowallet_models/strowallet_webhook_model.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/categories/virtual_card/strowallet_card/strowallet_webhook_controller.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/appbar/appbar_widget.dart';
import '../../../../widgets/others/expanded_transaction.dart';
import '../../../../widgets/others/webhook_transaction_widget.dart';

class WebhookLogsScreen extends StatelessWidget {
  WebhookLogsScreen({super.key});
  final controller = Get.put(StrowalletWebhookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: Strings.webhookLogs,
      ),
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _mainListWidget(int i, List<Transaction> data, BuildContext context) {
    RxBool isExpansion = false.obs;
    return GestureDetector(
      onTap: () {
        isExpansion.value = !isExpansion.value;
      },
      child: Column(
        children: [
          TransactionWebWidget(
            status: data[i].status,
            amount: data[i].amount,
            payableAmount: data[i].amount,
            title: data[i].event,
            transaction: data[i].transitionId,
          ),
          Obx(() => Visibility(
                visible: isExpansion.value,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.paddingSize * .6),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryLightColor.withValues(alpha:0.9),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: Column(
                    children: [
                      ExpendedItemWidget(
                        title: Strings.transactionId.tr,
                        value: data[i].transitionId,
                      ),
                      ExpendedItemWidget(
                        title: Strings.cardId.tr,
                        value: data[i].cardId,
                      ),
                      ExpendedItemWidget(
                        title: Strings.reference.tr,
                        value: data[i].reference,
                      ),
                      if (data[i].eventType ==
                              'virtualcard.transaction.declined' ||
                          data[i].eventType ==
                              'virtualcard.transaction.crossborder') ...[
                        ExpendedItemWidget(
                          title: Strings.narration.tr,
                          value: data[i].narrative!,
                        ),
                      ],
                      if (data[i].eventType ==
                          'virtualcard.transaction.declined') ...[
                        ExpendedItemWidget(
                          title: Strings.reason.tr,
                          value: data[i].reason!,
                        ),
                      ],
                      ExpendedItemWidget(
                        title: Strings.status.tr,
                        value: data[i].status,
                      ),
                      if (data[i].eventType ==
                          'virtualcard.transaction.crossborder') ...[
                        ExpendedItemWidget(
                          title: Strings.chargedAmount.tr,
                          value: data[i].chargeAmount!,
                        ),
                      ],
                      if (data[i].eventType ==
                          'virtualcard.transaction.declined.terminated') ...[
                        ExpendedItemWidget(
                          title: Strings.balanceBeforeTermination.tr,
                          value: data[i].balanceBeforeTermination!,
                        ),
                      ],


                      if (data[i].eventType ==
                              'virtualcard.transaction.declined' ||
                          data[i].eventType ==
                              'virtualcard.transaction.crossborder') ...[
                        ExpendedItemWidget(
                          title: Strings.timeAndDate.tr,
                          value: DateFormat("d-M-yy hh:mm:ss a").format(
                              DateTime.parse(data[i]
                                  .createdAt!) // Parse the string to DateTime
                              ),
                        ),

                        
                      ]
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.webhookLogModel.data.transactions;
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.heightSize * 1.5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.78,
                child: data.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSize * .3,
                        ),
                        separatorBuilder: (_, index) => verticalSpace(4),
                        itemCount: data.length,
                        itemBuilder: (_, i) {
                          return _mainListWidget(i, data, context);
                        },
                      )
                    : Center(
                        child: TitleHeading1Widget(
                          textAlign: TextAlign.center,
                          text: Strings.noRecordFound,
                          color: CustomColor.primaryLightColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
