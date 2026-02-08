import '../backend/utils/custom_snackbar.dart';
import '../controller/categories/virtual_card/stripe_card/stripe_two_controller.dart';
import '../controller/navbar/navbar_controller.dart';
import '../model/categories_model.dart';
import '../utils/basic_screen_import.dart';

final stripeCardController = Get.put(StripeTwoController());
final controller = Get.put(NavbarController());

List<CategoriesModel> categoriesStripeData = [
  CategoriesModel(Assets.icon.detailsCard, Strings.details, () {
    stripeCardController.getStripeCardData();
    if (stripeCardController.stripeCardModel.data.myCard.isNotEmpty) {
      Get.toNamed(Routes.stripeCardDetailsScreen);



    } else {
      CustomSnackBar.error(Strings.youDonNotBuyCard);
    }
  }),
  CategoriesModel(Assets.icon.transactionCard, Strings.transactions, () {
    stripeCardController.getStripeCardData();
    if (stripeCardController.stripeCardModel.data.myCard.isNotEmpty) {
      Get.toNamed(Routes.stripeTransactionHistoryScreen);
    } else {
      CustomSnackBar.error(
        Strings.youDonNotBuyCard,
      );
    }
  }),
];
