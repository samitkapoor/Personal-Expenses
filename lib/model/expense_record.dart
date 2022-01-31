// model of how each expense record will look like
class ExpenseRecord {
  String nameOfTheRecord = '';
  String id = DateTime.now().toString();
  double price = 0.00;

  ExpenseRecord({
    required this.nameOfTheRecord,
    required this.id,
    required this.price,
  });

  String get getName => nameOfTheRecord;

  String get getId => id;

  double get getPrice => price;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'nameOfTheRecord': nameOfTheRecord,
      'price': price
    };
    return map;
  }

  // extra a expenserecord object from a map object
  ExpenseRecord.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    nameOfTheRecord = map['nameOfTheRecord'];
    price = map['price'];
  }
}
