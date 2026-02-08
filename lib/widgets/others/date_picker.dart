import 'package:stripcard/utils/basic_widget_import.dart';

import '../../language/strings.dart';

class CustomDatePicker extends StatefulWidget {
  final RxString selectedDate; // Observable date string
  final bool showBorder;

  final String label;
  final String subtitle;
  final Decoration? decoration;
  final Color? labelColor;
  final double? inputBoxHeight;
  final Color? calendarIconColor;
  final Widget? leading;
  final EdgeInsets? fieldPadding;
  final double? labelFontSize;
  final double? hintFontSize;
  final Widget? labelSpacing;

  const CustomDatePicker({
    required this.selectedDate,
    this.label = '',
    this.subtitle = '',
    this.decoration,
    this.labelColor,
    this.inputBoxHeight,
    this.calendarIconColor,
    this.leading,
    this.fieldPadding,
    Key? key,
    this.labelFontSize,
    this.hintFontSize,
    this.labelSpacing,
    required this.showBorder,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with SingleTickerProviderStateMixin {
  bool isDatePickerOpened = false;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: CustomColor.whiteColor,
            colorScheme: ColorScheme.light(
              primary: CustomColor.primaryLightColor,
              onPrimary: Colors.white,
              surface: CustomColor.whiteColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    CustomColor.primaryLightColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        widget.selectedDate.value = _formatDate(pickedDate);
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Widget _buildDatePickerButton(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty)
            Column(
              children: [
                TitleHeading4Widget(
                    text: widget.label,
                    fontSize: widget.labelFontSize ??
                        Dimensions.headingTextSize3 * 0.9,
                    color: Color(0xfff1D1D1D)),
                widget.labelSpacing ??
                    verticalSpace(Dimensions.marginSizeVertical),
              ],
            ),
          Container(
            height: widget.inputBoxHeight ?? Dimensions.inputBoxHeight * 0.75,
            decoration: widget.decoration ??
                BoxDecoration(
                  color: Get.isDarkMode
                      ? CustomColor.primaryLightScaffoldBackgroundColor
                      : CustomColor.whiteColor,
                  border: widget.showBorder == true
                      ? Border.all(
                          color: isDatePickerOpened
                              ? CustomColor.primaryLightColor
                              : Colors.grey,
                          width: isDatePickerOpened ? 2 : 1,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                ),
            child: Padding(
              padding: widget.fieldPadding ??
                  const EdgeInsets.only(left: 5, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.leading != null) widget.leading!,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.leading == null
                                  ? Dimensions.paddingSize * 0.4
                                  : Dimensions.paddingSize * 0.4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TitleHeading4Widget(
                                  text: widget.selectedDate.value.isEmpty
                                      ? Strings.dateOfBirth
                                      : widget.selectedDate.value,
                                  fontSize: widget.hintFontSize ??
                                      Dimensions.headingTextSize3,
                                ),
                                if (widget.subtitle != '')
                                  TitleHeading4Widget(
                                    text: widget.subtitle,
                                    fontSize: Dimensions.headingTextSize3 * 0.9,
                                    fontWeight: FontWeight.w400,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: widget.calendarIconColor ??
                        (isDatePickerOpened
                            ? CustomColor.primaryLightColor
                            : Colors.grey),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePickerButton(context);
  }
}
