import 'package:finance/main.dart';
import 'package:finance/screens/add_screen.dart';
import 'package:finance/screens/statistcs.dart';
import 'package:flutter/material.dart';

class bottom extends StatefulWidget {
  bottom({super.key});

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  int currentIndex = 0;
  List<Widget> screens = const [
    Home(),
    Statistics(),
    AddScreen(),
    Statistics(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddScreen(),
          ));
        },
        backgroundColor: const Color(0xff2F7D79),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color:
                      currentIndex == 0 ? const Color(0xff2F7D79) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color:
                      currentIndex == 1 ? const Color(0xff2F7D79) : Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance,
                  size: 30,
                  color:
                      currentIndex == 2 ? const Color(0xff2F7D79) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: Icon(
                  Icons.person,
                  size: 30,
                  color:
                      currentIndex == 3 ? const Color(0xff2F7D79) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
