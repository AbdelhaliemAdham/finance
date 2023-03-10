import 'package:finance/data/add_data_model.dart';
import 'package:finance/data/data_top.dart';
import 'package:finance/widgets/bottom_navigation_bar.dart';
import 'package:finance/widgets/chart.dart';
import 'package:flutter/material.dart';

import '../data/utils.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  ValueNotifier kj = ValueNotifier(0);
  List<String> time = ['Day', 'Week', 'Month', 'Year'];
  int indexColor = 0;
  List f = [today(), week(), month(), year()];
  List<add_data> a = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ValueListenableBuilder(
              valueListenable: kj,
              builder: ((context, value, child) {
                var a = f[value];
                return SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Statistics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ...List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexColor = index;
                                  kj.value = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: indexColor == index
                                      ? const Color(0xff2F7D79)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  time[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: indexColor == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xff9C9C9C),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Expense',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xff6F6F6F),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff9C9C9C),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Chart(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Top Spending',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.swap_vert, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset('images/${a[index].name}.png',
                          height: 40),
                    ),
                    title: Text(
                      a[index].name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${time[a[index].time.weekday - 1]}  ${a[index].time.year}-${a[index].time.day}-${a[index].time.month}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      '\$ ${a[index].amount}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: a[index].how == 'Income'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
                childCount: a.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
