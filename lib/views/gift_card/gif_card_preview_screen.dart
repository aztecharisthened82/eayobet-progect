import '../../backend/utils/custom_loading_api.dart';
import '../../controller/gift_card/create_gift_card_controller.dart';
import '../../utils/basic_screen_import.dart';
import '../../widgets/appbar/appbar_widget.dart';
import '../../widgets/others/gif_card_preview_widget.dart';

class GifCardPreviewScreen extends StatelessWidget {
  GifCardPreviewScreen({super.key});

  final controller = Get.put(CreateGiftCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(text: Strings.preview),
        body: Obx(
          () => controller.isBuyLoading
              ? CustomLoadingAPI()
              : _bodyWidget(context),
        ));
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.5),
      child: Column(
        children: [
          verticalSpace(Dimensions.marginSizeVertical * 0.5),
          GifCardPreviewInfoWidget(),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 0.5,
      ),
      child: PrimaryButton(
        title: Strings.buyNow,
        onPressed: () {
          controller.createGiftCardApi();
        },
      ),
    );
  }
}
