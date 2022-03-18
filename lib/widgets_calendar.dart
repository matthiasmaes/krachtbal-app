import 'package:flutter/material.dart';

class CustomWidgetCardsCalender extends StatefulWidget {
  final String title;
  final List data;
  String favorite;

  CustomWidgetCardsCalender({
    Key? key,
    required this.data,
    required this.title,
    required this.favorite,
  }) : super(key: key);

  @override
  State<CustomWidgetCardsCalender> createState() =>
      CustomWidgetCardsCalenderState();
}

class CustomWidgetCardsCalenderState extends State<CustomWidgetCardsCalender> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);

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
              SizedBox(
                  width: double.infinity,
                  child: widget.data.isEmpty
                      ? const Text(
                          'Volgend weekend geen match ingepland',
                          style: TextStyle(color: Colors.grey),
                        )
                      : null),
              Table(
                columnWidths: const {
                  0: FractionColumnWidth(.3),
                  1: FractionColumnWidth(.7),
                },
                children: (widget.data)
                    .map(
                      (entry) => TableRow(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(entry['time']),
                              ),
                              Text(entry['date']),
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 10),
                                  child: Text(entry['home']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(entry['away']),
                                ),
                              ]),
                        ),
                      ]),
                    )
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
