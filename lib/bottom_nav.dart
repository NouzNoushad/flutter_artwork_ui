import 'package:flutter/material.dart';

import 'home_page.dart';

class ArtworkBottomNavBar extends StatefulWidget {
  final String username;
  const ArtworkBottomNavBar({Key? key, required this.username})
      : super(key: key);

  @override
  State<ArtworkBottomNavBar> createState() => _ArtworkBottomNavBarState();
}

class _ArtworkBottomNavBarState extends State<ArtworkBottomNavBar> {
  int _currentIndex = 0;
  Widget getWidgets(index) {
    switch (index) {
      case 0:
        return HomePage(name: widget.username);
      case 1:
        return const Center(child: Text("Report"));
      case 2:
        return const Center(child: Text(""));
      case 3:
        return const Center(child: Text("Favorite"));
      case 4:
        return const Center(child: Text("Profile"));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 228, 150, 193),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 120, 48, 102),
        unselectedItemColor: Colors.white30,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "report",
          ),
          BottomNavigationBarItem(
            icon: Icon(null),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 120, 48, 102),
                Color.fromARGB(255, 249, 173, 190),
              ],
            ),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 116, 79, 117),
              Color.fromARGB(255, 228, 150, 193),
              Color.fromARGB(255, 232, 162, 200),
            ],
          ),
        ),
        child: getWidgets(_currentIndex),
      ),
    );
  }
}
