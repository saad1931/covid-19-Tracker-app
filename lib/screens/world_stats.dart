// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            const PieChart(
              dataMap: {"Total": 40, "Recovered": 25, "Deaths": 15},
              chartRadius: 130.4,
              animationDuration: Duration(microseconds: 1200),
              chartType: ChartType.ring,
              colorList: [
                Color(0xff4285F4),
                Color(0xff1aa260),
                Color(0xffde5246),
              ],
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
            ),
            Padding(
              padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
              child: Card(
                child: Column(
                  children: [
                    ReusableRow(title: "Total", value: "40"),
                    ReusableRow(title: "Total", value: "40"),
                    ReusableRow(title: "Total", value: "40")
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 ),
                color:const Color(0xff1aa260)
              ),
              child:const Center(
                child: Text("Track Countries"),
              ),
            )
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 10.0,right: 10.0,bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}
