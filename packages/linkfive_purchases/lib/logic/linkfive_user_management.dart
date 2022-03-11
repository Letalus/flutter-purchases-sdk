import 'package:linkfive_purchases/linkfive_purchases.dart';
import 'package:linkfive_purchases/store/linkfive_prefs.dart';

class LinkFiveUserManagement {
  LinkFiveUserManagement._();

  static LinkFiveUserManagement _instance = LinkFiveUserManagement._();

  factory LinkFiveUserManagement() => _instance;

  /// This is the LinkFive user ID of the current user.
  String? _linkFiveUUID;

  String? get linkFiveUUID => _linkFiveUUID;

  /// Return true if there is a LinkFive user saved
  bool get hasUser => _linkFiveUUID?.isNotEmpty == true;

  /// Return true if there is NO LinkFive user saved
  bool get hasNoUser => !hasUser;

  init() async {
    _linkFiveUUID = LinkFivePrefs().linkFiveUUID;
  }

  onResponse(Map<String, dynamic> jsonResponse) {
    String? linkFiveUUID = jsonResponse["linkFiveUUID"];
    LinkFiveLogger.d("Setting LinkFive UUID ${linkFiveUUID}");
    if (linkFiveUUID != null && linkFiveUUID.isNotEmpty) {
      _linkFiveUUID = linkFiveUUID;
      LinkFivePrefs().linkFiveUUID = linkFiveUUID;
    }
  }
}
