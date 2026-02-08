part of "../cardyfie_create_card_screen.dart";

class CardyfiePendingWidget extends StatelessWidget {
  const CardyfiePendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 1.2),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            crossAxisAlignment: crossStart,
            children: [
              // Icon Circle
              Container(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.6),
                decoration: BoxDecoration(
                  color: CustomColor.primaryLightColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info,
                  size: 20,
                  color: CustomColor.whiteColor,
                ),
              ),
              horizontalSpace(Dimensions.marginSizeHorizontal),

              // Status Text
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "Status of the customer you created: ",
                    style: TextStyle(
                      fontSize: Dimensions.headingTextSize5,
                      color: CustomColor.primaryDarkTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "PENDING",
                        style: TextStyle(
                          color: CustomColor.yellowColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(Dimensions.marginSizeVertical),

          Text(
            "Please wait until your customer status is APPROVED. Once it is APPROVED, you can continue with the card creation.",
            style: TextStyle(
              fontSize: Dimensions.headingTextSize6,
              fontWeight: FontWeight.w500,
              color: CustomColor.primaryDarkTextColor,
            ),
          ),

          verticalSpace(Dimensions.marginSizeVertical * 1.5),

          Center(
            child: PrimaryButton(
              title: Strings.updateCustomer,
              onPressed: () {
                Get.toNamed(Routes.cardyfieUpdateCustomerScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
