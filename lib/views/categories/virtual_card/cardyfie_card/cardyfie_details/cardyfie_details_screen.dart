import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../backend/utils/custom_switch_loading_api.dart';
import '../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_details_controller.dart';
import '../../../../../utils/basic_screen_import.dart';
import '../../../../../widgets/appbar/appbar_widget.dart';
import '../../../../../widgets/others/preview/details_row_widget.dart';
import '../../../../../widgets/text_labels/title_heading5_widget.dart';
part '../cardyfie_details/widget/address_widget_cardyfie.dart';
part '../cardyfie_details/widget/details_widget.dart';

class CardyfieDetailsScreen extends StatelessWidget {
  CardyfieDetailsScreen({super.key});
  final controller = Get.put(CardyfieDetailsController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.details),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.9),
      child: Column(
        children: [AddressWidgetCardyfie(), CardyfieDetailsWidget()],
      ),
    );
  }
}
