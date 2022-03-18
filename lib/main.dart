import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      // home: const MyHomePage(),
      home: Expanded(
        child: AnimatedSplashScreen.withScreenFunction(
          backgroundColor: const Color.fromARGB(255, 210, 61, 41),
          duration: 0,
          splash: 'assets/images/splash.png',
          splashIconSize: 300.0,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          screenFunction: () async {
            http.Response rankingResponse = await http.get(
              Uri.parse(
                'https://matthiasmaes.com/krachtbal/scraped_data/ranking/latest.json',
              ),
            );

            http.Response calendarResponse = await http.get(
              Uri.parse(
                'https://matthiasmaes.com/krachtbal/scraped_data/calendar/latest.json',
              ),
            );

            return MyHomePage(
                rankingData: json.decode(rankingResponse.body),
                calendarData: json.decode(calendarResponse.body));
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.rankingData, required this.calendarData})
      : super(key: key);

  final Map<String, dynamic> rankingData;
  final Map<String, dynamic> calendarData;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  List<String> pageTitle = ["Rangschikking", "Kalender"];
  List<String> englishPageTitles = ["Ranking", "Calendar"];

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
            titlePadding: const EdgeInsets.only(bottom: 15, left: 15),
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
                        data: widget.rankingData[
                            widget.rankingData.keys.elementAt(index)],
                        title: widget.rankingData.keys.elementAt(index),
                        favorite: LocalPersitance().getFavorite(),
                      );
                    },
                    childCount: widget.rankingData.keys.length,
                  )
                : SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CustomWidgetCardsCalender(
                        data: widget.calendarData[
                            widget.calendarData.keys.elementAt(index)],
                        title: widget.calendarData.keys.elementAt(index),
                        favorite: LocalPersitance().getFavorite(),
                      );
                    },
                    childCount: widget.calendarData.keys.length,
                  ),
          ),
        )
      ]),
    );
  }
}
