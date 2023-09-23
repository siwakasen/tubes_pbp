import 'package:flutter/material.dart';
import 'package:ugd2_pbp/data/people.dart';

class ListNamaView extends StatefulWidget {
  const ListNamaView({super.key});

  @override
  State<ListNamaView> createState() => _ListNamaViewState();
}

class _ListNamaViewState extends State<ListNamaView> {
  Color appBarColor = Colors.blue;
  Color bodyColor = Colors.white;
  Color fontColor = Colors.black;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: bodyColor,
        appBar: AppBar(
          title: const Text("Daftar Nama"),
          backgroundColor: appBarColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.sunny),
              tooltip: 'Show Snackbar',
              onPressed: () {
                setState(() {
                  if (isDarkMode) {
                    appBarColor = Colors.blue;
                    bodyColor = Colors.white;
                    fontColor = Colors.black;
                  } else {
                    appBarColor = Colors.black;
                    bodyColor = const Color.fromARGB(115, 93, 93, 93);
                    fontColor = Colors.white;
                  }

                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return WideLayout(
              fontColor: fontColor,
            );
          } else {
            return NarrowLayout(
              fontColor2: fontColor,
            );
          }
        }),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final Color fontColor2;
  const NarrowLayout({super.key, required this.fontColor2});
  @override
  Widget build(BuildContext context) {
    return PeopleList(
      fontColor: fontColor2,
      onPersonTap: (person) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: PersonDetail(person),
          ),
        ),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  final Color fontColor;
  const WideLayout({super.key, required this.fontColor});

  @override
  State<WideLayout> createState() => _WideLayoutState(fontColor);
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;
  Color fontColor;
  _WideLayoutState(this.fontColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PeopleList(
              fontColor: fontColor,
              onPersonTap: (person) => setState(() => _person = person),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _person == null ? const Placeholder() : PersonDetail(_person!),
        ),
      ],
    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) onPersonTap;
  final Color fontColor;
  const PeopleList(
      {super.key, required this.onPersonTap, required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (var person in people)
        ListTile(
          leading: Image.network(person.picture),
          title: Text(person.name, style: TextStyle(color: fontColor)),
          onTap: () => onPersonTap(person),
        ),
    ]);
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      return Center(
        child: boxConstraints.maxHeight > 200
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    onHover: (_) => {print("Hello World")},
                    child: Text(person.name),
                  ),
                  Text(person.phone),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Contact Me"),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MouseRegion(
                    onHover: (_) => {print("Hello World")},
                    child: Text(person.name),
                  ),
                  Text(person.name),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Contact Me"),
                  ),
                ],
              ),
      );
    });
  }
}
