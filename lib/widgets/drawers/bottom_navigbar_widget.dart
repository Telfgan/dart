import 'package:flutter_front/pages/home_page.dart';
import 'package:flutter_front/pages/profile_page.dart';
import 'package:flutter_front/pages/screen/screen_auth.dart';
import 'package:flutter_front/widgets/drawers/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/settings/utils/router_utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  // create index to select from the list of route paths
  int navItemIndex = 0;
  final String token;

  CustomBottomNavBar(
      {required this.navItemIndex, required this.token, Key? key})
      : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<Widget> pages = [
    AuthScreen(),
    HomePage(
      token: "",
    ),
    ProfilePage(token: "")
  ];

  // Make a list of routes that you'll want to go to
  static final List<String> _widgetOptions = [
    APP_PAGE.auth.routeName,
    APP_PAGE.home.routeName,
    APP_PAGE.profile.routeName,
  ];

  @override
  void initState() {
    pages[2] = ProfilePage(token: widget.token);
    pages[1] = HomePage(token: widget.token);
    super.initState();
  }

// Function that handles navigation based of index received
  void _onItemTapped(int index) {
    if (index == 0) {
      //  GoRouter.of(context).goNamed(_widgetOptions[0], queryParams: {'token': widget.token});

      Navigator.of(context).pop(MaterialPageRoute(
        builder: (BuildContext context) {
          return AuthScreen();
        },
      ));
    }
    setState(() {
      widget.navItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // List of icons that represent screen.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Profile',
          ),
        ],

        currentIndex: widget.navItemIndex, // current selected index

        onTap: _onItemTapped,
      ),
      body: pages[widget.navItemIndex],
    );
  }
}
