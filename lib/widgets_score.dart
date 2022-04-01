import 'package:flutter/material.dart';

class CustomWidgetCardsScore extends StatefulWidget {
  final List data;

  CustomWidgetCardsScore({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CustomWidgetCardsScore> createState() => CustomWidgetCardsScoreState();
}

class CustomWidgetCardsScoreState extends State<CustomWidgetCardsScore> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Table(columnWidths: const {
                  0: FractionColumnWidth(.35),
                  1: FractionColumnWidth(.3),
                  2: FractionColumnWidth(.35)
                }, children: [
                  TableRow(children: [
                    const TableCell(child: Text('')),
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.data[index]['devision'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )),
                    const TableCell(child: Text('')),
                  ]),
                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Text(
                          widget.data[index]['home'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: widget.data[index]['home']
                                    .contains('Buggenhout')
                                ? const Color.fromARGB(255, 210, 61, 41)
                                : null,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        widget.data[index]['score_home'] +
                            ' - ' +
                            widget.data[index]['score_away'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.5),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              widget.data[index]['away'],
                              style: TextStyle(
                                color: widget.data[index]['away']
                                        .contains('Buggenhout')
                                    ? const Color.fromARGB(255, 210, 61, 41)
                                    : null,
                              ),
                            ))),
                  ]),
                  TableRow(children: [
                    const TableCell(child: Text('')),
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.data[index]['date'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )),
                    const TableCell(child: Text('')),
                  ]),
                ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
              ),
            ),
          );
        },
        childCount: widget.data.length,
      ),
    );
  }
}
