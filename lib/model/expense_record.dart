// model of how each expense record will look like
class ExpenseRecord {
  String nameOfTheRecord = '';
  String date = DateTime.now().toString();
  double price = 0.00;
  int id = 0;

  ExpenseRecord({
    required this.nameOfTheRecord,
    required this.date,
    required this.price,
    required this.id,
  });

  String get getName => nameOfTheRecord;

  String get getDate => date;

  double get getPrice => price;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'id': id,
      'nameOfTheRecord': nameOfTheRecord,
      'price': price
    };
    return map;
  }

  // extra a expenserecord object from a map object
  ExpenseRecord.fromMapObject(Map<String, dynamic> map) {
    date = map['date'];
    id = map['id'];
    nameOfTheRecord = map['nameOfTheRecord'];
    price = map['price'];
  }
}
