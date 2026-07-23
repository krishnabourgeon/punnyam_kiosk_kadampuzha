import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/color_pallatte.dart';
import 'package:kiosk/extension.dart';
import 'package:kiosk/fontpallate.dart';
import 'package:kiosk/provider/homeprovider.dart';
import 'package:kiosk/services/helpers.dart';
import 'package:kiosk/view/billpreview.dart';
import 'package:kiosk/view/homepage.dart';
import 'package:provider/provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MUTTARUKKAL WITH COCONUT BOOKING SCREEN
// Same shell (header, decorations, add-more/continue, print & preview flow)
// as Bookpoojascreen, but with just Qty / Rate / Total Rate fields instead
// of name/star/deity/pooja selection.
// ─────────────────────────────────────────────────────────────────────────────
class MuttarukkalBookingScreen extends StatefulWidget {
  const MuttarukkalBookingScreen({super.key, this.lanid});
  final int? lanid;

  @override
  State<MuttarukkalBookingScreen> createState() =>
      _MuttarukkalBookingScreenState();
}

class _MuttarukkalBookingScreenState extends State<MuttarukkalBookingScreen> {
  final TextEditingController qty = TextEditingController();

  final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<double> totalRate = ValueNotifier<double>(0);
  final ValueNotifier<double?> unitRate = ValueNotifier<double?>(null);

  static const String _label = "Muttarukkal with Coconut";

  @override
  void initState() {
    super.initState();
    qty.addListener(_recalcTotal);
    _loadRate();
  }

  Future<void> _loadRate() async {
    final rate = await context.read<HomeProvider>().getMuttarukkalWithCoconutRate();
    if (!mounted) return;
    unitRate.value = rate;
    _recalcTotal();
  }

  void _recalcTotal() {
    final q = int.tryParse(qty.text.trim()) ?? 0;
    totalRate.value = q * (unitRate.value ?? 0);
  }

  @override
  void dispose() {
    qty.dispose();
    isEnabled.dispose();
    totalRate.dispose();
    unitRate.dispose();
    super.dispose();
  }

  bool _validate() {
    if (unitRate.value == null || unitRate.value! <= 0) {
      Helpers.successToast("Rate not available, please try again");
      return false;
    }
    final q = int.tryParse(qty.text.trim());
    if (q == null || q <= 0) {
      Helpers.successToast("Please enter a valid quantity");
      return false;
    }
    return true;
  }

  Future<void> _addEntry(HomeProvider home) async {
    await home.addToPoojaDetails(
      name: _label,
      poojaname: _label,
      diety: _label,
      poojaid: HomeProvider.muttarukkalPoojaId,
      rate: (unitRate.value ?? 0).toStringAsFixed(0),
      qty: int.parse(qty.text.trim()),
    );
    qty.clear();
    totalRate.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              const Color.fromARGB(255, 243, 233, 98),
              const Color.fromARGB(255, 244, 245, 199),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -30.h,
              right: -150.w,
              child: Container(
                height: 220.h,
                width: 702.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/flwr.png"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -45.h,
              left: -250.w,
              child: Container(
                height: 220.h,
                width: 702.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/flwr.png"),
                  ),
                ),
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, home, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          25.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(45.r),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sree Kadampuzha Bhagavathy Temple",
                                      style: Fontpalette.brown65700,
                                    ),
                                    Text(
                                      "Melmuri, Kadampuzha, Kerala",
                                      style: Fontpalette.grey45600,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 80.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        "assets/images/poojabookingimg.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ).horizontalPadding(60.w).verticalPadding(15.h),
                          ),
                          20.verticalSpace,
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.r),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(_label, style: Fontpalette.brown65700),
                                    15.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Qty",
                                                style:
                                                    Fontpalette
                                                        .blackinter40400,
                                              ),
                                              5.verticalSpace,
                                              _field(
                                                controller: qty,
                                              ),
                                            ],
                                          ),
                                        ),
                                        30.horizontalSpace,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Rate",
                                                style:
                                                    Fontpalette
                                                        .blackinter40400,
                                              ),
                                              5.verticalSpace,
                                              ValueListenableBuilder<double?>(
                                                valueListenable: unitRate,
                                                builder:
                                                    (context, value, child) => Container(
                                                      height: 50.h,
                                                      alignment:
                                                          Alignment
                                                              .centerLeft,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              21.r,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              Colors.black,
                                                        ),
                                                        color: HexColor(
                                                          "#F5F5F5",
                                                        ),
                                                      ),
                                                      child:
                                                          value == null
                                                              ? SizedBox(
                                                                height: 20.h,
                                                                width: 20.h,
                                                                child: const CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                              ).horizontalPadding(
                                                                40.w,
                                                              )
                                                              : Text(
                                                                value
                                                                    .toStringAsFixed(
                                                                      0,
                                                                    ),
                                                                style:
                                                                    Fontpalette
                                                                        .blackinter45400,
                                                              ).horizontalPadding(
                                                                40.w,
                                                              ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        30.horizontalSpace,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Rate",
                                                style:
                                                    Fontpalette
                                                        .blackinter40400,
                                              ),
                                              5.verticalSpace,
                                              ValueListenableBuilder<double>(
                                                valueListenable: totalRate,
                                                builder:
                                                    (context, value, child) => Container(
                                                      height: 50.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              21.r,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              Colors.black,
                                                        ),
                                                        color: HexColor(
                                                          "#F5F5F5",
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            value
                                                                .toStringAsFixed(
                                                                  0,
                                                                ),
                                                            style:
                                                                Fontpalette
                                                                    .blackinter45400,
                                                          ).horizontalPadding(
                                                            40.w,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ).horizontalPadding(60.w).verticalPadding(20.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: isEnabled,
                              builder:
                                  (context, value, child) => InkWell(
                                    onTap: () async {
                                      if (home.pooja.isEmpty) {
                                        if (!_validate()) return;
                                        isEnabled.value = true;
                                        FocusScope.of(context).unfocus();
                                        await _addEntry(home);
                                        await home.getPreviewBill(
                                          onSuccess: () async {
                                            navigatescrren(
                                              page: PreviewScreen(),
                                              context: context,
                                            );
                                            home.clearStoredData();
                                            isEnabled.value = false;
                                          },
                                          onFailure: () {
                                            isEnabled.value = false;
                                          },
                                        );
                                      } else {
                                        isEnabled.value = true;
                                        if (qty.text.isNotEmpty) {
                                          if (!_validate()) {
                                            isEnabled.value = false;
                                            return;
                                          }
                                          await _addEntry(home);
                                        }
                                        await home.getPreviewBill(
                                          onSuccess: () async {
                                            navigatescrren(
                                              page: PreviewScreen(),
                                              context: context,
                                            );
                                            home.clearStoredData();
                                            isEnabled.value = false;
                                          },
                                          onFailure: () {
                                            isEnabled.value = false;
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          27.r,
                                        ),
                                        color: HexColor("#EC5002"),
                                      ),
                                      child:
                                          isEnabled.value == true
                                              ? CircularProgressIndicator(
                                                color: Colors.white,
                                              ).horizontalPadding(190.w)
                                              : Text(
                                                "Continue",
                                                style: Fontpalette.white50700,
                                              ).symmetricPadding(
                                                vertical: 18.h,
                                                horizontal: 150.w,
                                              ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Text(
                          "www.punnyamtemplesuite.com",
                          style: Fontpalette.brown30600,
                        ),
                      ],
                    ).horizontalPadding(100.w),
                  ],
                ).horizontalPadding(90.w).topPadding(70.h).bottomPadding(5.h);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({required TextEditingController controller}) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.r),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: Fontpalette.blackinter45400,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 40.w,
          ),
          hintText: " ",
          hintStyle: Fontpalette.blackinter24400,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
