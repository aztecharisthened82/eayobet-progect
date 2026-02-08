import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/views/categories/virtual_card/cardyfie_card/model/my_card_model_cardyfie.dart';
import 'package:stripcard/widgets/dropdown/cardyfie_wallet_card_dropdown.dart';
import '../../../../../backend/model/virtual_card/cardyfie_model/my_card_model_cardyfie.dart';
import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../backend/utils/custom_snackbar.dart';

import '../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_info_controller.dart';
import '../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_withdraw_controller.dart';
import '../../../../../controller/remaing_balance/remaing_balance_controller.dart';

import '../../../../../utils/basic_screen_import.dart';
import '../../../../../widgets/appbar/appbar_widget.dart';
import '../../../../../widgets/text_labels/title_heading5_widget.dart';
part '../cardyfie_withdraw/widget/cardyfire_withdraw_keyboard_widget.dart';

class CardyfieWithdrawScreen extends StatelessWidget {
  CardyfieWithdrawScreen({super.key});
  final controller = Get.put(VirtualCardyfieCardController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.withdraw),

        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [CardyfieWithdrawFundWidget(buttonText: Strings.withdraw)],
    );
  }
}
