import 'package:flutter/material.dart';
import 'package:keynes/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_assets.dart';

class MainContainer extends StatefulWidget {
  MainContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[HomeScreen()];

  void _onItemTapped(int index) async {
    if (index == 2) {
      // Handle logout
      await _handleLogout();
    } else {
      // Handle other navigation
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  initState() {
    super.initState();
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     // print('state l $state');

  //     if (AppLifecycleState.detached == state && navBack == false) {
  //       baseCtrl.player.stop();
  //       // print(
  //       //     ' audioplayer state ${baseCtrl.audioHandler.playbackState.value} ');
  //       // print(' playerState  ${baseCtrl.player.playerState} ');
  //     }
  //   });
  // }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.serviceImg,
                height: 20.0,
              ),
              //icon: Icon(Icons.book),
              label: 'Service',
            ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     AppAssets.bookmarkIcon,
            //   ),
            //   //  icon: Icon(Icons.add),
            //   label: 'Add Cars',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login), // Correct logout icon
              label: 'Login',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
