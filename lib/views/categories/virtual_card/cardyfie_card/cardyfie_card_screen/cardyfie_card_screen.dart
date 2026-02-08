import 'package:carousel_slider/carousel_slider.dart';
import 'package:stripcard/views/categories/virtual_card/strowallet_card/card_widget.dart';
import '../../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_info_controller.dart';
import '../../../../../../controller/navbar/dashboard_controller.dart';
import '../../../../../../widgets/text_labels/title_heading5_widget.dart';
import '../../../../../../utils/basic_screen_import.dart';
import '../../../../../../widgets/bottom_navbar/categorie_widget.dart';
import '../../../../../backend/utils/custom_snackbar.dart';
part '../cardyfie_card_screen/widget/cardyfie_card_slider.dart';
part '../cardyfie_card_screen/widget/cardyfie_category_widget.dart';

class CardyfieCardScreen extends StatelessWidget {
  const CardyfieCardScreen({super.key, required this.controller});
  final VirtualCardyfieCardController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return _cardyfieCardWidget(context);
  }

  _cardyfieCardWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
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
            vertical: Dimensions.paddingSize * 0.4,
          ),
          child: Column(
            mainAxisAlignment: mainCenter,
            mainAxisSize: mainMin,
            children: [CardyfieCardSlider(), CardyfieCategoryWidget()],
          ),
        ),
        if (controller.cardyfieCardModel.data.cardCreateAction) ...[
          _buttonWidget(context),
        ],
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 2,
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      child: PrimaryButton(
        title: Strings.createANewCard,
        onPressed: () {
          Get.toNamed(Routes.crateCardyfieScreen);
        },
      ),
    );
  }
}
