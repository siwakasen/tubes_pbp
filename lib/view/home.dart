import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/view.list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // selectedIndex berhubungan dengan indeks halaman pada BottomNavigationBar
  int _selectedIndex = 0;

  // Fungsi yang akan dijalankan setiap kali item pada BottomNavigationBar ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List Widget yang akan ditampilkan sesuai indeks yang dipilih.
  static const List<Widget> _widgetOptions = <Widget>[
    // Index 0
    Center(
      child: Image(image: NetworkImage('https://picsum.photos/200/300')),
    ),
    // Index 1
    ListNamaView(), // Temporary comment due to error
    // Index 2
    Center(
      child: Text('Index 3: Profile'),
    ),
  ];

  // Warna-warna untuk tema terang dan tema gelap
  Color appBarColorLight = Colors.blue;
  Color bodyColorLight = Colors.white;
  Color fontColorLight = Colors.black;

  Color appBarColorDark = Colors.black;
  Color bodyColorDark = const Color.fromARGB(115, 93, 93, 93);
  Color fontColorDark = Colors.white;

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Menentukan warna sesuai dengan mode terang atau gelap
    Color appBarColor = isDarkMode ? appBarColorDark : appBarColorLight;
    Color bodyColor = isDarkMode ? bodyColorDark : bodyColorLight;
    Color fontColor = isDarkMode ? fontColorDark : fontColorLight;

    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: appBarColor,
        scaffoldBackgroundColor: bodyColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: fontColor,
          ),
          bodyText2: TextStyle(
            color: fontColor,
          ),
        ),
      ),
      home: Scaffold(
        // Pengaturan navigasi bawah
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex, // Parameter yang menyimpan indeks dari menu bottom
          onTap: _onItemTapped, // Menjalankan fungsi onTap, yang pada dasarnya akan mengubah nilai selectedIndex dan melakukan setState sesuai indeks
        ),
        // Bagian body dari Home berdasarkan List widgetOptions sesuai indeks selectedIndex
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
