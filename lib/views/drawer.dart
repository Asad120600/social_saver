import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_saver/views/video_downloader.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isVpnConnected = false; // VPN Connection status

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3C1053), Color(0xFF2B2D42)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header with App Logo and Title
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/icon.png",
                    width: screenWidth * 0.12, // Adjust width dynamically
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Text(
                    "app_title".tr,
                    style: TextStyle(
                      fontFamily: 'RacingSansOne',
                      fontSize: screenWidth * 0.06, // Scalable font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: ListTile(
                leading: Icon(Icons.vpn_key, color: Colors.white),
                title: Text('VPN', style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  isVpnConnected ? "Connected" : "Disconnected",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  setState(() {
                    isVpnConnected = !isVpnConnected;
                  });
                },
              ),
            ),

            // Enhanced VPN Toggle Button with improved responsiveness
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: ElevatedButton(
                  key: ValueKey<bool>(isVpnConnected),
                  onPressed: () {
                    setState(() {
                      isVpnConnected = !isVpnConnected;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isVpnConnected ? Colors.green : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.1),
                    elevation: 5, // Add shadow for depth
                  ),
                  child: Text(
                    isVpnConnected ? 'VPN Connected' : 'Connect VPN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04), // Adjust font size
                  ),
                ),
              ),
            ),

            // Add more items below if needed (use _buildDrawerItem for consistency)
            // Example:
            _buildDrawerItem(Icons.home, 'Home', () {
              // Navigate to VideoDownloaderScreen
              Get.to(VideoDownloaderScreen());
            }),
            // _buildDrawerItem(Icons.settings, 'Settings', () => { /* Handle navigation */ }),
          ],
        ),
      ),
    );
  }

  // Helper method to build a drawer item
  Widget _buildDrawerItem(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onTap: onTap,
      ),
    );
  }
}
