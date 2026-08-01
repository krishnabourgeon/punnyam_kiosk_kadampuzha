// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kiosk/color_pallatte.dart';
// import 'package:kiosk/extension.dart';
// import 'package:kiosk/fontpallate.dart';
// import 'package:kiosk/provider/homeprovider.dart';
// import 'package:kiosk/services/helpers.dart';
// import 'package:kiosk/services/provider_helper_class.dart';
// import 'package:kiosk/view/billpreview.dart';
// import 'package:kiosk/view/homepage.dart';
// import 'package:provider/provider.dart';

// class Bookpoojascreen extends StatefulWidget {
//   const Bookpoojascreen({super.key, this.lanid});
//   final int? lanid;
//   @override
//   State<Bookpoojascreen> createState() => _BookpoojascreenState();
// }

// class _BookpoojascreenState extends State<Bookpoojascreen> {
//   TextEditingController name = TextEditingController();
//   TextEditingController amt = TextEditingController();
//   DateTime? selectedDate;

//   Future<void> pickDate() async {
//     final home = context.read<HomeProvider>();
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != selectedDate) {
//       home.updateSelectedDate(date: picked);
//     }
//   }

//   final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: AlignmentDirectional.topCenter,
//             end: AlignmentDirectional.bottomCenter,
//             colors: [
//               const Color.fromARGB(255, 243, 233, 98),
//               const Color.fromARGB(255, 244, 245, 199),
//               Colors.white,
//               Colors.white,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: -30.h,
//               right: -150.w,
//               child: Container(
//                 height: 220.h,
//                 width: 702.w,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage("assets/images/flwr.png"),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: -45.h,
//               left: -250.w,
//               child: Container(
//                 height: 220.h,
//                 width: 702.w,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage("assets/images/flwr.png"),
//                   ),
//                 ),
//               ),
//             ),

//             Consumer<HomeProvider>(
//               builder: (context, home, child) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           25.verticalSpace,
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(45.r),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Sree Kadampuzha Bhagavathy Temple",
//                                       style: Fontpalette.brown65700,
//                                     ),
//                                     Text(
//                                       "Melmuri, Kadampuzha, Kerala",
//                                       style: Fontpalette.grey45600,
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   height: 80.h,
//                                   width: 200.w,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       fit: BoxFit.contain,
//                                       image: AssetImage(
//                                         "assets/images/poojabookingimg.png",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ).horizontalPadding(60.w).verticalPadding(15.h),
//                           ),
//                           20.verticalSpace,
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(45.r),
//                                 color: Colors.white,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Name",
//                                               style:
//                                                   Fontpalette.blackinter40400,
//                                             ),
//                                             5.verticalSpace,
//                                             Container(
//                                               height: 50.h,

//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(21.r),
//                                                 border: Border.all(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               child: TextField(
//                                                 controller: name,
//                                                 style:
//                                                     Fontpalette.blackinter45400,
//                                                 textAlignVertical:
//                                                     TextAlignVertical.center,
//                                                 decoration: InputDecoration(
//                                                   isDense: true,
//                                                   contentPadding:
//                                                       EdgeInsets.symmetric(
//                                                         vertical: 15.h,
//                                                         horizontal: 40.w,
//                                                       ),

//                                                   hintText: " ",
//                                                   hintStyle:
//                                                       Fontpalette
//                                                           .blackinter24400,
//                                                   border: InputBorder.none,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       30.horizontalSpace,
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Choose date",
//                                             style: Fontpalette.blackinter40400,
//                                           ),
//                                           5.verticalSpace,
//                                           InkWell(
//                                             onTap: () => pickDate(),
//                                             child: Container(
//                                               height: 50.h,
//                                               width: 500.w,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(21.r),
//                                                 border: Border.all(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     home.selecteddate ?? '',
//                                                     style:
//                                                         Fontpalette
//                                                             .blackinter45400,
//                                                   ).horizontalPadding(40.w),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   10.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Select star",
//                                         style: Fontpalette.blackinter40400,
//                                       ),
//                                     ],
//                                   ),
//                                   5.verticalSpace,
//                                   SizedBox(
//                                     height: 35.h,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount:
//                                           home.starsResponse?.data?.length ?? 0,
//                                       itemBuilder: (context, index) {
//                                         return Padding(
//                                           padding: EdgeInsets.only(right: 15.w),
//                                           child: InkWell(
//                                             onTap: () {
//                                               FocusScope.of(context).unfocus();
//                                               home.updateSelextedStarId(
//                                                 starid:
//                                                     home
//                                                         .starsResponse
//                                                         ?.data![index]
//                                                         .id,
//                                                 starname:
//                                                     home
//                                                         .starsResponse
//                                                         ?.data![index]
//                                                         .nameEng,
//                                               );
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(12.r),
//                                                 color:
//                                                     home.selectedStarId ==
//                                                             home
//                                                                 .starsResponse
//                                                                 ?.data![index]
//                                                                 .id
//                                                         ? Colors.black
//                                                             .withOpacity(0.5)
//                                                         : Colors.white,
//                                                 border: Border.all(
//                                                   color: HexColor("#D2D2D2"),
//                                                 ),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   widget.lanid == 1
//                                                       ? "${home.starsResponse?.data![index].nameEng}"
//                                                       : "${home.starsResponse?.data![index].nameMal}",
//                                                   style:
//                                                       home.selectedStarId !=
//                                                               home
//                                                                   .starsResponse
//                                                                   ?.data![index]
//                                                                   .id
//                                                           ? Fontpalette
//                                                               .black52700
//                                                           : Fontpalette
//                                                               .white52700,
//                                                 ).horizontalPadding(30.w),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   10.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Select diety",
//                                         style: Fontpalette.blackinter40400,
//                                       ),
//                                     ],
//                                   ),
//                                   5.verticalSpace,
//                                   SizedBox(
//                                     height: 65.h,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount:
//                                           home.deitiesResponse?.data?.length ??
//                                           0,
//                                       itemBuilder: (context, index) {
//                                         return Padding(
//                                           padding: EdgeInsets.only(right: 30.w),
//                                           child: InkWell(
//                                             onTap: () {
//                                               FocusScope.of(context).unfocus();
//                                               home.updateDietyId(
//                                                 id:
//                                                     home
//                                                         .deitiesResponse
//                                                         ?.data![index]
//                                                         .id,
//                                                 name:
//                                                     home
//                                                         .deitiesResponse
//                                                         ?.data![index]
//                                                         .name,
//                                               );
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 Expanded(
//                                                   child: Stack(
//                                                     children: [
//                                                       Container(
//                                                         width: 200.w,
//                                                         decoration: BoxDecoration(
//                                                           color: Colors.black,
//                                                           borderRadius:
//                                                               BorderRadius.circular(
//                                                                 27.r,
//                                                               ),
//                                                           image: DecorationImage(
//                                                             image: AssetImage(
//                                                               "assets/images/pooja.png",
//                                                             ),
//                                                             fit: BoxFit.cover,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       if (home.dietyId ==
//                                                           home
//                                                               .deitiesResponse
//                                                               ?.data![index]
//                                                               .id)
//                                                         Container(
//                                                           width: 200.w,
//                                                           decoration: BoxDecoration(
//                                                             color: Colors.black
//                                                                 .withOpacity(
//                                                                   0.5,
//                                                                 ), // semi-transparent black
//                                                             borderRadius:
//                                                                 BorderRadius.circular(
//                                                                   27.r,
//                                                                 ),
//                                                           ),
//                                                         ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 5.verticalSpace,
//                                                 Text(
//                                                   widget.lanid == 1
//                                                       ? "${home.deitiesResponse?.data![index].name}"
//                                                       : "${home.deitiesResponse?.data![index].nameMal}",
//                                                   style: Fontpalette.black45600,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   10.verticalSpace,
//                                   home.dietyIName == "DONATION"
//                                       ? Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Amount",
//                                             style: Fontpalette.blackinter40400,
//                                           ),
//                                           5.verticalSpace,
//                                           Container(
//                                             height: 50.h,

//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(21.r),
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             child: TextField(
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               controller: amt,
//                                               style:
//                                                   Fontpalette.blackinter45400,
//                                               textAlignVertical:
//                                                   TextAlignVertical.center,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     EdgeInsets.symmetric(
//                                                       vertical: 15.h,
//                                                       horizontal: 40.w,
//                                                     ),

//                                                 hintText: " ",
//                                                 hintStyle:
//                                                     Fontpalette.blackinter24400,
//                                                 border: InputBorder.none,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                       : home.len > 15
//                                       ? SizedBox(
//                                         height: 400.h,
//                                         child: Listpooja(
//                                           len: home.len,
//                                           lanid: widget.lanid,
//                                         ),
//                                       )
//                                       : Listpooja(
//                                         len: home.len,
//                                         lanid: widget.lanid,
//                                       ),
//                                   10.verticalSpace,
//                                   Container(
//                                     height: 2.h,
//                                     color: HexColor("#D97000"),
//                                   ),
//                                   15.verticalSpace,
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       InkWell(
//                                         onTap: () async {
//                                           if (name.text.isEmpty) {
//                                             Helpers.successToast(
//                                               "Please enter your name",
//                                             );
//                                             return;
//                                           }
//                                           if (home.selectedStarId == null) {
//                                             Helpers.successToast(
//                                               "Please select your star",
//                                             );
//                                             return;
//                                           }
//                                           if (home.selectedPoojaId == null &&
//                                               home.dietyIName != "DONATION") {
//                                             Helpers.successToast(
//                                               "Please a pooja",
//                                             );
//                                             return;
//                                           }
//                                           if (amt.text.isEmpty &&
//                                               home.dietyIName == "DONATION") {
//                                             Helpers.successToast(
//                                               "Please enter the amount",
//                                             );
//                                             return;
//                                           }
//                                           FocusScope.of(context).unfocus();
//                                           await home.addToPoojaDetails(
//                                             name: name.text,
//                                             star: home.selectedStarrname,
//                                             date: home.dateapi,
//                                             dietyid: home.dietyId,
//                                             diety: home.dietyIName,

//                                             poojaname: home.selectedPoojaName,
//                                             poojaid: home.selectedPoojaId,

//                                             rate:
//                                                 home.dietyIName == "DONATION"
//                                                     ? amt.text
//                                                     : home.selectedpoojarate,
//                                             starid: home.selectedStarId,
//                                           );
//                                           home.clearStoredData();
//                                           name.clear();
//                                           amt.clear();
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: HexColor("#FDEFD3"),
//                                             borderRadius: BorderRadius.circular(
//                                               33.r,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             "Add more person",
//                                             style: Fontpalette.blackinter40400,
//                                           ).symmetricPadding(
//                                             vertical: 10.h,
//                                             horizontal: 50.w,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ).horizontalPadding(60.w).verticalPadding(20.h),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [],
//                             ),
//                             ValueListenableBuilder<bool>(
//                               valueListenable: isEnabled,
//                               builder:
//                                   (context, value, child) => InkWell(
//                                     onTap: () async {
//                                       if (home.pooja.isEmpty) {
//                                         print("no pooja added");
//                                         if (name.text.isEmpty) {
//                                           Helpers.successToast(
//                                             "Please enter your name",
//                                           );
//                                           return;
//                                         }
//                                         if (home.selectedStarId == null) {
//                                           Helpers.successToast(
//                                             "Please select your star",
//                                           );
//                                           return;
//                                         }
//                                         if (home.selectedPoojaId == null &&
//                                             home.dietyIName != "DONATION") {
//                                           Helpers.successToast(
//                                             "Please a pooja",
//                                           );
//                                           return;
//                                         }
//                                         if (amt.text.isEmpty &&
//                                             home.dietyIName == "DONATION") {
//                                           Helpers.successToast(
//                                             "Please enter the amount",
//                                           );
//                                           return;
//                                         }
//                                         isEnabled.value = true;
//                                         await home.addToPoojaDetails(
//                                           name: name.text,
//                                           diety: home.dietyIName,
//                                           star: home.selectedStarrname,

//                                           poojaname: home.selectedPoojaName,
//                                           date: home.dateapi,
//                                           dietyid: home.dietyId,

//                                           poojaid: home.selectedPoojaId,

//                                           rate:
//                                               home.dietyIName == "DONATION"
//                                                   ? amt.text
//                                                   : home.selectedpoojarate,
//                                           starid: home.selectedStarId,
//                                         );

//                                         await home.getPreviewBill(
//                                           onSuccess: () async {
//                                             navigatescrren(
//                                               page: PreviewScreen(),
//                                               context: context,
//                                             );
//                                             home.clearStoredData();
//                                             name.clear();
//                                             amt.clear();
//                                             isEnabled.value = false;
//                                           },
//                                           onFailure: () {
//                                             isEnabled.value = false;
//                                           },
//                                         );
//                                       } else {
//                                         print(" pooja added");
//                                         isEnabled.value = true;
//                                         if (name.text.isNotEmpty &&
//                                             home.selectedStarId != null) {
//                                           if (home.selectedPoojaId == null &&
//                                                   home.dietyIName ==
//                                                       "DONATION" ||
//                                               home.selectedPoojaId != null) {
//                                             await home.addToPoojaDetails(
//                                               name: name.text,
//                                               diety: home.dietyIName,
//                                               star: home.selectedStarrname,

//                                               poojaname: home.selectedPoojaName,
//                                               poojaid: home.selectedPoojaId,
//                                               date: home.dateapi,
//                                               dietyid: home.dietyId,
//                                               rate:
//                                                   home.dietyIName == "DONATION"
//                                                       ? amt.text
//                                                       : home.selectedpoojarate,
//                                               starid: home.selectedStarId,
//                                             );
//                                           }
//                                         }
//                                         await home.getPreviewBill(
//                                           onSuccess: () async {
//                                             navigatescrren(
//                                               page: PreviewScreen(),
//                                               context: context,
//                                             );
//                                             amt.clear();
//                                             home.clearStoredData();
//                                             name.clear();
//                                             isEnabled.value = false;
//                                           },
//                                           onFailure: () {
//                                             isEnabled.value = false;
//                                           },
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                           27.r,
//                                         ),
//                                         color: HexColor("#EC5002"),
//                                       ),
//                                       child:
//                                           isEnabled.value == true
//                                               ? CircularProgressIndicator(
//                                                 color: Colors.white,
//                                               ).horizontalPadding(190.w)
//                                               : Text(
//                                                 "Continue",
//                                                 style: Fontpalette.white50700,
//                                               ).symmetricPadding(
//                                                 vertical: 18.h,
//                                                 horizontal: 150.w,
//                                               ),
//                                     ),
//                                   ),
//                             ),
//                           ],
//                         ),
//                         20.verticalSpace,
//                         Text(
//                           "www.punnyamtemplesuite.com",
//                           style: Fontpalette.brown30600,
//                         ),
//                       ],
//                     ).horizontalPadding(100.w),
//                   ],
//                 ).horizontalPadding(90.w).topPadding(40.h).bottomPadding(5.h);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Listpooja extends StatelessWidget {
//   const Listpooja({super.key, this.len = 0, this.lanid});
//   final int? len;
//   final int? lanid;
//   @override
//   Widget build(BuildContext context) {
//     final ScrollController scrollController =
//         ScrollController(); // Place this in your State class

//     return Consumer<HomeProvider>(
//       builder:
//           (context, home, child) =>
//               home.poojaload == LoaderState.loading
//                   ? SizedBox()
//                   : Scrollbar(
//                     controller: scrollController,
//                     thumbVisibility: true,
//                     child: GridView.count(
//                       controller: scrollController,
//                       crossAxisCount: 3,
//                       childAspectRatio: 400.w / 80.h,
//                       mainAxisSpacing: 10.h,
//                       crossAxisSpacing: 10.w,
//                       shrinkWrap: len! <= 15,
//                       physics:
//                           len! > 15
//                               ? AlwaysScrollableScrollPhysics()
//                               : NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.all(8.w),
//                       children: List.generate(len ?? 0, (index) {
//                         final item = home.poojaResponse!.data![index];
//                         return InkWell(
//                           onTap: () {
//                             FocusScope.of(context).unfocus();
//                             home.updateSelextedPoojaId(
//                               poojaname: item.name,
//                               poojaid: item.poojaId,
//                               rate: item.rate,
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color:
//                                   home.selectedPoojaId == item.poojaId
//                                       ? Colors.black.withOpacity(0.5)
//                                       : Colors.white,
//                               border: Border.all(color: HexColor("#D2D2D2")),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               vertical: 8.h,
//                               horizontal: 5.w,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   lanid == 1
//                                       ? item.name ?? ''
//                                       : item.nameMal ?? '',
//                                   textAlign: TextAlign.center,

//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 5,
//                                   style:
//                                       home.selectedPoojaId == item.poojaId
//                                           ? Fontpalette.white45600
//                                           : Fontpalette.black45600,
//                                 ),
//                                 3.verticalSpace,
//                                 Text(
//                                   "₹ ${item.rate}",
//                                   style:
//                                       home.selectedPoojaId == item.poojaId
//                                           ? Fontpalette.white38500
//                                           : Fontpalette.black38500,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/color_pallatte.dart';
import 'package:kiosk/extension.dart';
import 'package:kiosk/fontpallate.dart';
import 'package:kiosk/provider/homeprovider.dart';
import 'package:kiosk/services/helpers.dart';
import 'package:kiosk/services/provider_helper_class.dart';
import 'package:kiosk/view/billpreview.dart';
import 'package:kiosk/view/homepage.dart';
import 'package:provider/provider.dart';

class Bookpoojascreen extends StatefulWidget {
  const Bookpoojascreen({super.key, this.lanid, this.isDonate = false});
  final int? lanid;
  final bool isDonate;
  @override
  State<Bookpoojascreen> createState() => _BookpoojascreenState();
}

class _BookpoojascreenState extends State<Bookpoojascreen> {
  TextEditingController name = TextEditingController();
  TextEditingController amt = TextEditingController();
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final home = context.read<HomeProvider>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      home.updateSelectedDate(date: picked);
    }
  }

  final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(false);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final home = context.read<HomeProvider>();
      if (widget.isDonate) {
        //home.updateDietyId(id: null, name: "DONATION");
        home.updateDietyId(id: 8, name: "DONATION");
        home.updateSelextedPoojaId(poojaname: "DONATION", poojaid: 29, rate: null);

      } else {
        if (home.deitiesResponse?.data != null && home.deitiesResponse!.data!.isNotEmpty) {
          final firstDeity = home.deitiesResponse!.data!.first;
          home.updateDietyId(id: firstDeity.id, name: firstDeity.name);
          home.updateSelextedPoojaId(poojaid: null, poojaname: null, rate: null);
        }
      }
    });
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name",
                                              style:
                                                  Fontpalette.blackinter40400,
                                            ),
                                            5.verticalSpace,
                                            Container(
                                              height: 50.h,

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.r),
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: TextField(
                                                controller: name,
                                                style:
                                                    Fontpalette.blackinter45400,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        vertical: 15.h,
                                                        horizontal: 40.w,
                                                      ),

                                                  hintText: " ",
                                                  hintStyle:
                                                      Fontpalette
                                                          .blackinter24400,
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      30.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Choose date",
                                            style: Fontpalette.blackinter40400,
                                          ),
                                          5.verticalSpace,
                                          InkWell(
                                            onTap: () => pickDate(),
                                            child: Container(
                                              height: 50.h,
                                              width: 500.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.r),
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    home.selecteddate ?? '',
                                                    style:
                                                        Fontpalette
                                                            .blackinter45400,
                                                  ).horizontalPadding(40.w),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    children: [
                                      Text(
                                        "Select star",
                                        style: Fontpalette.blackinter40400,
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  SizedBox(
                                    height: 35.h,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          home.starsResponse?.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 15.w),
                                          child: InkWell(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              home.updateSelextedStarId(
                                                starid:
                                                    home
                                                        .starsResponse
                                                        ?.data![index]
                                                        .id,
                                                starname:
                                                    home
                                                        .starsResponse
                                                        ?.data![index]
                                                        .nameEng,
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color:
                                                    home.selectedStarId ==
                                                            home
                                                                .starsResponse
                                                                ?.data![index]
                                                                .id
                                                        ? Colors.black
                                                            .withOpacity(0.5)
                                                        : Colors.white,
                                                border: Border.all(
                                                  color: HexColor("#D2D2D2"),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  widget.lanid == 1
                                                      ? "${home.starsResponse?.data![index].nameEng}"
                                                      : "${home.starsResponse?.data![index].nameMal}",
                                                  style:
                                                      home.selectedStarId !=
                                                              home
                                                                  .starsResponse
                                                                  ?.data![index]
                                                                  .id
                                                          ? Fontpalette
                                                              .black52700
                                                          : Fontpalette
                                                              .white52700,
                                                ).horizontalPadding(30.w),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (!widget.isDonate) ...[
                                    Row(
                                      children: [
                                        Text(
                                          "Select diety",
                                          style: Fontpalette.blackinter40400,
                                        ),
                                      ],
                                    ),
                                    5.verticalSpace,
                                    Builder(
                                      builder: (context) {
                                        final filteredDeities = (home.deitiesResponse?.data ?? [])
                                            .where((d) => d.name?.toUpperCase() != "DONATION")
                                            .toList();
                                        return SizedBox(
                                          height: 65.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: filteredDeities.length,
                                            itemBuilder: (context, index) {
                                              final deity = filteredDeities[index];
                                              return Padding(
                                                padding: EdgeInsets.only(right: 30.w),
                                                child: InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context).unfocus();
                                                    home.updateDietyId(
                                                      id: deity.id,
                                                      name: deity.name,
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: 200.w,
                                                              decoration: BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius:
                                                                    BorderRadius.circular(27.r),
                                                                image: DecorationImage(
                                                                  image: AssetImage(
                                                                    "assets/images/pooja.png",
                                                                  ),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                            if (home.dietyId == deity.id)
                                                              Container(
                                                                width: 200.w,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.black
                                                                      .withOpacity(0.5),
                                                                  borderRadius:
                                                                      BorderRadius.circular(27.r),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      Text(
                                                        widget.lanid == 1
                                                            ? "${deity.name}"
                                                            : "${deity.nameMal}",
                                                        style: Fontpalette.black45600,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                  10.verticalSpace,
                                  home.dietyIName == "DONATION"
                                      ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: Fontpalette.blackinter40400,
                                          ),
                                          5.verticalSpace,
                                          Container(
                                            height: 50.h,

                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21.r),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: 
                                            // TextField(
                                            //   keyboardType:
                                            //       TextInputType.numberWithOptions(decimal: true),
                                            //   controller: amt,
                                            //   style:
                                            //       Fontpalette.blackinter45400,
                                            //   textAlignVertical:
                                            //       TextAlignVertical.center,
                                            //   decoration: InputDecoration(
                                            //     isDense: true,
                                            //     contentPadding:
                                            //         EdgeInsets.symmetric(
                                            //           vertical: 15.h,
                                            //           horizontal: 40.w,
                                            //         ),

                                            //     hintText: " ",
                                            //     hintStyle:
                                            //         Fontpalette.blackinter24400,
                                            //     border: InputBorder.none,
                                            //   ),
                                            // ),

                                            TextField(
                                              keyboardType:
                                                  TextInputType.numberWithOptions(decimal: true),
                                                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              controller: amt,
                                              style:
                                                  Fontpalette.blackinter45400,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 40.w,
                                                    ),

                                                hintText: " ",
                                                hintStyle:
                                                    Fontpalette.blackinter24400,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      : home.len > 15
                                      ? SizedBox(
                                        height: 400.h,
                                        child: Listpooja(
                                          len: home.len,
                                          lanid: widget.lanid,
                                        ),
                                      )
                                      : Listpooja(
                                        len: home.len,
                                        lanid: widget.lanid,
                                      ),
                                  10.verticalSpace,
                                  Container(
                                    height: 2.h,
                                    color: HexColor("#D97000"),
                                  ),
                                  15.verticalSpace,
                                  if (!widget.isDonate)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (name.text.isEmpty) {
                                            Helpers.successToast(
                                              "Please enter your name",
                                            );
                                            return;
                                          }
                                          if (home.selectedStarId == null) {
                                            Helpers.successToast(
                                              "Please select your star",
                                            );
                                            return;
                                          }
                                          if (home.selectedPoojaId == null &&
                                              home.dietyIName != "DONATION") {
                                            Helpers.successToast(
                                              "Please a pooja",
                                            );
                                            return;
                                          }
                                          if (amt.text.isEmpty &&
                                              home.dietyIName == "DONATION") {
                                            Helpers.successToast(
                                              "Please enter the amount",
                                            );
                                            return;
                                          }
                                          if (home.dietyIName == "DONATION") {
                                            final enteredAmount =
                                                double.tryParse(amt.text);
                                            if (enteredAmount == null ||
                                                enteredAmount <= 0) {
                                              Helpers.successToast(
                                                "Please enter a valid  amount",
                                              );
                                              return;
                                            }
                                          }
                                          FocusScope.of(context).unfocus();
                                          await home.addToPoojaDetails(
                                            name: name.text,
                                            star: home.selectedStarrname,
                                            date: home.dateapi,
                                            dietyid: home.dietyId,
                                            diety: home.dietyIName,

                                            poojaname: home.selectedPoojaName,
                                            poojaid: home.selectedPoojaId,

                                            rate:
                                                home.dietyIName == "DONATION"
                                                    ? amt.text
                                                    : home.selectedpoojarate,
                                            starid: home.selectedStarId,
                                          );
                                          home.clearStoredData();
                                          name.clear();
                                          amt.clear();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor("#FDEFD3"),
                                            borderRadius: BorderRadius.circular(
                                              33.r,
                                            ),
                                          ),
                                          child: Text(
                                            "Add more person",
                                            style: Fontpalette.blackinter40400,
                                          ).symmetricPadding(
                                            vertical: 10.h,
                                            horizontal: 50.w,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).horizontalPadding(60.w).verticalPadding(20.h),
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
                                      if (widget.isDonate) {
                                        home.clearGrossAmount();
                                      }
                                      if (home.pooja.isEmpty) {
                                        print("no pooja added");
                                        if (name.text.isEmpty) {
                                          Helpers.successToast(
                                            "Please enter your name",
                                          );
                                          return;
                                        }
                                        if (home.selectedStarId == null) {
                                          Helpers.successToast(
                                            "Please select your star",
                                          );
                                          return;
                                        }
                                        if (home.selectedPoojaId == null &&
                                            home.dietyIName != "DONATION") {
                                          Helpers.successToast(
                                            "Please a pooja",
                                          );
                                          return;
                                        }
                                        if (amt.text.isEmpty &&
                                            home.dietyIName == "DONATION") {
                                          Helpers.successToast(
                                            "Please enter the amount",
                                          );
                                          return;
                                        }
                                        if (home.dietyIName == "DONATION") {
                                              final enteredAmount =
                                                  double.tryParse(amt.text);
                                              if (enteredAmount == null ||
                                                  enteredAmount <= 0) {
                                                Helpers.successToast(
                                                  "Please enter a valid  amount",
                                                );
                                                return;
                                              }
                                            }
                                        isEnabled.value = true;
                                        await home.addToPoojaDetails(
                                          name: name.text,
                                          diety: home.dietyIName,
                                          star: home.selectedStarrname,

                                          poojaname: home.selectedPoojaName,
                                          date: home.dateapi,
                                          dietyid: home.dietyId,

                                          poojaid: home.selectedPoojaId,

                                          rate:
                                              home.dietyIName == "DONATION"
                                                  ? amt.text
                                                  : home.selectedpoojarate,
                                          starid: home.selectedStarId,
                                        );

                                        await home.getPreviewBill(
                                          onSuccess: () async {
                                            navigatescrren(
                                              page: PreviewScreen(),
                                              context: context,
                                            );
                                            home.clearStoredData();
                                            name.clear();
                                            amt.clear();
                                            isEnabled.value = false;
                                          },
                                          onFailure: () {
                                            isEnabled.value = false;
                                          },
                                        );
                                      } else {
                                        print(" pooja added");
                                        isEnabled.value = true;
                                        if (name.text.isNotEmpty &&
                                            home.selectedStarId != null) {
                                          if (home.selectedPoojaId == null &&
                                                  home.dietyIName ==
                                                      "DONATION" ||
                                              home.selectedPoojaId != null) {
                                            await home.addToPoojaDetails(
                                              name: name.text,
                                              diety: home.dietyIName,
                                              star: home.selectedStarrname,

                                              poojaname: home.selectedPoojaName,
                                              poojaid: home.selectedPoojaId,
                                              date: home.dateapi,
                                              dietyid: home.dietyId,
                                              rate:
                                                  home.dietyIName == "DONATION"
                                                      ? amt.text
                                                      : home.selectedpoojarate,
                                              starid: home.selectedStarId,
                                            );
                                          }
                                        }
                                        await home.getPreviewBill(
                                          onSuccess: () async {
                                            navigatescrren(
                                              page: PreviewScreen(),
                                              context: context,
                                            );
                                            amt.clear();
                                            home.clearStoredData();
                                            name.clear();
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
                ).horizontalPadding(90.w).topPadding(40.h).bottomPadding(5.h);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Listpooja extends StatelessWidget {
  const Listpooja({super.key, this.len = 0, this.lanid});
  final int? len;
  final int? lanid;
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
        ScrollController(); // Place this in your State class

    return Consumer<HomeProvider>(
      builder:
          (context, home, child) =>
              home.poojaload == LoaderState.loading
                  ? SizedBox()
                  : Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    child: GridView.count(
                      controller: scrollController,
                      crossAxisCount: 3,
                      childAspectRatio: 400.w / 80.h,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      shrinkWrap: len! <= 15,
                      physics:
                          len! > 15
                              ? AlwaysScrollableScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(8.w),
                      children: List.generate(len ?? 0, (index) {
                        final item = home.poojaResponse!.data![index];
                        return InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            home.updateSelextedPoojaId(
                              poojaname: item.name,
                              poojaid: item.poojaId,
                              rate: item.rate,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  home.selectedPoojaId == item.poojaId
                                      ? Colors.black.withOpacity(0.5)
                                      : Colors.white,
                              border: Border.all(color: HexColor("#D2D2D2")),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 5.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lanid == 1
                                      ? item.name ?? ''
                                      : item.nameMal ?? '',
                                  textAlign: TextAlign.center,

                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style:
                                      home.selectedPoojaId == item.poojaId
                                          ? Fontpalette.white45600
                                          : Fontpalette.black45600,
                                ),
                                3.verticalSpace,
                                Text(
                                  "₹ ${item.rate}",
                                  style:
                                      home.selectedPoojaId == item.poojaId
                                          ? Fontpalette.white38500
                                          : Fontpalette.black38500,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
    );
  }
}