import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List<Widget> screens = [
    HomePage(),
    Explore(),
    Posts(),
    FollowingPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0;
  void onClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.theme.appBarColor,
        onTap: onClick,
        currentIndex: _selectedIndex,
        selectedItemColor: context.theme.primaryColor,
        unselectedItemColor: context.theme.greyColor,
        selectedLabelStyle: TextStyle(fontSize: 12, color: context.theme.primaryColor),
        unselectedLabelStyle: TextStyle(color: context.theme.greyColor),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 0,
        // This is for any unseen rendered box
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home),),
          BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.directions_walk),),
          BottomNavigationBarItem(label: 'Post', icon: CustomIcon(Icons.add, 2),),
          BottomNavigationBarItem(label: 'People', icon: Icon(Icons.people_alt),),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person),),
        ],
      ),
    );
    // return DefaultTabController(
    //   length: _icons.length,
    //   child: Scaffold(
    //     body: TabBarView(
    //       physics: NeverScrollableScrollPhysics(),
    //       children: _screens,
    //     ),
    //     bottomNavigationBar: CustomTabBar(
    //       icons: _icons,
    //       selectedIndex:  _selectedIndex,
    //       onTap: (index) => setState(() => _selectedIndex = index),
    //     ),
    //   )
    // );
  }

  Widget CustomIcon(IconData icon, int index) {
    return Container(
      width: 60,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFFFD6104), Color(0xFFFD8502), Color(0xFFFFC203)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          tileMode: TileMode.clamp
        ),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, size: 18,),
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          color: Colors.white,
        ),
      ),
    );
  }
}
