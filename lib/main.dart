import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krachtbal/widgets_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'localpersitance.dart';
import 'widgets_calendar.dart';
import 'widgets_ranking.dart';
import 'package:page_transition/page_transition.dart';

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
      home: AnimatedSplashScreen.withScreenFunction(
        backgroundColor: const Color.fromARGB(255, 210, 61, 41),
        duration: 0,
        splash: 'assets/images/splash.png',
        splashIconSize: 300.0,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        // TOEDOE: run requests in parallel
        screenFunction: () async {
          var httpResponses = await Future.wait([
            http.get(
              Uri.parse(
                'https://matthiasmaes.com/krachtbal/scraped_data/ranking/latest.json',
              ),
            ),
            http.get(
              Uri.parse(
                'https://matthiasmaes.com/krachtbal/scraped_data/calendar/21-03-2022-20-35-42-krachtbal-scraped.json',
              ),
            ),
          ]);

          var localStorage = await SharedPreferences.getInstance();

          return MyHomePage(
              rankingData: json.decode(httpResponses[0].body),
              calendarData: json.decode(httpResponses[1].body),
              localStorage: localStorage);
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.rankingData,
      required this.calendarData,
      required this.localStorage})
      : super(key: key);

  final Map<String, dynamic> rankingData;
  final Map<String, dynamic> calendarData;
  final SharedPreferences localStorage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String>? getPersistedData(SharedPreferences interface, String key) {
  return interface.getStringList(key);
}

void setPersistedData(
    SharedPreferences interface, String key, List<String> value) {
  interface.setStringList(key, value);
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  List<String> pageTitle = ["Rangschikking", "Kalender", "Detail"];
  List<String> englishPageTitles = ["Ranking", "Calendar", "Detail"];

  List<String> selectedDevisions = [
    '1NHA',
    '1NHB',
  ];

  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    selectedDevisions =
        getPersistedData(widget.localStorage, 'filter') ?? ['1NHA'];
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
            BottomNavigationBarItem(
              icon: Icon(Icons.four_g_plus_mobiledata_sharp),
              label: 'Detail',
            ),
          ]),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(bottom: 15, left: 15),
            title: Text(pageTitle[index]),
            background: const Image(
              image: AssetImage('assets/images/header.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: widget.rankingData.keys
                    .map((entry) => Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InputChip(
                              showCheckmark: true,
                              selected: selectedDevisions.contains(entry),
                              label: Text(entry),
                              backgroundColor: Colors.white,
                              selectedColor: Colors.white,
                              checkmarkColor: Color.fromARGB(255, 210, 61, 41),
                              onSelected: (bool value) {
                                setState(() {
                                  if (selectedDevisions.contains(entry)) {
                                    selectedDevisions.remove(entry);
                                  } else {
                                    selectedDevisions.add(entry);
                                  }

                                  setPersistedData(widget.localStorage,
                                      'filter', selectedDevisions);

                                  isSelected = value;
                                });
                              },
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        sliverBuilder(),
      ]),
    );
  }

  SliverPadding sliverBuilder() {
    if (selectedDevisions.isEmpty) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 50),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Kies een reeks hierboven om verder te gaan',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ),
      );
    } else {
      if (englishPageTitles[index] == 'Ranking') {
        return SliverPadding(
          // padding: const EdgeInsets.only(top: 25),
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CustomWidgetCardsRanking(
                  data: widget.rankingData[selectedDevisions.elementAt(index)],
                  title: selectedDevisions.elementAt(index),
                );
              },
              childCount: selectedDevisions.length,
            ),
          ),
        );
      } else if (englishPageTitles[index] == 'Calendar') {
        return SliverPadding(
          // padding: const EdgeInsets.only(top: 25),
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CustomWidgetCardsCalender(
                  data: widget
                      .calendarData[widget.calendarData.keys.elementAt(index)],
                  title: widget.calendarData.keys.elementAt(index),
                );
              },
              childCount: widget.calendarData.keys.length,
            ),
          ),
        );
      } else {
        return SliverPadding(
          // padding: const EdgeInsets.only(top: 25),
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CustomWidgetCardsDetail(
                  data: widget.calendarData[selectedDevisions.elementAt(index)],
                  title: selectedDevisions.elementAt(index),
                );
              },
              childCount: selectedDevisions.length,
            ),
          ),
        );
      }
    }
  }
}
