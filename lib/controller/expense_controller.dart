import 'package:get/get.dart';

import 'package:personal_expenses/model/expense_record.dart';

class ExpenseController extends GetxController {
  List<ExpenseRecord> allRecords = [
    ExpenseRecord(
        nameOfTheRecord: 'Parking Ticket', id: DateTime.now(), price: 50),
    ExpenseRecord(nameOfTheRecord: 'Movie', id: DateTime.now(), price: 349),
  ];

  //function to add a record in the collection
  void addRecord(ExpenseRecord expenseRecord) {
    allRecords.add(expenseRecord);
    update();
  }

  //function to delete a specific record from the collection
  void deleteRecord(ExpenseRecord expenseRecord) {
    allRecords.removeWhere((element) => element.id == expenseRecord.id);
    update();
  }
}
