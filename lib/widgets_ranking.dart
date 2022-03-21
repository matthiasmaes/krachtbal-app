import 'package:flutter/material.dart';

class CustomWidgetCardsRanking extends StatefulWidget {
  final String title;
  final List data;

  CustomWidgetCardsRanking({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomWidgetCardsRanking> createState() =>
      CustomWidgetCardsRankingState();
}

class CustomWidgetCardsRankingState extends State<CustomWidgetCardsRanking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 210, 61, 41),
                  fontFamily: 'AauxProBlack',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Table(
                columnWidths: const {
                  0: FractionColumnWidth(.1),
                  1: FractionColumnWidth(.8),
                  2: FractionColumnWidth(.4)
                },
                children: (widget.data)
                    .map((entry) => TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              entry['place'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: entry['club'].contains('Buggenhout')
                                    ? const Color.fromARGB(255, 210, 61, 41)
                                    : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              entry['club'],
                              style: TextStyle(
                                color: entry['club'].contains('Buggenhout')
                                    ? const Color.fromARGB(255, 210, 61, 41)
                                    : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              entry['points'],
                              style: TextStyle(
                                color: entry['club'].contains('Buggenhout')
                                    ? const Color.fromARGB(255, 210, 61, 41)
                                    : null,
                              ),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ]),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
