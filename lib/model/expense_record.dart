// model of how each expense record will look like
class ExpenseRecord {
  String nameOfTheRecord;
  DateTime id;
  String date;
  String time;
  double price;

  ExpenseRecord({
    required this.nameOfTheRecord,
    required this.id,
    required this.date,
    required this.time,
    required this.price,
  });
}
