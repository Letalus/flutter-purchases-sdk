import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkfive_purchases/linkfive_purchases.dart';

class SubscriptionButton extends StatelessWidget {
  final LinkFiveProductDetails linkFiveProductDetails;

  SubscriptionButton({required this.linkFiveProductDetails});

  onSubscriptionPressed() {
    LinkFivePurchases.purchase(linkFiveProductDetails.productDetails);
  }

  String get getDuration {
    switch (linkFiveProductDetails.duration) {
      case SubscriptionDuration.P1W:
        return "1 Week";
      case SubscriptionDuration.P1M:
        return "1 Month";
      case SubscriptionDuration.P3M:
        return "3 Months";
      case SubscriptionDuration.P6M:
        return "6 Months";
      case SubscriptionDuration.P1Y:
        return "1 Year";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubscriptionPressed,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(getDuration),
            Text(linkFiveProductDetails.productDetails.price)
          ],
        ),
      ),
    );
  }
}
