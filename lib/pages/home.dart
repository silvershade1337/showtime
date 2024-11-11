import 'package:flutter/material.dart';
import 'package:showtime/widgets/homeview.dart';
import 'package:showtime/widgets/searchview.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> views = <Widget>[
    const Text(
      'Home',
      style: optionStyle,
    ),
    const SearchView(),
  ];

  @override
  void initState() {
    super.initState();
    
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic showInfo = ModalRoute.of(context)!.settings.arguments;
    views[0] = HomeView(
      showInfo: showInfo, 
      onSearchPressed: () {
        _onItemTapped(1);
      },
    );
    return Scaffold(
      body: Center(
        child: views.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
