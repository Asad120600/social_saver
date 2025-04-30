import 'dart:async';
import 'package:flutter/material.dart';
import 'package:social_saver/views/video_downloader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => VideoDownloaderScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3C1053), // Top purple tone
              Color(0xFF2B2D42), // Bottom dark tone
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with background image
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage("assets/icons/bg.png"), 
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icons/icon.png",
                    width: 100,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Quick Saver',
                style: TextStyle(
                  fontFamily: 'RacingSansOne',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
