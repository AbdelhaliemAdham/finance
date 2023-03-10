import 'package:finance/data/add_data_model.dart';
import 'package:finance/main.dart';
import 'package:finance/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: const [
          backgroundContainer(),
          MainContainer(),
        ]),
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final box = Hive.box<add_data>('data');
  String? current_Name;
  String? currentItem;
  final List<String> _list = [
    'food',
    'Education',
    'Transfer',
    'Transportation'
  ];
  final List<String> list = ['Income', 'Expense'];

  final TextEditingController _explainController = TextEditingController();
  final FocusNode ex = FocusNode();
  final TextEditingController _amontController = TextEditingController();
  final FocusNode amountFocus = FocusNode();
  DateTime _time = DateTime.now();
  @override
  void initState() {
    ex.addListener(() {
      setState(() {});
    });
    amountFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      left: 25,
      child: Container(
        width: 320,
        height: 550,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(height: 35),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )),
              child: DropdownButton<String>(
                value: current_Name,
                onChanged: ((value) {
                  setState(() {
                    current_Name = value!;
                  });
                }),
                items: _list
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Image.asset('images/$e.png'),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  e,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                selectedItemBuilder: (BuildContext context) => _list
                    .map((e) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 42,
                                child: Image.asset('images/$e.png'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(e)
                          ],
                        ))
                    .toList(),
                hint: const Padding(
                  padding: EdgeInsets.only(top: 12, left: 10),
                  child: Text(
                    'Name',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,
                underline: Container(),
              ),
            ),
            ExplainWidget(ex: ex, explainController: _explainController),
            AmountWidget(
                amountFocus: amountFocus, amontController: _amontController),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )),
              child: DropdownButton<String>(
                  elevation: 3,
                  value: currentItem,
                  isExpanded: true,
                  alignment: Alignment.centerLeft,
                  hint: const Padding(
                    padding: EdgeInsets.only(top: 12, left: 10),
                    child: Text(
                      'How',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  underline: Container(),
                  selectedItemBuilder: (BuildContext context) => list
                      .map((e) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(e),
                              )
                            ],
                          ))
                      .toList(),
                  items: list
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Container(width: 10),
                                Text(e),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (name) {
                    setState(() {
                      currentItem = name;
                    });
                  }),
            ),
            const SizedBox(height: 30),
            Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: TextButton(
                onPressed: () async {
                  DateTime? newTime = await showDatePicker(
                    context: context,
                    initialDate: _time,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2100),
                  );
                  if (newTime == null) return;
                  setState(() {
                    _time = newTime;
                  });
                },
                child: Text(
                  'Datetime : ${_time.year}/${_time.month}/${_time.day}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                final add = add_data(
                    amount: _amontController.text,
                    how: currentItem ?? '',
                    explain: _explainController.text,
                    name: current_Name ?? '',
                    time: _time);
                box.add(add);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bottom(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff368983),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    Key? key,
    required this.amountFocus,
    required TextEditingController amontController,
  })  : _amontController = amontController,
        super(key: key);

  final FocusNode amountFocus;
  final TextEditingController _amontController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 30, top: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        focusNode: amountFocus,
        controller: _amontController,
        decoration: InputDecoration(
          label: const Padding(
            padding: EdgeInsets.only(left: 1),
            child: Text(
              'Amount',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class ExplainWidget extends StatelessWidget {
  const ExplainWidget({
    Key? key,
    required this.ex,
    required TextEditingController explainController,
  })  : _explainController = explainController,
        super(key: key);

  final FocusNode ex;
  final TextEditingController _explainController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 30, right: 30),
      child: TextFormField(
        focusNode: ex,
        controller: _explainController,
        maxLength: 500,
        decoration: InputDecoration(
          label: const Padding(
            padding: EdgeInsets.only(left: 1),
            child: Text(
              'Explain',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class backgroundContainer extends StatelessWidget {
  const backgroundContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          color: Color(0xff368983),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bottom(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    top: 15,
                    left: 150,
                    child: Text(
                      'Adding',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 15,
                    right: 50,
                    child: Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
