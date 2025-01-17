// Mocks generated by Mockito 5.2.0 from annotations
// in linkfive_purchases/test/logic/linkfive_purchases_main_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:in_app_purchase/in_app_purchase.dart' as _i4;
import 'package:in_app_purchase_android/in_app_purchase_android.dart' as _i9;
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart'
    as _i2;
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart' as _i8;
import 'package:linkfive_purchases/client/linkfive_billing_client_interface.dart'
    as _i12;
import 'package:linkfive_purchases/client/linkfive_client_interface.dart'
    as _i6;
import 'package:linkfive_purchases/linkfive_purchases.dart' as _i3;
import 'package:linkfive_purchases/models/linkfive_restore_apple_item.dart'
    as _i10;
import 'package:linkfive_purchases/models/linkfive_restore_google_item.dart'
    as _i11;
import 'package:linkfive_purchases/store/linkfive_app_data_store.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeProductDetailsResponse_0 extends _i1.Fake
    implements _i2.ProductDetailsResponse {}

class _FakeLinkFiveResponseData_1 extends _i1.Fake
    implements _i3.LinkFiveResponseData {}

/// A class which mocks [InAppPurchase].
///
/// See the documentation for Mockito's code generation for more information.
class MockInAppPurchase extends _i1.Mock implements _i4.InAppPurchase {
  MockInAppPurchase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<List<_i2.PurchaseDetails>> get purchaseStream =>
      (super.noSuchMethod(Invocation.getter(#purchaseStream),
              returnValue: Stream<List<_i2.PurchaseDetails>>.empty())
          as _i5.Stream<List<_i2.PurchaseDetails>>);
  @override
  T getPlatformAddition<T extends _i2.InAppPurchasePlatformAddition?>() =>
      throw UnsupportedError(
          '\'getPlatformAddition\' cannot be used without a mockito fallback generator.');
  @override
  _i5.Future<bool> isAvailable() =>
      (super.noSuchMethod(Invocation.method(#isAvailable, []),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i2.ProductDetailsResponse> queryProductDetails(
          Set<String>? identifiers) =>
      (super.noSuchMethod(
              Invocation.method(#queryProductDetails, [identifiers]),
              returnValue: Future<_i2.ProductDetailsResponse>.value(
                  _FakeProductDetailsResponse_0()))
          as _i5.Future<_i2.ProductDetailsResponse>);
  @override
  _i5.Future<bool> buyNonConsumable({_i2.PurchaseParam? purchaseParam}) =>
      (super.noSuchMethod(
          Invocation.method(
              #buyNonConsumable, [], {#purchaseParam: purchaseParam}),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> buyConsumable(
          {_i2.PurchaseParam? purchaseParam, bool? autoConsume = true}) =>
      (super.noSuchMethod(
          Invocation.method(#buyConsumable, [],
              {#purchaseParam: purchaseParam, #autoConsume: autoConsume}),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<void> completePurchase(_i2.PurchaseDetails? purchase) =>
      (super.noSuchMethod(Invocation.method(#completePurchase, [purchase]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> restorePurchases({String? applicationUserName}) =>
      (super.noSuchMethod(
          Invocation.method(#restorePurchases, [],
              {#applicationUserName: applicationUserName}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}

/// A class which mocks [LinkFiveClientInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockLinkFiveClientInterface extends _i1.Mock
    implements _i6.LinkFiveClientInterface {
  @override
  dynamic init(_i3.LinkFiveEnvironment? env,
          _i7.LinkFiveAppDataStore? appDataStore) =>
      super.noSuchMethod(Invocation.method(#init, [env, appDataStore]));
  @override
  _i5.Future<_i3.LinkFiveResponseData> fetchLinkFiveResponse() =>
      (super.noSuchMethod(Invocation.method(#fetchLinkFiveResponse, []),
              returnValue: Future<_i3.LinkFiveResponseData>.value(
                  _FakeLinkFiveResponseData_1()))
          as _i5.Future<_i3.LinkFiveResponseData>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> purchaseIos(
          _i8.AppStoreProductDetails? productDetails,
          _i8.AppStorePurchaseDetails? purchaseDetails) =>
      (super.noSuchMethod(
          Invocation.method(#purchaseIos, [productDetails, purchaseDetails]),
          returnValue:
              Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[])) as _i5
          .Future<List<_i3.LinkFivePlan>>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> purchaseGooglePlay(
          _i9.GooglePlayPurchaseDetails? purchaseDetails) =>
      (super.noSuchMethod(
              Invocation.method(#purchaseGooglePlay, [purchaseDetails]),
              returnValue:
                  Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[]))
          as _i5.Future<List<_i3.LinkFivePlan>>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> fetchUserPlanListFromLinkFive() =>
      (super.noSuchMethod(Invocation.method(#fetchUserPlanListFromLinkFive, []),
              returnValue:
                  Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[]))
          as _i5.Future<List<_i3.LinkFivePlan>>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> restoreIos(
          List<_i10.LinkFiveRestoreAppleItem>? restoreList) =>
      (super.noSuchMethod(Invocation.method(#restoreIos, [restoreList]),
              returnValue:
                  Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[]))
          as _i5.Future<List<_i3.LinkFivePlan>>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> restoreGoogle(
          List<_i11.LinkFiveRestoreGoogleItem>? restoreList) =>
      (super.noSuchMethod(Invocation.method(#restoreGoogle, [restoreList]),
              returnValue:
                  Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[]))
          as _i5.Future<List<_i3.LinkFivePlan>>);
  @override
  _i5.Future<List<_i3.LinkFivePlan>> changeUserId(String? userId) =>
      (super.noSuchMethod(Invocation.method(#changeUserId, [userId]),
              returnValue:
                  Future<List<_i3.LinkFivePlan>>.value(<_i3.LinkFivePlan>[]))
          as _i5.Future<List<_i3.LinkFivePlan>>);
}

/// A class which mocks [LinkFiveBillingClientInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockLinkFiveBillingClientInterface extends _i1.Mock
    implements _i12.LinkFiveBillingClientInterface {
  @override
  _i5.Future<List<_i2.ProductDetails>?> getPlatformSubscriptions(
          _i3.LinkFiveResponseData? linkFiveResponse) =>
      (super.noSuchMethod(
              Invocation.method(#getPlatformSubscriptions, [linkFiveResponse]),
              returnValue: Future<List<_i2.ProductDetails>?>.value())
          as _i5.Future<List<_i2.ProductDetails>?>);
}
