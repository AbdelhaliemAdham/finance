

import 'package:hive/hive.dart';

part 'add_data_model.g.dart';

@HiveType(typeId: 1)
class add_data extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String how;
  @HiveField(4)
  DateTime time;
  add_data({
    required this.name,
    required this.explain,
    required this.amount,
    required this.how,
    required this.time,
  });
}
