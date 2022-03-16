import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'localpersitance.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(210, 61, 41, .1),
  100: const Color.fromRGBO(210, 61, 41, .2),
  200: const Color.fromRGBO(210, 61, 41, .3),
  300: const Color.fromRGBO(210, 61, 41, .4),
  400: const Color.fromRGBO(210, 61, 41, .5),
  500: const Color.fromRGBO(210, 61, 41, .6),
  600: const Color.fromRGBO(210, 61, 41, .7),
  700: const Color.fromRGBO(210, 61, 41, .8),
  800: const Color.fromRGBO(210, 61, 41, .9),
  900: const Color.fromRGBO(210, 61, 41, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFd23d29, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krachtbal',
      theme: ThemeData(
        primarySwatch: colorCustom,
        fontFamily: 'Montserrat',
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> pageTitle = ["Rangschikking", "Kalender"];
  List<String> urls = [
    'https://matthiasmaes.com/krachtbal/scraped_data/ranking/latest.json',
    'https://matthiasmaes.com/krachtbal/scraped_data/calendar/latest.json'
  ];
  int index = 0;

  List<String> englishPageTitles = ["Ranking", "Calendar"];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          http.Response responseObject = snapshot.data as http.Response;
          Map<String, dynamic> parsedData = json.decode(responseObject.body);
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 219, 219, 219),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                onTap: (int index) {
                  setState(() {
                    this.index = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Calendar',
                  ),
                ]),
            body: CustomScrollView(slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 15, left: 15),
                  title: Text(pageTitle[index]),
                  background: const Image(
                    image: AssetImage('assets/images/Picture1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 25),
                sliver: SliverList(
                  delegate: englishPageTitles[index] == 'Ranking'
                      ? SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return CustomWidgetCardsRanking(
                              data:
                                  parsedData[parsedData.keys.elementAt(index)],
                              title: parsedData.keys.elementAt(index),
                              favorite: LocalPersitance().getFavorite(),
                            );
                          },
                          childCount: parsedData.keys.length,
                        )
                      : SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return CustomWidgetCardsCalender(
                              data:
                                  parsedData[parsedData.keys.elementAt(index)],
                              title: parsedData.keys.elementAt(index),
                              favorite: LocalPersitance().getFavorite(),
                            );
                          },
                          childCount: parsedData.keys.length,
                        ),
                ),
              )
            ]),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      }),
      future: http.get(
        Uri.parse(
          urls[index],
        ),
      ),
    );
  }
}
