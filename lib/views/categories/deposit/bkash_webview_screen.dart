import 'dart:convert';

import 'package:stripcard/controller/navbar/deposit/deposit_controller.dart';
import 'package:stripcard/language/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../backend/utils/custom_snackbar.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_color.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/others/congratulation_widget.dart';

class BkashWebViewScreen extends StatelessWidget {
  BkashWebViewScreen({
    super.key,
  });

  final controller = Get.put(DepositController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: Strings.bkashPayment.tr,
        onTap: () {
          Get.offAllNamed(Routes.bottomNavBarScreen);
        },
        actions: [
          IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.bottomNavBarScreen);
              },
              icon: Icon(
                Icons.home,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.whiteColor,
              ))
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? CustomLoadingAPI(
                color: CustomColor.primaryLightColor,
              )
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var paymentUrl = controller.automaticBkashModel.data.url;

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(paymentUrl)),
      onWebViewCreated: (InAppWebViewController inAppWebViewController) {},
      onWindowFocus: (controller) {
        print('object');
      },
      onProgressChanged:
          (InAppWebViewController inAppWebViewController, int progress) {},
      onLoadStop: (InAppWebViewController inAppWebViewController, url) async {
        if (url != null) {
          String? pageContent = await inAppWebViewController.evaluateJavascript(
            source: "document.body.innerText",
          );
          print("Page Content: $pageContent"); // Debugging

          if (pageContent != null && pageContent.isNotEmpty) {
            try {
              Map<String, dynamic> parsedJson = json.decode(pageContent);

              if (parsedJson.containsKey('type')) {
                if (parsedJson['type'] == 'success') {
                  Get.offAll(
                    () => StatusScreen(),
                  );
                } else if (parsedJson['type'] == 'error') {
                  Get.close(1);
                  CustomSnackBar.error(
                    parsedJson['message']['error'].first,
                  );
                }
              } else {
                print("Error: 'type' key not found in JSON.");
              }
            } catch (e) {
              print("Error parsing JSON: $e");
            }
          }
        }
      },
    );
  }
}
