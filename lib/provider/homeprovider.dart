import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiosk/function.dart';
import 'package:kiosk/models/counters_model.dart';
import 'package:kiosk/models/dieties_response_model.dart';
import 'package:kiosk/models/payment_mode_response.dart';
import 'package:kiosk/models/pooja_details_model.dart';
import 'package:kiosk/models/pooja_response_model.dart';
import 'package:kiosk/models/preview_bill_response.dart';
import 'package:kiosk/models/save_bill_body.dart';
import 'package:kiosk/models/save_bill_response.dart';
import 'package:kiosk/models/starts_response_model.dart';
import 'package:kiosk/services/app_config.dart';
import 'package:kiosk/services/helpers.dart';
import 'package:kiosk/services/provider_helper_class.dart';

class HomeProvider extends ProviderHelperClass with ChangeNotifier {
  @override
  void updateLoadState(LoaderState state) {}
  LoaderState poojaload = LoaderState.initial;
  updatePoojaloader(LoaderState state) {
    poojaload = state;
    notifyListeners();
  }

  LoaderState? poojaremoveloader;
  updateRemovepoojaLoaderState(LoaderState state) {
    poojaremoveloader = state;
  }

  String? paymentStatus;
  updatePaymentStatus(String status) {
    paymentStatus = status;
    notifyListeners();
  }

  StarsResponse? starsResponse;
  DeitiesResponse? deitiesResponse;
  PaymentModeResponse? paymentModeResponse;
  PoojaResponse? poojaResponse;
  int? dietyId;
  String? dietyIName;
  int? selectedStarId;
  String? selectedStarrname;
  int? selectedPoojaId;
  String? selectedPoojaName;
  int len = 0;
  String? selecteddate;
  String? dateapi;
  String? selectedpoojarate;
  List<PoojaDetails> pooja = [];
  PreviewBillResponse? previewBillResponse;
  double? grossamount;
  SaveBillResponse? saveBillResponse;

  updateSelectedDate({DateTime? date}) {
    dateapi = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    selecteddate = DateFormat('dd-MM-yyyy').format(date ?? DateTime.now());
    notifyListeners();
  }

  updateDietyId({int? id, String? name}) {
    dietyId = id;
    dietyIName = name;
    print(dietyIName);
    getPoojas(deityId: dietyId.toString());
    notifyListeners();
  }

  updateSelextedStarId({int? starid, String? starname}) {
    selectedStarId = starid;
    selectedStarrname = starname;
    notifyListeners();
  }

  updateSelextedPoojaId({int? poojaid, String? rate, String? poojaname}) {
    selectedPoojaId = poojaid;
    selectedPoojaName = poojaname;
    selectedpoojarate = rate;
    notifyListeners();
  }

  clearGrossAmount() {
    grossamount = null;
    pooja.clear();
  }

  clearStoredData() {
    selectedPoojaId = null;
    selectedpoojarate = null;
    selectedStarId = null;
    selectedPoojaName = null;
    selectedStarrname = null;

    notifyListeners();
  }

  removePooja({int? dietyid, int? poojaid, String? name, var val}) async {
    updateRemovepoojaLoaderState(LoaderState.loading);
    pooja.removeWhere(
      (items) =>
          items.deityId == dietyid &&
          items.poojaId == poojaid &&
          items.name == name,
    );
    grossamount = getGrossAmount(pooja);
    if (pooja.isEmpty) {
      val.pop();
    } else {
      await getPreviewBill();
    }
    updateRemovepoojaLoaderState(LoaderState.loaded);

    notifyListeners();
  }

  double getGrossAmount(List<PoojaDetails> pooja) {
    double total = 0;

    for (var item in pooja) {
      // Parse rate; default to 0 if empty or invalid
      double rate = double.tryParse(item.rate?.toString() ?? '') ?? 0;
      int qty = item.qty ?? 0;

      total += rate * qty;
    }

    return total;
  }

  addToPoojaDetails({
    String? name,
    String? date,
    int? dietyid,
    int? poojaid,
    int? starid,
    String? diety,
    String? poojaname,
    String? star,
    String? rate,
    int? qty,
  }) async {
    pooja.add(
      PoojaDetails(
        diety: diety,
        pooja: poojaname,
        star: star,
        name: name,
        address: null,
        date: date,
        deityId: dietyid,
        dwmo: null,
        fromDate: date,
        isScheduled: 0,
        monthStar: null,
        noOfDays: null,
        noOfMonths: null,
        noOfWeeks: null,
        poojaId: poojaid,
        qty: qty ?? 1,
        rate: double.tryParse(rate ?? '0') ?? 0.0,
        starId: starid,
        weekDays: null,
      ),
    );
    for (var item in pooja) {
      print(
        "${item.deityId}..${item.diety}..${item.name}..${item.poojaId}..${item.pooja}..${item.starId}..${item.rate}..${item.qty}",
      );
    }
    grossamount = getGrossAmount(pooja);

    notifyListeners();
  }

  Future<void> getDeities() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getDeities();
        if (res.isValue) {
          deitiesResponse = res.asValue!.value;
          // if (deitiesResponse != null) {
          //   updateDeitiesList(deitiesResponse);
          // }
          // updateLoadState(LoaderState.loaded);
          dietyId = deitiesResponse?.data![0].id;
          dietyIName = deitiesResponse?.data![0].nameMal;
          updateSelextedPoojaId(poojaid: null, poojaname: null);
          notifyListeners();
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in deities: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }


  

  Future<void> getStars() async {
    // updateLoadState(LoaderState.loading);
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      try {
        var res = await serviceConfig.getStarts();
        if (res.isValue) {
          starsResponse = res.asValue!.value;
          // if (starsResponse != null) {
          //   updateStarsList(starsResponse);
          // }
          //updateLoadState(LoaderState.loaded);

          notifyListeners();
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in stars: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  Future<void> getPaymentModes({Function? onFailure}) async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getPaymentModes();
        if (res.isValue) {
          paymentModeResponse = res.asValue!.value;
          // updatePaymentModeList(paymentModeResponse);
        } else {
          updateLoadState(LoaderState.loaded);
          if (onFailure != null) onFailure();
        }
      } catch (e) {
        debugPrint('exception in deities: $e');
        updateLoadState(LoaderState.loaded);
      }
      notifyListeners();
    }
  }

  List<Datum>? counterdata = [];
  List<String> counterName = [];
  List<String> counterId = [];
  Future<void> getCounter() async {
    updateLoadState(LoaderState.loading);
    try {
      var res = await serviceConfig.getCounters();
      if (res.isValue) {
        CounterModel? counters = res.asValue!.value;
        if (counters?.data != null) {
          counterdata = counters?.data;
          counterName.clear();
          counterId.clear();
          counterdata?.forEach((element) {
            counterName.add(element.name ?? "");
            counterId.add('${element.id}');
          });
          notifyListeners();
        }
        updateLoadState(LoaderState.loaded);
      } else {
        updateLoadState(LoaderState.loaded);
      }
    } catch (e) {
      debugPrint('exception in counters: $e');
      updateLoadState(LoaderState.loaded);
    }
  }

  Future<void> getPoojas({
    bool isEnableBtnLoader = false,
    String? deityId,
  }) async {
    updatePoojaloader(LoaderState.initial);
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      if (isEnableBtnLoader) updateBtnLoader(true);
      try {
        updatePoojaloader(LoaderState.loading);
        var res = await serviceConfig.getPoojas(deityId ?? '1');
        if (res.isValue) {
          poojaResponse = res.asValue!.value;
          // if (poojaResponse != null) {
          //   updatePoojasList(poojaResponse);
          // }
          len = poojaResponse?.data?.length ?? 0;
          updateSelextedPoojaId(poojaid: null, rate: null, poojaname: null);
          updateBtnLoader(false);
          updatePoojaloader(LoaderState.loaded);
          updateLoadState(LoaderState.loaded);
          notifyListeners();
        } else {
          updatePoojaloader(LoaderState.error);
          updateBtnLoader(false);
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in poojas: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  // // Rate for "Muttarukkal with Coconut" = pooja 38's rate + pooja 39's rate,
  // // looked up from the default deity's pooja list. Fetched directly via
  // // serviceConfig (not the shared getPoojas()/poojaResponse state) so it
  // // doesn't disturb whatever pooja list other screens currently have loaded.
  // static const int muttarukkalPoojaId = 38;
  // static const int coconutPoojaId = 39;
  // static const int netBagPoojaId = 58;

  // Future<double> getMuttarukkalWithCoconutRate() async {
  //   try {
  //     final results = await Future.wait([
  //       serviceConfig.getPoojaDetails(muttarukkalPoojaId),
  //       serviceConfig.getPoojaDetails(coconutPoojaId),
  //     ]);

  //     double total = 0;
  //     for (final res in results) {
  //       if (res.isValue) {
  //         total += (res.asValue!.value as PoojaDetailsModel).data.rate;
  //       }
  //     }
  //     return total;
  //   } catch (e) {
  //     debugPrint('exception in getMuttarukkalWithCoconutRate: $e');
  //     return 0;
  //   }
  // }



    // Rate for "Muttarukkal with Coconut" = pooja 38's rate + pooja 39's rate,
  // looked up from the default deity's pooja list. Fetched directly via
  // serviceConfig (not the shared getPoojas()/poojaResponse state) so it
  // doesn't disturb whatever pooja list other screens currently have loaded.
  static const int muttarukkalPoojaId = 38;
  static const int coconutPoojaId = 39;
  static const int netBagPoojaId = 58;

  Future<(double muttarukkal, double coconut)> getMuttarukkalAndCoconutRates() async {
    try {
      final results = await Future.wait([
        serviceConfig.getPoojaDetails(muttarukkalPoojaId),
        serviceConfig.getPoojaDetails(coconutPoojaId),
      ]);

      double muttarukkalRate = 0;
      double coconutRate = 0;
      if (results[0].isValue) {
        muttarukkalRate = (results[0].asValue!.value as PoojaDetailsModel).data.rate.toDouble();
      }
      if (results[1].isValue) {
        coconutRate = (results[1].asValue!.value as PoojaDetailsModel).data.rate.toDouble();
      }
      return (muttarukkalRate, coconutRate);
    } catch (e) {
      debugPrint('exception in getMuttarukkalAndCoconutRates: $e');
      return (0.0, 0.0);
    }
  }

  Future<double> getNetBagRate() async {
    try {
      final res = await serviceConfig.getPoojaDetails(netBagPoojaId);
      if (res.isValue) {
        return (res.asValue!.value as PoojaDetailsModel).data.rate.toDouble();
      }
      return 0;
    } catch (e) {
      debugPrint('exception in getNetBagRate: $e');
      return 0;
    }
  }

  Future<void> getPreviewBill({
    Function? onSuccess,
    Function? onFailure,
  }) async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      try {
        var res = await serviceConfig.getPreviewBill(
          pooja: pooja,
          totalamount: grossamount.toString(),
        );

        if (res.isValue) {
          previewBillResponse = res.asValue!.value;
          print(
            previewBillResponse?.data?.poojaDetails
                ?.map((e) => e.pooja)
                .toList(),
          );
          if (onSuccess != null) onSuccess();
        } else {
          if (onFailure != null) onFailure();
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in preview bill: $e');
        updateLoadState(LoaderState.loaded);
      }
      notifyListeners();
    }
  }

  bool successave = false;
  updateSuccessSave(val) {
    successave = val;
    notifyListeners();
  }

  Future<void> saveBill({
    Function? onSuccess,
    Function? onFailure,
    String? transid,
    bool enableLoaderState = false,
  }) async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      if (enableLoaderState) updateBtnLoader(true);
      if (!enableLoaderState) updateLoadState(LoaderState.loading);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      previewBillResponse?.data?.poojaDetails?.forEach((item) {
        item.date ??= item.fromDate ?? today;
      });
      SaveBillBody saveBillBody = SaveBillBody(
        billAmount: grossamount,
        counterId: int.parse(AppConfig.counterID ?? '0'),
        customerId: AppConfig.customerId ?? 1,
        paidAmount: grossamount,
        paymentMode: 5,
        transactionid: transid ?? '',
        // ""transid == null || transid == '' ? null : transid",
        poojaDetails: previewBillResponse?.data?.poojaDetails,
      );
      try {
        var res = await serviceConfig.saveBill(saveBillBody);
        if (res.isValue) {
          saveBillResponse = res.asValue!.value;

          if (onSuccess != null) onSuccess();
          if (enableLoaderState) updateBtnLoader(false);
          if (!enableLoaderState) updateLoadState(LoaderState.loaded);
        } else {
          if (onFailure != null) onFailure();
          if (enableLoaderState) updateBtnLoader(false);
          if (!enableLoaderState) updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in save bill: $e');
        if (enableLoaderState) updateBtnLoader(false);
        if (!enableLoaderState) updateLoadState(LoaderState.loaded);
        Helpers.successToast('Internal Server Error...');
      }
    }
  }
}
