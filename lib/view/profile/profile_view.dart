import 'package:flutter/material.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/component/dark_mode_state.dart' as globals;
import 'package:ugd2_pbp/model/user.dart';
import 'package:ugd2_pbp/view/profile/profile_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  List<Map<String, dynamic>> users = [];

  User user = User();
  late int userId;
  void refresh() async {
    final data = await SQLHelper.getuser();
    userId = await getIntValuesSF();
    setState(() {
      users = data;
      for (var tempUser in users) {
        if (userId == tempUser['id']) {
          user.username = tempUser['username'];
          user.email = tempUser['email'];
          user.password = tempUser['password'];
          user.name = tempUser['name'];
          user.address = tempUser['address'];
          user.phoneNumber = tempUser['phoneNumber'];
          user.bornDate = tempUser['bornDate'];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/riksi.jpeg'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', user.name, const Icon(Icons.face)),
            const SizedBox(height: 10),
            itemProfile('Username', user.username, const Icon(Icons.person)),
            const SizedBox(height: 10),
            itemProfile('Phone', user.phoneNumber, const Icon(Icons.phone)),
            const SizedBox(height: 10),
            itemProfile('Address', user.address, const Icon(Icons.home)),
            const SizedBox(height: 10),
            itemProfile('Email', user.email, const Icon(Icons.email)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    pushEditView(context, widget);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Edit Profile')),
            )
          ],
        ),
      ),
    );
  }

  void pushEditView(BuildContext context, ProfileView widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileEdit(),
      ),
    );
  }

  //profile function
  itemProfile(String title, String subtitle, Icon icon) {
    return Container(
      decoration: BoxDecoration(
          color: globals.isDarkMode ? Colors.black12 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: globals.isDarkMode ? Colors.black54 : Colors.amber[600]!,
                spreadRadius: 2,
                blurRadius: 2)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: icon,
        tileColor: globals.isDarkMode ? Colors.black54 : Colors.white,
      ),
    );
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}
