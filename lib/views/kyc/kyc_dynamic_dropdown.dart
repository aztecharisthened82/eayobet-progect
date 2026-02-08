import 'package:stripcard/utils/basic_screen_import.dart';

class KycDynamicDropDown extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;

  const KycDynamicDropDown({
    required this.itemsList,
    Key? key,
    required this.selectMethod,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: Dimensions.inputBoxHeight * .75,
        decoration: BoxDecoration(
          border: Border.all(
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor.withValues(alpha: 0.2)
                : CustomColor.primaryDarkTextColor.withValues(alpha: 0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        ),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 20),
            child: DropdownButton(
              dropdownColor: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              hint: Padding(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.7),
                child: Text(
                  selectMethod.value,
                  style: CustomStyle.darkHeading4TextStyle.copyWith(
                    color: Get.isDarkMode
                        ? CustomColor.primaryLightTextColor
                        : CustomColor.secondaryDarkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Get.isDarkMode
                      ? CustomColor.primaryLightTextColor
                      : CustomColor.secondaryDarkColor,
                ),
              ),
              isExpanded: true,
              underline: Container(),
              borderRadius: BorderRadius.circular(Dimensions.radius),
              items: itemsList.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TitleHeading4Widget(text: value.toString()),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
