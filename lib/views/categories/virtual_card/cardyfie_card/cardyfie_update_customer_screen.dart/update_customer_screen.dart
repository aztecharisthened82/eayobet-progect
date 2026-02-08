import 'package:intl/intl.dart';
import 'package:stripcard/views/categories/virtual_card/cardyfie_card/cardyfie_update_customer_screen.dart/widget/update_image.dart';
import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/categories/virtual_card/cardyfie_card/cardyfie_update_customer_controller.dart';
import '../../../../../controller/profile/update_profile_controller.dart';
import '../../../../../utils/basic_screen_import.dart';
import '../../../../../widgets/appbar/appbar_widget.dart';
import '../../../../../widgets/identity_type_dropdown.dart';
import '../../../../../widgets/inputs/country_picker_input_widget.dart';
import '../../../../../widgets/inputs/image_widget.dart';
import '../../../../../widgets/inputs/primary_input_filed.dart';
import '../../../../../widgets/dropdown/cardyfie_wallet_card_dropdown.dart';

class UpdateCustomerScreen extends StatelessWidget {
  UpdateCustomerScreen({Key? key}) : super(key: key);
  final controller = Get.put(UpdateCustomerCardyfieController());
  final profileController = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: Strings.updateCustomer),
      body: Obx(
        () => controller.isCreateCardInfoLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.7),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: crossStart,
          children: [_inputWidget(context), _buttonWidget(context)],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        verticalSpace(Dimensions.heightSize),
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.firstNameController,
                hint: Strings.firstName,
                label: Strings.firstName,
              ),
            ),

            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.lastNameController,
                hint: Strings.lastName,
                label: Strings.lastName,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize),
        PrimaryInputWidget(
          readonly: true,
          controller: controller.emailController,
          hint: Strings.emailAddress,
          label: Strings.emailAddress,
        ),
        verticalSpace(Dimensions.heightSize),

        PrimaryInputWidget(
          controller: controller.identifyNumberController,
          hint: Strings.identity,
          label: Strings.identity,
          keyboardInputType: TextInputType.number,
        ),
        verticalSpace(Dimensions.heightSize),
        PrimaryInputWidget(
          controller: controller.houseNumberController,
          hint: Strings.houseNumber,
          label: Strings.houseNumber,
          keyboardInputType: TextInputType.number,
        ),
        verticalSpace(Dimensions.heightSize),
        CustomTitleHeadingWidget(
          text: Strings.country,
          style: CustomStyle.darkHeading4TextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: Get.isDarkMode
                ? CustomColor.primaryLightTextColor
                : CustomColor.primaryDarkTextColor,
          ),
        ),
        verticalSpace(Dimensions.heightSize),
        CountryDropDown(
          selectMethod: controller.selectedCountry,
          itemsList: profileController.userProfileModel.data.countries,
          onChanged: (value) {
            controller.selectedCountry.value = value!.name;
            controller.countryISO2.value = value.iso2;
            print(controller.selectedCountry.value);
          },
        ),
        verticalSpace(Dimensions.heightSize),

        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.cityController,
                hint: Strings.city,
                label: Strings.city,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.stateController,
                hint: Strings.state,
                label: Strings.state,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize),
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.addressController,
                hint: Strings.address,
                label: Strings.address,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.zipcodeController,
                hint: Strings.zipCode,
                label: Strings.zipCode,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize),

        //date of birth
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final DateFormat formatter = DateFormat('MM/dd/yyyy');
              final String formattedDate = formatter.format(pickedDate);

              controller.dateOfBirthController.text = formattedDate;
            }

            print(controller.dateOfBirthController.text);
          },
          child: AbsorbPointer(
            child: PrimaryInputWidget(
              controller: controller.dateOfBirthController,
              optionalLabel: Strings.shouldMatchYourID,
              label: Strings.dateOfBirth,
              hint: Strings.dateOfBirth,
              suffixIcon: Icon(
                size: Dimensions.iconSizeDefault * 0.8,
                Icons.calendar_today,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
              isValidator: true,
            ),
          ),
        ),
        verticalSpace(Dimensions.heightSize),
        //dropdown select type
        //dropdown select type
        CustomDropDown<StringDropdownModel>(
          dropDownColor: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.whiteColor,
          titleTextColor: Get.isDarkMode
              ? CustomColor.whiteColor
              : CustomColor.blackColor,
          dropDownHeight: Dimensions.inputBoxHeight * 0.75,
          title: Strings.identityType,
          hint: controller.selectTypeName.value,
          items: controller.identityList
              .map(
                (e) => StringDropdownModel(title: e['name']!, slug: e['slug']!),
              )
              .toList(),
          onChanged: (value) {
            // Set name
            controller.selectTypeName.value = value!.title;
            controller.selectTypeSlug.value = value.slug!;
          },
        ),

        verticalSpace(Dimensions.heightSize * 1.2),

        // image picker
        Row(
          children: [
            Expanded(
              child: SelectedImageWidget(
                //  getImage: controller.fontImage.value ,
                imageUrl: controller.fontImage.value,

                labelName: Strings.IdCardImageFont,
                fieldName: "id_front_image",
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: SelectedImageWidget(
                // getImage: controller.backImage.value ,
                imageUrl: controller.backImage.value,

                labelName: Strings.IdCardImageBack,
                fieldName: "id_back_image",
              ),
            ),
          ],
        ),

        verticalSpace(Dimensions.heightSize * 1.3),

        SelectedImageWidget(
          imageUrl: controller.userPhoto.value,
          labelName: Strings.yourPhoto,
          fieldName: "user_image",
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.paddingSize * 1.4,
        bottom: Dimensions.paddingSize * 4.8,
      ),
      child: Obx(
        () => controller.isConfirmLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: () {
                  print(controller.listFieldName);
                  print(controller.listImagePath);

                  controller.updateCustomerKyc();
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
