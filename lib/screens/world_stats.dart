import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/stats_servces.dart';
import 'package:covid_tracker/screens/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: statsServices.fetchWorldStatsRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: 130.4,
                            animationDuration:
                                const Duration(microseconds: 1200),
                            chartType: ChartType.ring,

                            // ignore: prefer_const_literals_to_create_immutables
                            colorList: [
                              const Color(0xff4285F4),
                              const Color(0xff1aa260),
                              const Color(0xffde5246),
                            ],
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: "Tests Conducted",
                                      value: snapshot.data!.tests.toString()),
                                  ReusableRow(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  ReusableRow(
                                      title: "Today Deaths",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff1aa260)),
                              child: const Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
