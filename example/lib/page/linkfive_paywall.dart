import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:in_app_purchases_paywall_ui/in_app_purchases_paywall_ui.dart';
import 'package:linkfive_purchases/models/linkfive_subscription.dart';
import 'package:linkfive_purchases_example/provider/linkfive_provider.dart';
import 'package:provider/provider.dart';

class LinkFivePaywall extends Page {
  LinkFivePaywall() : super(key: ValueKey("LinkFivePaywall"));

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return SimplePayWallUIWidget();
        },
      );
}

class SimplePayWallUIWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LinkFiveProvider>(builder: (_, linkFiveProvider, __) {
      LinkFiveSubscriptionData? linkFiveSubscriptionData =
          linkFiveProvider.linkFiveSubscriptionData;
      return SimplePayWallUiElement(
        linkFiveProvider,
        linkFiveSubscriptionData,
        appBarTitle: "Premium",
        title: "Go Premium",
        subTitle: "All features now",
        dealPercentage: {SubscriptionDuration.P3M: 30},
        durationTitle: {SubscriptionDuration.P3M: "Quarterlyy"},
      );
    });
  }
}

class SimplePayWallUiElement extends StatelessWidget {
  final String? appBarTitle;
  final String? title;
  final String? subTitle;
  final TextAndUrl? tosData;
  final TextAndUrl? ppData;
  final Widget? headerContainer;
  final List<IconAndText>? bulletPoints;
  final Widget? campaignWidget;
  final String? restoreText;
  final Map<SubscriptionDuration, int>? dealPercentage;
  final Map<SubscriptionDuration, String>? durationTitle;
  final Map<SubscriptionDuration, String>? durationShort;

  SimplePayWallUiElement(this.linkFiveProvider, this.linkFiveSubscriptionData,
      {this.appBarTitle,
      this.title,
      this.subTitle,
      this.tosData,
      this.ppData,
      this.headerContainer,
      this.bulletPoints,
      this.campaignWidget,
      this.restoreText,
      this.dealPercentage,
      this.durationTitle,
      this.durationShort});

  final LinkFiveProvider linkFiveProvider;
  final LinkFiveSubscriptionData? linkFiveSubscriptionData;

  //#region subscriptions getter
  List<LinkFiveProductDetails> get _skuData =>
      linkFiveSubscriptionData?.linkFiveSkuData ?? [];

  int getDeal(LinkFiveProductDetails linkFiveProductDetails) {
    Map<String, dynamic> attributesMap = _attributesPaywall;
    switch (linkFiveProductDetails.getSubscriptionPeriod()) {
      case SubscriptionDuration.P1Y:
        return attributesMap["deal.P1Y"] ??
            dealPercentage?[SubscriptionDuration.P1Y] ??
            0;
      case SubscriptionDuration.P6M:
        return attributesMap["deal.P6M"] ??
            dealPercentage?[SubscriptionDuration.P6M] ??
            0;
      case SubscriptionDuration.P3M:
        return attributesMap["deal.P3M"] ??
            dealPercentage?[SubscriptionDuration.P3M] ??
            0;
      case SubscriptionDuration.P1M:
        return attributesMap["deal.P1M"] ??
            dealPercentage?[SubscriptionDuration.P1M] ??
            0;
      case SubscriptionDuration.P1W:
        return attributesMap["deal.P1W"] ??
            dealPercentage?[SubscriptionDuration.P1W] ??
            0;
      case null:
        return 0;
    }
  }

  List<SubscriptionData> get _subscriptionDataList => _skuData
      .map((lfProductDetails) => SubscriptionData(
          durationTitle: getDurationTitle(lfProductDetails),
          durationShort: getDurationShort(lfProductDetails),
          price: lfProductDetails.productDetails.price,
          dealPercentage: getDeal(lfProductDetails),
          productDetails: lfProductDetails.productDetails))
      .toList();

  String getDurationTitle(LinkFiveProductDetails linkFiveProductDetails) {
    switch (linkFiveProductDetails.getSubscriptionPeriod()) {
      case SubscriptionDuration.P1Y:
        return durationTitle?[SubscriptionDuration.P1Y] ?? "Yearly";
      case SubscriptionDuration.P6M:
        return durationTitle?[SubscriptionDuration.P6M] ?? "Biannual";
      case SubscriptionDuration.P3M:
        return durationTitle?[SubscriptionDuration.P3M] ?? "Quarterly";
      case SubscriptionDuration.P1M:
        return durationTitle?[SubscriptionDuration.P1M] ?? "Monthly";
      case SubscriptionDuration.P1W:
        return durationTitle?[SubscriptionDuration.P1W] ?? "Weekly";
      case null:
        return "-";
    }
  }

  String getDurationShort(LinkFiveProductDetails linkFiveProductDetails) {
    switch (linkFiveProductDetails.getSubscriptionPeriod()) {
      case SubscriptionDuration.P1Y:
        return durationShort?[SubscriptionDuration.P1Y] ?? "1 Year";
      case SubscriptionDuration.P6M:
        return durationShort?[SubscriptionDuration.P6M] ?? "6 Months";
      case SubscriptionDuration.P3M:
        return durationShort?[SubscriptionDuration.P3M] ?? "3 Months";
      case SubscriptionDuration.P1M:
        return durationShort?[SubscriptionDuration.P1M] ?? "1 Month";
      case SubscriptionDuration.P1W:
        return durationShort?[SubscriptionDuration.P1W] ?? "1 Week";
      case null:
        return "-";
    }
  }

//#endregion

//#region attributes getter
  String get _attributesString => linkFiveSubscriptionData?.attributes ?? "{}";

  Map<String, dynamic> get _attributesParsed {
    try {
      return jsonDecode(utf8.decode(base64.decode(_attributesString)));
    } catch (e) {
      LinkFiveLogger.t("parsing attributes exception: $e");
    }
    return {};
  }

  Map<String, dynamic> get _attributesPaywall {
    try {
      return _attributesParsed["paywall"] as Map<String, dynamic>;
    } catch (e) {
      LinkFiveLogger.t("parsing attributes paywall exception: $e");
    }
    LinkFiveLogger.d("No Paywall Attributes found");
    return {};
  }

//#endregion

  @override
  Widget build(BuildContext context) {
    if (linkFiveSubscriptionData != null) {
      Map<String, dynamic> attributesMap = _attributesPaywall;
      String? appBarTitle = attributesMap["app.bar.title"] ?? this.appBarTitle;
      String? title = attributesMap["title"] ?? this.title;
      String? subTitle = attributesMap["sub.title"] ?? this.subTitle;
      // bullet points
      List<dynamic>? bulletPoints = attributesMap["bullet.points"] == null
          ? null
          : attributesMap["bullet.points"] as List<dynamic>;
      List<IconAndText>? iconAndTextList;
      if (bulletPoints != null) {
        iconAndTextList = bulletPoints
            .map((value) => value as Map<String, dynamic>)
            .map((value) => IconAndText(
                IconData(int.parse('0x${value["icon.hex"]}'),
                    fontFamily: 'MaterialIcons'),
                value["text"] ?? ""))
            .toList();
      } else {
        iconAndTextList = this.bulletPoints;
      }

      String? tosText = attributesMap["tos.text"];
      String? tosURL = attributesMap["tos.url"];
      String? ppText = attributesMap["pp.text"];
      String? ppURL = attributesMap["pp.url"];

      TextAndUrl? tos;
      TextAndUrl? pp;

      if (tosText != null && tosURL != null) {
        tos = TextAndUrl(tosText, tosURL);
      } else {
        tos = tosData;
      }

      if (ppText != null && ppURL != null) {
        tos = TextAndUrl(ppText, ppURL);
      } else {
        tos = ppData;
      }

      return Container(
        child: PaywallScaffold(
            appBarTitle: "LinkFive Premium",
            child: SimplePaywall(
                theme: Theme.of(context),
                callbackInterface: linkFiveProvider.linkFivePurchases,
                subscriptionListData: _subscriptionDataList,
                title: "Go Premium",
                // SubTitle
                subTitle: "All features at a glance",
                // Add as many bullet points as you like
                bulletPoints: [
                  IconAndText(Icons.stop_screen_share_outlined, "No Ads"),
                  IconAndText(Icons.hd, "Premium HD"),
                  IconAndText(Icons.sort, "Access to All Premium Articles")
                ], // Shown if isPurchaseSuccess == true
                successTitle: "You're a Premium User!",
                // Shown if isPurchaseSuccess == true
                successSubTitle: "Thanks for your Support!",
                // Widget can be anything. Shown if isPurchaseSuccess == true
                successWidget: Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("Let's go!"),
                            onPressed: () {
                              print("let‘s go to the home widget again");
                            },
                          )
                        ])),
                tosData: TextAndUrl(
                    "Terms of Service", "https://www.linkfive.io/tos"),
                // provide your PP
                ppData: TextAndUrl(
                    "Privacy Policy", "https://www.linkfive.io/privacy"),
                // add a custom campaign widget
                campaignWidget: CampaignBanner(
                  theme: Theme.of(context),
                  headline: "🥳 Summer Special Sale",
                ))),
      );
    }
    return PaywallScaffold(
        appBarTitle: appBarTitle,
        child: SimplePaywall(
          theme: Theme.of(context),
          isSubscriptionLoading: true,
        ));
  }
}
