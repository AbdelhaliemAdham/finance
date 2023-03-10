import 'package:finance/data/add_data_model.dart';
import 'package:hive/hive.dart';

int totals = 0;

final box = Hive.box<add_data>('data');

int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].how == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].how == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].how == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<add_data> today() {
  List<add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].time.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<add_data> week() {
  List<add_data> a = [];
  DateTime date = new DateTime.now();
  var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].time.day &&
        history2[i].time.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<add_data> month() {
  List<add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].time.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<add_data> year() {
  List<add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].time.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<add_data> history2) {
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].how == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount*-1) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<add_data> history2, bool hour) {
  List<add_data> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].time.hour == history2[c].time.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].time.day == history2[c].time.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  print(total);
  return total;
}
