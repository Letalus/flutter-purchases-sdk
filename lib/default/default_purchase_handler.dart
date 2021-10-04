import 'dart:async';

import 'package:in_app_purchases_interface/in_app_purchases_interface.dart';

/// Default Purchase Handler
/// [LinkFivePurchasesMain] extends this class to control the state of a purchase
class DefaultPurchaseHandler implements PurchaseStateStreamInterface {
  /// initial value for purchase in Progress
  final bool initialIsPurchaseInProgress;

  /// initial value for purchase Success
  final PurchaseState initialPurchaseState;

  /// Pending Purchase Cached data
  late bool _isPendingPurchase;

  /// Pending Purchase Cached data
  late PurchaseState _purchaseState;

  DefaultPurchaseHandler(
      {this.initialIsPurchaseInProgress = false,
      this.initialPurchaseState = PurchaseState.NOT_PURCHASED}) {
    this._isPendingPurchase = this.initialIsPurchaseInProgress;
    this._purchaseState = this.initialPurchaseState;
  }

  //#region Pending Purchase
  /// StreamController list of Pending Purchase Streams
  List<StreamController<bool>> _streamControllerPendingPurchase = [];

  /// Sets the value and updates all Stream listeners
  ///
  /// Also cleans all unused streams
  set isPendingPurchase(bool value) {
    LinkFiveLogger.d("set pending value $value");
    _isPendingPurchase = value;

    // Clean streams
    _cleanStreams(_streamControllerPendingPurchase);
    // send data to stream
    _streamControllerPendingPurchase.forEach((element) {
      if (element.hasListener) {
        element.add(_isPendingPurchase);
      }
    });
  }

  //#endregion

  //#region PurchaseState
  /// StreamController list of Pending Purchase Streams
  List<StreamController<PurchaseState>> _streamControllerPurchaseState = [];

  /// Sets the value and updates all Stream listeners
  ///
  /// Also cleans all unused streams
  set purchaseState(PurchaseState value) {
    LinkFiveLogger.d("set purchaseState value $value");
    _purchaseState = value;

    // Clean streams
    _cleanStreams(_streamControllerPurchaseState);

    // send data to stream
    _streamControllerPurchaseState.forEach((element) {
      if (element.hasListener) {
        element.add(_purchaseState);
      }
    });
  }

  //#endregion

  @override
  Stream<bool> purchaseInProgressStream() {
    // clean streams
    _cleanStreams(_streamControllerPendingPurchase);
    // create new stream controller
    var controller = StreamController<bool>();
    _streamControllerPendingPurchase.add(controller);
    controller.add(_isPendingPurchase);
    return controller.stream;
  }

  @override
  Stream<PurchaseState> purchaseStateStream() {
    // clean streams
    _cleanStreams(_streamControllerPurchaseState);
    // create new stream controller
    var controller = StreamController<PurchaseState>();
    _streamControllerPurchaseState.add(controller);
    controller.add(_purchaseState);
    return controller.stream;
  }

  void _cleanStreams(List<StreamController> streams) {
    streams.removeWhere((element) {
      return element.isClosed;
    });
  }
}
