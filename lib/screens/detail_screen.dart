// ignore_for_file: must_be_immutable
import 'package:covid_tracker/screens/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int cases, todaycases, todaydeaths, recovered, deaths;
  DetailScreen(
      {super.key,
      required this.name,
      required this.cases,
      required this.deaths,
      required this.image,
      required this.recovered,
      required this.todaycases,
      required this.todaydeaths});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .06),
                      ReusableRow(
                          title: "Total", value: widget.cases.toString()),
                      ReusableRow(
                          title: "Recovered",
                          value: widget.recovered.toString()),
                      ReusableRow(
                          title: "Deaths", value: widget.deaths.toString()),
                      ReusableRow(
                          title: "Today Cases",
                          value: widget.todaycases.toString()),
                      ReusableRow(
                          title: "Today Deaths",
                          value: widget.todaydeaths.toString()),
                    ]),
                  ),
                ),
                Center(
                  child: CircleAvatar(
                      radius: 50, backgroundImage: NetworkImage(widget.image)),
                ),
              ],
            )
          ],
        )));
  }
}
