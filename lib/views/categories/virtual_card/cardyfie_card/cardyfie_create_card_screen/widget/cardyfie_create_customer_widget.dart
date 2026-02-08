part of "../cardyfie_create_card_screen.dart";

class CreateCustomerWidget extends StatelessWidget {
  CreateCustomerWidget({super.key});
  final controller = Get.put(VirtualCardyfieCardController());
  final profileController = Get.put(UpdateProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        _inputWidget(context),
        _buttonWidget(context),
        // _buttonCustomerUpdateWidget(context),
      ],
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
              isValidator: true,
            ),
          ),
        ),
        verticalSpace(Dimensions.heightSize),
        //dropdown select type
        CustomDropDown<StringDropdownModel>(
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
                labelName: Strings.IdCardImageFont,
                fieldName: "id_front_image",
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: SelectedImageWidget(
                labelName: Strings.IdCardImageBack,
                fieldName: "id_back_image",
              ),
            ),
          ],
        ),

        verticalSpace(Dimensions.heightSize * 1.3),

        SelectedImageWidget(
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
        () => controller.isCustomerCreateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: () {
                  print(controller.listFieldName);
                  print(controller.listImagePath);

                  controller.customerCreateProcess();
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }

  // _buttonCustomerUpdateWidget(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       top: Dimensions.paddingSize * 1.4,
  //       bottom: Dimensions.paddingSize * 4.8,
  //     ),
  //     child: Obx(
  //       () => controller.isCustomerCreateLoading
  //           ? const CustomLoadingAPI()
  //           : PrimaryButton(
  //               title: Strings.updateCustomer,
  //               onPressed: () {
  //                 print(controller.listFieldName);
  //                 print(controller.listImagePath);

  //                 Get.toNamed(Routes.cardyfieUpdateCustomerScreen);
  //               },
  //               borderColor: CustomColor.primaryLightColor,
  //               buttonColor: CustomColor.primaryLightColor,
  //             ),
  //     ),
  //   );
  // }
}
