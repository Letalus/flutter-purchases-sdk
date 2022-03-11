import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchases_interface/in_app_purchases_interface.dart';
import 'package:linkfive_purchases/linkfive_purchases.dart';
import 'package:linkfive_purchases/logic/linkfive_purchases_main.dart';
import 'package:linkfive_purchases/models/linkfive_active_products.dart';
import 'package:linkfive_purchases/models/linkfive_products.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

/// LinkFive Purchases.
///
/// Welcome to LinkFive!
///
/// The docs can be found here https://www.linkfive.io/docs/
class LinkFivePurchases {

  /// Initialize LinkFive with your Api Key
  ///
  /// Please register on our website: https://www.linkfive.io to get an api key
  ///
  /// Possible usage:
  ///
  /// LinkFivePurchases.init(linkFiveApiKey)
  ///
  /// and then later while or before you show your paywall ui:
  ///
  /// LinkFivePurchases.fetchProducts()
  ///
  /// Also Possible but not recommended:
  ///
  /// LinkFivePurchases.init(linkFiveApiKey)
  ///     .then((value) => LinkFivePurchases.fetchProducts());
  ///
  /// [LinkFiveLogLevel] to see or hide internal logging
  /// [LinkFiveEnvironment] is 99,999..% [LinkFiveEnvironment.PRODUCTION] better not touch it
  static Future<LinkFiveActiveProducts> init(
    String apiKey, {
    LinkFiveLogLevel logLevel = LinkFiveLogLevel.DEBUG,
    LinkFiveEnvironment env = LinkFiveEnvironment.PRODUCTION,
  }) {
    return LinkFivePurchasesMain().init(apiKey, logLevel: logLevel, env: env);
  }

  /// By Default, the plugin does not fetch any Products to offer.
  ///
  /// You have to call this method at least once. The best case would be to call
  /// fetchProducts whenever you want to show your offer
  ///
  /// Whenever you want to offer subscriptions to your users.
  ///
  /// This method will call LinkFive to get all available subscriptions for the user
  /// and then uses the native methods for either ios or android to fetch the subscription
  /// details like duration, price, name, id etc.
  ///
  /// All Data will be send to the stream
  ///
  /// @return [LinkFiveProducts] or null if no subscriptions found
  static Future<LinkFiveProducts?> fetchProducts() {
    return LinkFivePurchasesMain().fetchProducts();
  }

  /// This will restore the subscriptions a user purchased.
  ///
  /// All data will be refreshed and notified with the product stream
  static Future<bool> restore() {
    return LinkFivePurchasesMain().restore();
  }

  /// This will trigger the purchase flow for the user.
  ///
  /// A verified purchase will be send to activeProducts Stream
  ///
  /// @return Future<bool>: if the "purchase screen" is visible.
  /// Please note: This is not a successful purchase.
  static Future<bool> purchase(ProductDetails productDetails) async {
    return LinkFivePurchasesMain().purchase(productDetails);
  }

  /// Handles the Switch Plan functionality.
  ///
  /// You can switch from one Subscription plan to another. Example: from currently a 1 month subscription to a 3 months subscription
  /// on iOS: you can only switch to a plan which is in the same Subscription Family
  ///
  /// [oldPurchaseDetails] given by the LinkFive Plugin
  ///
  /// [productDetails] from the purchases you want to switch to
  ///
  /// [prorationMode] Google Only: default replaces immediately the subscription, and the remaining time will be prorated and credited to the user.
  ///   Check https://developer.android.com/reference/com/android/billingclient/api/BillingFlowParams.ProrationMode for more information
  static Future<bool> switchPlan(
      LinkFivePlan oldPurchasePlan, LinkFiveProductDetails productDetails,
      {ProrationMode? prorationMode}) {
    return LinkFivePurchasesMain().switchPlan(oldPurchasePlan, productDetails,
        prorationMode: prorationMode);
  }

  /// This Stream contains all available Subscriptions you can offer to your user.
  ///
  /// LinkFiveSubscriptionData can be null and should be treated like no subscription available
  ///
  /// LinkFiveSubscriptionData.linkFiveSkuData is a List and contains all Subscriptions
  ///
  /// LinkFiveSubscriptionData.linkFiveSkuData[...].productDetails contains:
  ///
  /// ProductDetails({
  ///     id,
  ///     title,
  ///     description,
  ///     price,
  ///     rawPrice,
  ///     currencyCode,
  ///     currencySymbol = ''
  ///     });
  static Stream<LinkFiveProducts> get products =>
      LinkFivePurchasesMain().products;

  /// If the user has an active verified purchase, the stream will contain all necessary information
  /// An active product is a verified active subscription the user purchased
  ///
  /// @return LinkFiveActiveProducts which can also be null. Please treat it as no active subscription
  /// LinkFiveActiveSubscriptionData.subscriptionList is a List of verified subscriptions receipts
  /// LinkFiveActiveSubscriptionData.subscriptionList[...] can have the following attributes:
  ///   String sku;
  ///   String? purchaseId;
  ///   DateTime transactionDate;
  ///   DateTime? validUntilDate;
  ///   bool? isTrial;
  ///   bool isExpired;
  ///   String? familyName;
  ///   String? attributes;
  ///   String? period;
  static Stream<LinkFiveActiveProducts> get activeProducts =>
      LinkFivePurchasesMain().activeProducts;

  /// Set the UTM source of a user
  /// You can filter this value in your playout
  static setUTMSource(String? utmSource) {
    LinkFivePurchasesMain().setUTMSource(utmSource);
  }

  /// Set your own environment. Example: Production, Staging
  ///
  /// You can filter this value in your subscription playout
  static setEnvironment(String? environment) {
    LinkFivePurchasesMain().setEnvironment(environment);
  }

  /// set your own user ID
  ///
  /// You can filter this value in your subscription playout
  static setUserId(String? userId) {
    LinkFivePurchasesMain().setUserId(userId);
  }

  /// This is the callback Interface for the UI Paywall plugin
  ///
  /// You can just add the callbackInterface as the UI Paywall callback interface
  ///
  static LinkFivePurchasesMain get callbackInterface => LinkFivePurchasesMain();
}
