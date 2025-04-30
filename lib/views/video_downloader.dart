// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:social_saver/helpers/ad_helper.dart';
// import 'package:social_saver/helpers/languages_dropdown.dart';
// import 'package:social_saver/helpers/video_download_helper.dart';
// import 'package:social_saver/views/download_dialog.dart';
// import 'package:flutter/services.dart';

// class VideoDownloaderScreen extends StatefulWidget {
//   const VideoDownloaderScreen({super.key});

//   @override
//   _VideoDownloaderScreenState createState() => _VideoDownloaderScreenState();
// }

// class _VideoDownloaderScreenState extends State<VideoDownloaderScreen> {
//   TextEditingController urlController = TextEditingController();
//   bool isLoading = false;
//   String? downloadLink;
//   bool isPasted = false;

//   @override
//   void initState() {
//     super.initState();
//     AdHelper.loadBannerAd();
//     AdHelper.loadInterstitialAd();
//   }

//   Future<void> fetchVideoData(String videoUrl) async {
//     if (videoUrl.isEmpty) {
//       showMessage("invalid_url".tr);
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       downloadLink = null;
//     });

//     final link = await fetchDownloadLink(videoUrl);

//     setState(() {
//       isLoading = false;
//       if (link != null) {
//         downloadLink = link;
//         showDialog(
//           context: context,
//           builder: (context) => DownloadDialog(downloadLink: downloadLink!),
//         );
//       } else {
//         showMessage("download_failed".tr);
//       }
//     });
//   }

//   void showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Builder(builder: (BuildContext context) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF3C1053), Color(0xFF2B2D42)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.01,
//                       vertical: screenHeight * 0.02,
//                     ),
//                     child: Row(
//                       children: [
//                         Image.asset("assets/icons/icon.png",
//                             width: screenWidth * 0.10),
//                         SizedBox(width: screenWidth * 0.01),
//                         Text(
//                           "app_title".tr,
//                           style: TextStyle(
//                             fontFamily: 'RacingSansOne',
//                             fontSize: screenWidth * 0.06,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Spacer(),
//                         buildLanguageDropdown(),
//                         SizedBox(
//                           width: screenWidth * 0.02,
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Expanded(
//                     child: Container(
//                       margin:
//                           EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.white.withOpacity(0.05),
//                             Colors.white.withOpacity(0.1)
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             right: 0,
//                             height: screenHeight * 0.4,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 image: DecorationImage(
//                                   image: AssetImage("assets/background.png"),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               SizedBox(height: screenHeight * 0.015),
//                               Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "${"app_subtitle".tr}\n",
//                                       style: GoogleFonts.raleway(
//                                         fontSize: screenWidth * 0.06,
//                                         fontStyle: FontStyle.italic,
//                                         color: Colors.white,
//                                         height: 1.3,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: "downloader".tr,
//                                       style: GoogleFonts.raleway(
//                                         fontSize: screenWidth * 0.08,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                         height: 1.3,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               SizedBox(height: screenHeight * 0.01),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth * 0.05),
//                                 child: Text(
//                                   "app_description".tr,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: screenWidth * 0.049,
//                                     color: Colors.white,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               SizedBox(height: screenHeight * 0.04),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth * 0.05),
//                                 child: StatefulBuilder(
//                                   builder: (context, setState) {
//                                     return TextField(
//                                       controller: urlController,
//                                       style: TextStyle(color: Colors.black),
//                                       onChanged: (text) {
//                                         setState(
//                                             () {}); // Rebuild to show/hide the clear icon
//                                       },
//                                       decoration: InputDecoration(
//                                         hintText: "insert_link_hint".tr,
//                                         hintStyle: TextStyle(
//                                             color: Colors.grey.shade600),
//                                         prefixIcon: Icon(Icons.link,
//                                             color: Colors.grey),
//                                         suffixIcon:
//                                             urlController.text.isNotEmpty
//                                                 ? IconButton(
//                                                     icon: Icon(Icons.clear,
//                                                         color: Colors.grey),
//                                                     onPressed: () {
//                                                       urlController.clear();
//                                                       setState(
//                                                           () {}); // Rebuild after clearing
//                                                     },
//                                                   )
//                                                 : null,
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(25),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: screenHeight * 0.02),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth * 0.04),
//                                 child: Row(
//                                   children: [
//                                     _buildActionButton(
//                                       label:
//                                           isPasted ? "pasted".tr : "paste".tr,
//                                       icon:
//                                           isPasted ? Icons.check : Icons.paste,
//                                       color: Colors.white,
//                                       textColor: Colors.black,
//                                       onTap: () async {
//                                         ClipboardData? data =
//                                             await Clipboard.getData(
//                                                 Clipboard.kTextPlain);
//                                         if (data != null && data.text != null) {
//                                           setState(() {
//                                             urlController.text = data.text!;
//                                             isPasted = true;
//                                           });
//                                           Future.delayed(Duration(seconds: 2),
//                                               () {
//                                             if (mounted) {
//                                               setState(() {
//                                                 isPasted = false;
//                                               });
//                                             }
//                                           });
//                                         }
//                                       },
//                                     ),
//                                     SizedBox(width: 8),
//                                     _buildActionButton(
//                                       label: isLoading
//                                           ? 'Loading...'
//                                           : "download".tr,
//                                       icon: isLoading ? null : Icons.download,
//                                       color: Colors.red,
//                                       onTap: isLoading
//                                           ? null
//                                           : () {
//                                               if (urlController
//                                                   .text.isNotEmpty) {
//                                                 fetchVideoData(
//                                                     urlController.text);
//                                               }
//                                             },
//                                     ),
//                                     SizedBox(width: 8),
//                                   ],
//                                 ),
//                               ),
//                               if (downloadLink != null) ...[
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Text(
//                                   "redirecting".tr,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.greenAccent,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                               SizedBox(height: screenHeight * 0.03),
//                               Text(
//                                 "supported_platforms".tr,
//                                 style: TextStyle(color: Colors.white70),
//                               ),
//                               SizedBox(height: screenHeight * 0.015),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.only(left: screenWidth * 0.16),
//                                 child: Row(
//                                   children: [
//                                     'facebook',
//                                     'instagram',
//                                     'tiktok',
//                                     'youtube'
//                                   ]
//                                       .map((icon) => Image.asset(
//                                             'assets/icons/$icon.png',
//                                             width: screenWidth * 0.13,
//                                           ))
//                                       .toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (!isKeyboardOpen && AdHelper.isBannerAdLoaded)
//                     Container(
//                       height: AdHelper.bannerAd.size.height.toDouble(),
//                       child: AdWidget(ad: AdHelper.bannerAd),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }));
//   }

//   Widget _buildActionButton({
//     required String label,
//     IconData? icon,
//     required Color color,
//     Color textColor = Colors.white,
//     required VoidCallback? onTap,
//   }) {
//     return Expanded(
//       child: ElevatedButton.icon(
//         onPressed: onTap,
//         icon: icon != null
//             ? Icon(icon, size: 18, color: textColor)
//             : const SizedBox.shrink(),
//         label: Text(label, style: TextStyle(color: textColor)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     AdHelper.disposeAds(); // Dispose ads
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:social_saver/helpers/ad_helper.dart';
import 'package:social_saver/helpers/languages_dropdown.dart';
import 'package:social_saver/helpers/video_download_helper.dart';
import 'package:social_saver/views/download_dialog.dart';
import 'package:flutter/services.dart';

class VideoDownloaderScreen extends StatefulWidget {
  const VideoDownloaderScreen({super.key});

  @override
  _VideoDownloaderScreenState createState() => _VideoDownloaderScreenState();
}

class _VideoDownloaderScreenState extends State<VideoDownloaderScreen> {
  TextEditingController urlController = TextEditingController();
  bool isLoading = false;
  String? downloadLink;
  bool isPasted = false;

  @override
  void initState() {
    super.initState();
    AdHelper.loadBannerAd();
    AdHelper.loadInterstitialAd();
  }

  Future<void> fetchVideoData(String videoUrl) async {
    if (videoUrl.isEmpty) {
      showMessage("invalid_url".tr);
      return;
    }

    setState(() {
      isLoading = true;
      downloadLink = null;
    });

    final link = await fetchDownloadLink(videoUrl);

    if (link != null) {
      if (AdHelper.isInterstitialAdLoaded) {
if (AdHelper.isInterstitialAdLoaded) {
  AdHelper.showInterstitialAd();
}
      }

      setState(() {
        isLoading = false;
        downloadLink = link;
      });

      showDialog(
        context: context,
        builder: (context) => DownloadDialog(downloadLink: downloadLink!),
      );
    } else {
      setState(() => isLoading = false);
      showMessage("download_failed".tr);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3C1053), Color(0xFF2B2D42)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/icon.png", width: screenWidth * 0.10),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "app_title".tr,
                        style: TextStyle(
                          fontFamily: 'RacingSansOne',
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      buildLanguageDropdown(),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.05),
                          Colors.white.withOpacity(0.1)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: screenHeight * 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: AssetImage("assets/background.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: screenHeight * 0.015),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${"app_subtitle".tr}\n",
                                    style: GoogleFonts.raleway(
                                      fontSize: screenWidth * 0.06,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      height: 1.3,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "downloader".tr,
                                    style: GoogleFonts.raleway(
                                      fontSize: screenWidth * 0.08,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Text(
                                "app_description".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.049,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return TextField(
                                    controller: urlController,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_) => setState(() {}),
                                    decoration: InputDecoration(
                                      hintText: "insert_link_hint".tr,
                                      hintStyle: TextStyle(color: Colors.grey.shade600),
                                      prefixIcon: Icon(Icons.link, color: Colors.grey),
                                      suffixIcon: urlController.text.isNotEmpty
                                          ? IconButton(
                                              icon: Icon(Icons.clear, color: Colors.grey),
                                              onPressed: () {
                                                urlController.clear();
                                                setState(() {});
                                              },
                                            )
                                          : null,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                              child: Row(
                                children: [
                                  _buildActionButton(
                                    label: isPasted ? "pasted".tr : "paste".tr,
                                    icon: isPasted ? Icons.check : Icons.paste,
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    onTap: () async {
                                      ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
                                      if (data?.text != null) {
                                        setState(() {
                                          urlController.text = data!.text!;
                                          isPasted = true;
                                        });
                                        Future.delayed(Duration(seconds: 2), () {
                                          if (mounted) {
                                            setState(() => isPasted = false);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(width: 8),
                                  _buildActionButton(
                                    label: isLoading ? 'Loading...' : "download".tr,
                                    icon: isLoading ? null : Icons.download,
                                    color: Colors.red,
                                    onTap: isLoading
                                        ? null
                                        : () {
                                            if (urlController.text.isNotEmpty) {
                                              fetchVideoData(urlController.text);
                                            }
                                          },
                                  ),
                                ],
                              ),
                            ),
                            if (downloadLink != null) ...[
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                "redirecting".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            SizedBox(height: screenHeight * 0.03),
                            Text(
                              "supported_platforms".tr,
                              style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.2),
                              child: Row(
                                children: [
                                  'facebook',
                                  'instagram',
                                  'tiktok',
                                ].map((icon) => Image.asset(
                                      'assets/icons/$icon.png',
                                      width: screenWidth * 0.13,
                                    )).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isKeyboardOpen && AdHelper.isBannerAdLoaded)
                  Container(
                    height: AdHelper.bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: AdHelper.bannerAd),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActionButton({
    required String label,
    IconData? icon,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback? onTap,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon != null
            ? Icon(icon, size: 18, color: textColor)
            : const SizedBox.shrink(),
        label: Text(label, style: TextStyle(color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  @override
  void dispose() {
    AdHelper.disposeAds();
    super.dispose();
  }
}
