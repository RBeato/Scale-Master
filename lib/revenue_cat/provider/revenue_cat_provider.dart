import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../config_reader.dart';
import '../../environment.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

enum Entitlement { free, paid }

final entitlementProvider = ChangeNotifierProvider<RevenueCatProvider>((ref) {
  return RevenueCatProvider();
});

class RevenueCatProvider extends ChangeNotifier {
  RevenueCatProvider() {
    init();
    debugPrint("Fix revenue cat");
  }
  Entitlement _entitlement = Entitlement.free;
  Entitlement get entitlement => _entitlement;
  String? _userId;
  String? get userId => _userId;

  Future init() async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      updatePurchaseStatus();
    });
  }

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getCustomerInfo();
    final entitlements = purchaserInfo.entitlements.active.values
        .toList(); //can have multiple entitlements
    _entitlement = entitlements.isEmpty ? Entitlement.free : Entitlement.paid;
    entitlements.isEmpty
        ? await ConfigReader.initialize(Environment.free)
        : await ConfigReader.initialize(Environment.paid);

    if (_entitlement == Entitlement.paid) {
      _userId = purchaserInfo.originalAppUserId;
    }
    notifyListeners();
  }
}


// class PurchaseApi {
//   static const _apiKey = 'qXHwqTEErAwRqfmrFymMWDNRVcNrVChd';

//   static Future init() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(_apiKey);
//     await isPaymentConfirmed();
//   }

//   static isPaymentConfirmed() async {
//     final purchaserInfo =
//         await Purchases.getPurchaserInfo(); // getCustomerInfo();
//     final entitlements = purchaserInfo.entitlements.active.values
//         .toList(); //can have multiple entitlements
//     entitlements.isEmpty
//         ? await ConfigReader.initialize(Environment.free)
//         : await ConfigReader.initialize(Environment.paid);
//   }

//   static Future<List<Offering>> fetchOffers() async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       final current = offerings.current;

//       return current == null ? [] : [current];
//     } on Exception catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   static Future<bool> purchasePackage(
//       Package package, String firebaseUserId) async {
//     try {
//       await Purchases.setup(_apiKey, appUserId: firebaseUserId);
//       await Purchases.purchasePackage(package);
//       isPaymentConfirmed();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }

