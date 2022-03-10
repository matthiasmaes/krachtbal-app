import 'package:flutter/material.dart';
import 'widgets.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(210, 61, 41, .1),
  100: Color.fromRGBO(210, 61, 41, .2),
  200: Color.fromRGBO(210, 61, 41, .3),
  300: Color.fromRGBO(210, 61, 41, .4),
  400: Color.fromRGBO(210, 61, 41, .5),
  500: Color.fromRGBO(210, 61, 41, .6),
  600: Color.fromRGBO(210, 61, 41, .7),
  700: Color.fromRGBO(210, 61, 41, .8),
  800: Color.fromRGBO(210, 61, 41, .9),
  900: Color.fromRGBO(210, 61, 41, 1),
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
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 219, 219),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Home',
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(bottom: 15, left: 15),
                title: Text('Rangschikking'),
                background: Image(
                  image: AssetImage('assets/images/Picture1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.only(top: 25),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CustomWidget_Card(
                        data: data_fo_real[data_fo_real.keys.elementAt(index)],
                        title: data_fo_real.keys.elementAt(index),
                      );
                    },
                    childCount: data_fo_real.keys.length,
                  ),
                )),
          ],
        )

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Stack(
        //       children: [
        //         Container(
        //           height: 200,
        //           width: double.infinity,
        //           decoration: const BoxDecoration(
        //             image: DecorationImage(
        //               fit: BoxFit.cover,
        //               image: AssetImage('assets/images/header-img.jpeg'),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 200,
        //           width: double.infinity,
        //           color: Color.fromARGB(210, 210, 61, 41),
        //           padding: const EdgeInsets.all(30.0),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: const [
        //               Text(
        //                 'KRACHTBAL',
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 30,
        //                     fontFamily: 'AauxProBlack',
        //                     fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 'Rangschikking',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontFamily: 'AauxProBlack',
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     Expanded(
        //       child: Container(
        //         // transform: Matrix4.translationValues(0, -20, 0),
        //         child: ListView(
        //           shrinkWrap: true,
        //           // padding: EdgeInsets.zero,
        //           children: [
        //             CustomWidget_Card(
        //                 data: data_fo_real['1° Nationale Heren (1NHA)'],
        //                 title: '1° Nationale Heren (1NHA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['1° Nationale Heren Beloften (1NHB)'],
        //                 title: '1° Nationale Heren Beloften (1NHB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['1° Nationale Dames (1NDA)'],
        //                 title: '1° Nationale Dames (1NDA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['1e Nationale Dames Beloften (1NDB)'],
        //                 title: '1e Nationale Dames Beloften (1NDB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['2° Nationale Heren (2NHA)'],
        //                 title: '2° Nationale Heren (2NHA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['2° Nationale Heren Beloften (2NHB)'],
        //                 title: '2° Nationale Heren Beloften (2NHB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['1° Landelijke Heren (1LH)'],
        //                 title: '1° Landelijke Heren (1LH)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['1° Landelijke Dames (1LD)'],
        //                 title: '1° Landelijke Dames (1LD)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['2° Landelijke Heren (2LH)'],
        //                 title: '2° Landelijke Heren (2LH)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real[
        //                     'Regionale Dames / 2°Landelijke Dames A (REG D/2LD A)'],
        //                 title:
        //                     'Regionale Dames / 2°Landelijke Dames A (REG D/2LD A)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real[
        //                     'Regionale Dames / 2°Landelijke Dames B (REG D/2LD B)'],
        //                 title:
        //                     'Regionale Dames / 2°Landelijke Dames B (REG D/2LD B)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['Regionale Heren A (REG HA)'],
        //                 title: 'Regionale Heren A (REG HA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['Regionale Heren B (REG HB)'],
        //                 title: 'Regionale Heren B (REG HB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['Recrea Limburg (RRL)'],
        //                 title: 'Recrea Limburg (RRL)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U18 jongens (U18J)'],
        //                 title: 'U18 jongens (U18J)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U18 meisjes (U18M)'],
        //                 title: 'U18 meisjes (U18M)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U16 jongens A (U16JA)'],
        //                 title: 'U16 jongens A (U16JA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U16 jongens B (U16JB)'],
        //                 title: 'U16 jongens B (U16JB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U16 meisjes (U16M)'],
        //                 title: 'U16 meisjes (U16M)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U14 jongens A (U14JA)'],
        //                 title: 'U14 jongens A (U14JA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U14 jongens B (U14JB)'],
        //                 title: 'U14 jongens B (U14JB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U14 meisjes (U14M)'],
        //                 title: 'U14 meisjes (U14M)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 A (U12A)'],
        //                 title: 'U12 A (U12A)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 B (U12B)'],
        //                 title: 'U12 B (U12B)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 Titel (U12 Titel)'],
        //                 title: 'U12 Titel (U12 Titel)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 NA (U12NA)'],
        //                 title: 'U12 NA (U12NA)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 NB (U12NB)'],
        //                 title: 'U12 NB (U12NB)'),
        //             CustomWidget_Card(
        //                 data: data_fo_real['U12 NC (U12NC)'],
        //                 title: 'U12 NC (U12NC)'),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
