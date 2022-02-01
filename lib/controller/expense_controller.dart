import 'package:get/get.dart';

import 'package:personal_expenses/model/expense_record.dart';
import 'package:personal_expenses/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseController extends GetxController {
  List<ExpenseRecord> allRecords = [];
  double totalLastMonth = 0;
  DateTime selectedDate = DateTime.now();
  DatabaseHelper? databaseHelper;

  void getTotalLastMonth() {
    List<ExpenseRecord> recordsLastMonth = [];
    final Future<Database> dbFuture = databaseHelper!.initializeDatabase();
    dbFuture.then((database) {
      int month = DateTime.now().month;
      int year = DateTime.now().year;
      if (DateTime.now().month == 1) {
        month = 12;
      } else {
        month -= 1;
        year -= 1;
      }

      String string = DateTime.now().day.toString() +
          '/' +
          month.toString() +
          '/' +
          year.toString();

      Future<List<ExpenseRecord>> lastMonthExpenseRecordList =
          databaseHelper!.getLastMonthExpenseRecord(string);
      lastMonthExpenseRecordList.then((lastMonthList) {
        recordsLastMonth = lastMonthList;
        totalLastMonth = 0;
        recordsLastMonth.forEach((expenseRecord) {
          totalLastMonth += expenseRecord.price;
        });
        update();
      });
    });
  }

  void updateAllRecords() {
    final Future<Database> dbFuture = databaseHelper!.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ExpenseRecord>> expenseRecordList =
          databaseHelper!.getExpenseRecordList();

      expenseRecordList.then((recordsList) {
        allRecords = recordsList;
        getTotalLastMonth();
        update();
      });
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
    } else {
      Get.snackbar('ERROR', 'Couldn\'t add the record');
    }
    getTotalLastMonth();
    update();
  }

  //function to delete a specific record from the collection
  void deleteRecord(ExpenseRecord expenseRecord) async {
    int result = await databaseHelper!.deleteExpenseRecord(expenseRecord);
    if (result != 0) {
      int i = 0;
      for (var element in allRecords) {
        if (element.id == expenseRecord.id &&
            element.nameOfTheRecord == expenseRecord.nameOfTheRecord &&
            element.price == expenseRecord.price) {
          break;
        }
        i++;
      }

      allRecords.removeAt(i);
    } else {
      Get.snackbar('ERROR', 'Couldn\'t delete the record, restart the app');
    }
    getTotalLastMonth();
    update();
  }

  void filterData(DateTime dateTime) {
    selectedDate = dateTime;
    final Future<Database> dbFuture = databaseHelper!.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ExpenseRecord>> filteredExpenseRecordList =
          databaseHelper!.getFilteredExpenseRecord(dateTime);

      filteredExpenseRecordList.then((filteredRecordsList) {
        allRecords = filteredRecordsList;
        update();
      });
    });
  }
}
