import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/utils/basic_screen_import.dart';

import '../../language/language_controller.dart';

class PrimaryInputWidget extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
    final bool? readonly;
  final Widget? prefixIcon;
   final Widget? suffixIcon;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? optionalLabel;
  final void Function(String)? onChanged; // Optional onChanged callback

  const PrimaryInputWidget({
    Key? key,
    required this.controller,
    this.readonly,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.prefixIcon,
      this.suffixIcon,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.keyboardInputType,
    this.inputFormatters,
    this.optionalLabel,
    this.onChanged, // Optional parameter
  }) : super(key: key);

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleHeading4Widget(
              text: widget.label,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode
                  ? CustomColor.primaryLightTextColor
                  : CustomColor.primaryDarkTextColor,
            ),
            TitleHeading4Widget(
              text: widget.optionalLabel ?? "",
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize4,
              color: CustomColor.primaryLightColor.withOpacity(0.8),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize * 0.5),
        TextFormField(
          readOnly: widget.readonly ?? false,
          inputFormatters: widget.inputFormatters,
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                    return Get.find<LanguageController>().getTranslation(
                      Strings.pleaseFillOutTheField,
                    );
                  } else {
                    return null;
                  }
                },
          textInputAction: TextInputAction.next,
          controller: widget.controller,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onChanged: widget.onChanged,
          // Execute onChanged if it's passed
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          focusNode: focusNode,
          textAlign: TextAlign.left,
          style: GoogleFonts.inter(
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor
                : CustomColor.secondaryDarkColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          keyboardType: widget.keyboardInputType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintText: Get.find<LanguageController>().getTranslation(
              widget.hint,
            ),
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: CustomColor.grayColor.withOpacity(0.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                color: CustomColor.grayColor.withOpacity(0.6),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.primaryLightTextColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                width: 2,
                color: CustomColor.primaryLightColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.heightSize * 1.7,
              vertical: Dimensions.widthSize,
            ),
          ),
        ),
      ],
    );
  }
}
