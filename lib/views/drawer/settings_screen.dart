import 'package:stripcard/widgets/appbar/appbar_widget.dart';
import '../../backend/local_storage.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../controller/drawer_controller/delete_account.dart';
import '../../language/language_drop_down.dart';
import '../../utils/basic_screen_import.dart';
import '../../controller/drawer/change_password_controller.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = Get.put(PasswordController());
  final deleteController = Get.put(SettingController());

  final passwordFormKey = GlobalKey<FormState>();

  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: AppBarWidget(text: Strings.settings),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.9,
      ),
      physics: BouncingScrollPhysics(),
      children: [
        verticalSpace(Dimensions.heightSize),
        _changePassword(context),
        _twoFaSecurity(context),
        _deleteAccountWidget(context),
        _changeLanguageWidget(context),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: Dimensions.marginSizeVertical * 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          decoration: BoxDecoration(
            color: isDarkMode
                ? CustomColor.primaryDarkScaffoldBackgroundColor
                : CustomColor.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(2, 3),
              ),
            ],
            border: Border.all(
              color: isDarkMode ? Colors.white38 : Colors.black26,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: isDarkMode ? Colors.yellow : Colors.orangeAccent,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  TitleHeading4Widget(
                    text: isDarkMode ? "Dark Mode" : "Light Mode",
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? CustomColor.primaryLightTextColor
                        : CustomColor.primaryDarkTextColor,
                  ),
                ],
              ),
              Switch.adaptive(
                value: Get.isDarkMode,
                activeColor: CustomColor.primaryDarkColor,
                inactiveTrackColor: Colors.grey.shade300,
                onChanged: (value) {
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  Get.forceAppUpdate();
                  print('---------------------------------');
                  print(Get.isDarkMode);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _changeLanguageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  TitleHeading4Widget(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSize * .2,
                    ),
                    text: Strings.charge,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize3,
                    color: Get.isDarkMode
                        ? CustomColor.grayColor
                        : CustomColor.primaryDarkScaffoldBackgroundColor,
                  ),
                  horizontalSpace(Dimensions.widthSize * 0.5),
                  TitleHeading4Widget(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSize * .2,
                    ),
                    text: Strings.language,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize3,
                    color: Get.isDarkMode
                        ? CustomColor.grayColor
                        : CustomColor.primaryDarkScaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
            Expanded(child: ChangeLanguageWidget()),
          ],
        ),
      ],
    );
  }

  _changePassword(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.changePasswordScreen);
      },
      child: TitleHeading4Widget(
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
        text: Strings.changePassword,
        fontWeight: FontWeight.normal,
        fontSize: Dimensions.headingTextSize3,
        color: Get.isDarkMode
            ? CustomColor.grayColor
            : CustomColor.primaryDarkScaffoldBackgroundColor,
      ),
    );
  }

  _twoFaSecurity(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.enable2FaScreen);
      },
      child: TitleHeading4Widget(
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
        text: Strings.twofasecurity,
        fontWeight: FontWeight.normal,
        fontSize: Dimensions.headingTextSize3,
        color: Get.isDarkMode
            ? CustomColor.grayColor
            : CustomColor.primaryDarkScaffoldBackgroundColor,
      ),
    );
  }

  _deleteAccountWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      mainAxisAlignment: mainStart,
      children: [
        verticalSpace(Dimensions.heightSize * 0.8),
        InkWell(
          onTap: () {
            _openDialogueForDeleteAccount(context);
          },
          child: Obx(
            () => controller.isLoading
                ? const CustomLoadingAPI()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: TitleHeading4Widget(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSize * .2,
                      ),
                      text: Strings.deleteAccount,
                      fontWeight: FontWeight.normal,
                      fontSize: Dimensions.headingTextSize3,
                      color: Get.isDarkMode
                          ? CustomColor.grayColor
                          : CustomColor.primaryDarkScaffoldBackgroundColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  _openDialogueForDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.center,
          insetPadding: EdgeInsets.all(Dimensions.paddingSize * 0.3),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Builder(
            builder: (context) {
              var width = MediaQuery.of(context).size.width;
              return Container(
                width: width * 0.84,
                margin: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.9),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? CustomColor.whiteColor
                      : CustomColor.whiteColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 1.4),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossCenter,
                  children: [
                    SizedBox(height: Dimensions.heightSize * 2),
                    TitleHeading2Widget(
                      text: Strings.deleteAccount.tr,
                      color: CustomColor.primaryDarkScaffoldBackgroundColor,
                    ),
                    verticalSpace(Dimensions.heightSize * 1),
                    TitleHeading4Widget(text: Strings.deleteAccountSubTitle.tr),
                    verticalSpace(Dimensions.heightSize * 1),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .25,
                            child: PrimaryButton(
                              title: Strings.cancel.tr,
                              onPressed: () {
                                Get.back();
                              },
                              borderColor: CustomColor
                                  .primaryDarkScaffoldBackgroundColor,
                              buttonColor: CustomColor
                                  .primaryDarkScaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        horizontalSpace(Dimensions.widthSize),
                        Expanded(
                          child: Obx(
                            () => deleteController.isLoading
                                ? const CustomLoadingAPI()
                                : SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    child: PrimaryButton(
                                      title: Strings.okay.tr,
                                      onPressed: () {
                                        deleteController
                                            .deleteAccountProcess()
                                            .then((value) {
                                              Get.offAllNamed(
                                                Routes.signInScreen,
                                              );
                                            });
                                      },
                                      borderColor:
                                          CustomColor.primaryLightColor,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
