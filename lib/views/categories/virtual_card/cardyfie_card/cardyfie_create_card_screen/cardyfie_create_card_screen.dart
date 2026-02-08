import 'package:intl/intl.dart';
import 'package:stripcard/backend/model/virtual_card/cardyfie_model/my_card_model_cardyfie.dart'
    show UserWallet, SupportedCurrency;
import 'package:stripcard/controller/profile/update_profile_controller.dart';
import 'package:stripcard/widgets/inputs/strowallet_fund_keybaord_widget.dart';
import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_info_controller.dart';
import '../../../../../utils/basic_screen_import.dart';
import '../../../../../widgets/appbar/appbar_widget.dart';
import '../../../../../widgets/dropdown/cardyfie_wallet_card_dropdown.dart';
import '../../../../../widgets/inputs/country_picker_input_widget.dart';
import '../../../../../widgets/inputs/image_widget.dart';
import '../../../../../widgets/inputs/input_with_text.dart';
import '../../../../../widgets/inputs/primary_input_filed.dart';
import '../../../../../widgets/inputs/primary_text_input_widget.dart';
import '../../../../../widgets/inputs/strowallet_flipcard.dart';
import '../../../../kyc/kyc_dynamic_image_widget.dart';
import 'widget/selected_image_widget.dart';
part '../cardyfie_create_card_screen/widget/cardyfie_create_customer_widget.dart';
part '../cardyfie_create_card_screen/widget/cardyfie_create_card_widget.dart';
part '../cardyfie_create_card_screen/widget/pending_status.dart';

class CrateCardyfieScreen extends StatelessWidget {
  CrateCardyfieScreen({super.key});

  final controller = Get.put(VirtualCardyfieCardController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text:
            controller
                    .createCardPageInfoModelCardyfie
                    .data
                    .customerExistStatus ==
                false
            ? Strings.createCard
            : Strings.createCardCustomer,
      ),
      body:
          controller.isCreateCardInfoLoading ||
              controller.isLoading ||
              controller.isBuyCardLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context),
    );
    // );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.7),
      children: [
        if (controller
                .createCardPageInfoModelCardyfie
                .data
                .customerExistStatus ==
            false) ...[
          CreateCustomerWidget(),
        ] else ...[
          if (controller
                  .createCardPageInfoModelCardyfie
                  .data
                  .customerExist
                  .status ==
              "APPROVED") ...[
            CardyfieCreateCardWidget(),
          ] else ...[
            CardyfiePendingWidget(),
          ],
        ],
      ],
    );
  }
}
