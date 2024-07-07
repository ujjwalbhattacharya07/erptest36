import 'package:flutter/material.dart';
class MyBottomAppBar extends StatefulWidget {
  @override
  _MyBottomAppBarState createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  IconData _selectedIcon = Icons.home;

  void _onIconPressed(IconData icon) {
    setState(() {
      _selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(

      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              _onIconPressed(Icons.dashboard);

              // Navigator.pushReplacementNamed(context, Routes.Pre_Dashboard_route);
            },
            icon: Icon(
              Icons.dashboard,
              color: _selectedIcon == Icons.dashboard ? Color(0Xff141414) : Colors.black45,
            ),
          ),
          // Add space between home and trophy icons
          IconButton(
            onPressed: () {
              _onIconPressed(Icons.inventory);
              // Navigator.pushReplacementNamed(context, Routes.rewards_route);
            },
            icon: Icon(
              Icons.inventory,
              color: _selectedIcon == Icons.inventory ? Color(0Xff141414): Colors.black45,
            ),
          ),
           // Add space between trophy and calendar icons
          IconButton(
            onPressed: () {
              _onIconPressed(Icons.settings);
              // Navigator.pushReplacementNamed(context, Routes.Calendar_dragdrop_route);
            },
            icon: Icon(
              Icons.settings,
              color: _selectedIcon == Icons.settings ? Color(0Xff141414) : Colors.black45,
            ),
          ),

        ],
      ),
    );
  }
}