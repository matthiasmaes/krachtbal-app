import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krachtbal/widgets_ranking.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets_calendar.dart';
import 'widgets_ranking.dart';
import 'widgets_score.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        screenFunction: () async {
          var localStorage = await SharedPreferences.getInstance();

          CollectionReference collectionRanking =
              FirebaseFirestore.instance.collection('ranking');
          var rankingData = (await collectionRanking.doc('latest').get()).data()
              as Map<String, dynamic>;

          CollectionReference collectionCalendar =
              FirebaseFirestore.instance.collection('calendar');
          var calendarData = (await collectionCalendar.doc('latest').get())
              .data() as Map<String, dynamic>;

          CollectionReference collectionSynchCalendar =
              FirebaseFirestore.instance.collection('synchCalendar');
          var synchCalendarData =
              (await collectionSynchCalendar.doc('latest').get()).data()
                  as Map<String, dynamic>;

          return MyHomePage(
              rankingData: rankingData['data'],
              calendarData: calendarData['data'],
              synchCalendarData: synchCalendarData['data'],
              localStorage: localStorage);
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Map<String, dynamic> rankingData;
  final Map<String, dynamic> calendarData;
  final List synchCalendarData;
  final SharedPreferences localStorage;

  const MyHomePage(
      {Key? key,
      required this.rankingData,
      required this.calendarData,
      required this.synchCalendarData,
      required this.localStorage})
      : super(key: key);

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
  List<String> pageTitle = ["Rangschikking", "Kalender", "Score"];
  List<String> englishPageTitles = ["Ranking", "Calendar", "Score"];

  List<String> selectedDevisions = [];

  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.leaderboard),
              label: 'Ranking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.scoreboard_outlined),
              label: 'Score',
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.from([
                  const SizedBox(
                    width: 5,
                  ),
                  InputChip(
                      label: const Icon(Icons.cancel),
                      onSelected: (bool value) {
                        setState(() {
                          selectedDevisions.clear();
                          setPersistedData(widget.localStorage, 'filter', []);
                        });
                      })
                ])
                  ..addAll(buildChips()),
              ),
            ),
          ),
        ),
        sliverBuilder(),
      ]),
    );
  }

  List<Widget> buildChips() {
    return [
      '1NHA',
      '1NHB',
      '1NDA',
      '1NDB',
      '1LD',
      '2LH',
      'U18J',
      'U18M',
      'U16JA',
      'U14JA',
      'U14M',
      'U12A',
      'U12B',
      'U12 Titel',
      'U12NA'
    ]
        .map(
          (entry) => Row(
            children: [
              InputChip(
                showCheckmark: true,
                selected: selectedDevisions.contains(entry),
                label: Text(entry),
                backgroundColor: Colors.white,
                selectedColor: Colors.white,
                checkmarkColor: const Color.fromARGB(255, 210, 61, 41),
                onSelected: (bool value) {
                  setState(() {
                    if (selectedDevisions.contains(entry)) {
                      selectedDevisions.remove(entry);
                    } else {
                      selectedDevisions.add(entry);
                    }
                    setPersistedData(
                        widget.localStorage, 'filter', selectedDevisions);

                    isSelected = value;
                  });
                },
              ),
              const SizedBox(
                width: 7.5,
              ),
            ],
          ),
        )
        .toList();
  }

  SliverPadding sliverBuilder() {
    if (selectedDevisions.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.only(top: 50),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: const [
                Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Colors.grey,
                ),
                Text(
                  'Kies een reeks hierboven om verder te gaan',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      if (englishPageTitles[index] == 'Ranking') {
        return SliverPadding(
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
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CustomWidgetCardsCalender(
                  data: widget.calendarData[selectedDevisions.elementAt(index)],
                  title: selectedDevisions.elementAt(index),
                );
              },
              childCount: selectedDevisions.length,
            ),
          ),
        );
      } else {
        return SliverPadding(
          padding: EdgeInsets.zero,
          sliver: CustomWidgetCardsScore(
            data: widget.synchCalendarData
                .where((x) => selectedDevisions.contains(x['devision']))
                .toList(),
          ),
        );
      }
    }
  }
}
