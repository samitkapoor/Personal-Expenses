import 'package:get/get.dart';

import 'package:personal_expenses/model/expense_record.dart';
import 'package:personal_expenses/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseController extends GetxController {
  List<ExpenseRecord> allRecords = [];
  DatabaseHelper? databaseHelper;

  void updateAllRecords() {
    final Future<Database> dbFuture = databaseHelper!.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ExpenseRecord>> expenseRecordList =
          databaseHelper!.getExpenseList();

      expenseRecordList.then((recordsList) {
        allRecords = recordsList;
        update();
      });

      update();
    });
  }

  @override
  void onInit() {
    databaseHelper = DatabaseHelper();
    updateAllRecords();
    super.onInit();
  }

  //function to add a record in the collection
  void addRecord(ExpenseRecord expenseRecord) async {
    int result = await databaseHelper!.insertExpenseRecord(expenseRecord);
    if (result != 0) {
      allRecords.add(expenseRecord);
      updateAllRecords();
    } else {
      Get.snackbar('ERROR', 'Couldn\'t add the record');
    }

    update();
  }

  //function to delete a specific record from the collection
  void deleteRecord(ExpenseRecord expenseRecord) async {
    int result = await databaseHelper!.deleteExpenseRecord(expenseRecord);
    if (result != 0) {
      Get.snackbar('Record Deleted!', '');
      allRecords.removeWhere((element) => element.id == expenseRecord.id);
    } else {
      Get.snackbar('ERROR', 'Couldn\'t delete the record, restart the app');
    }

    updateAllRecords();

    update();
  }
}
