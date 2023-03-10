import 'package:finance/data/data.dart';

List<Money> geter() {
  Money upwork = Money();
  upwork.name = 'Upwork';
  upwork.image = 'Education.png';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.buy = false;

  Money starbucks = Money();
  starbucks.buy = true;
  starbucks.fee = '235';
  starbucks.image = 'food.png';
  starbucks.name = 'Starbucks';
  starbucks.time = 'yesterday';
  Money transfer = Money();
  transfer.fee = '127';
  transfer.name = 'Transfer for sum';
  transfer.buy = true;
  transfer.time = '10:03 PM';
  transfer.image = 'Transfer.png';
  Money transportation = Money();
  transportation.buy = false;
  transportation.image = 'Transportation.png';
  transportation.name = 'Transportation';
  transportation.time = '21:39 AM';
  transportation.fee = '736';
  return [upwork, starbucks, transfer, transportation];
}
