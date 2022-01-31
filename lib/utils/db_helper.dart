import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_expenses/model/expense_record.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; //singleton databasehelper
  static Database? _database;

  String expenseTable = 'expense_table';
  String colId = 'id';
  String colNameOfTheRecord = 'nameOfTheRecord';
  String colPrice = 'price';

  DatabaseHelper.createInstance(); //named constructor to create instance of databasehelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper.createInstance();
    //this is executed only once, singleton object

    return _databaseHelper as DatabaseHelper;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database as Database;
  }

  Future<Database> initializeDatabase() async {
    //get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'expenses.db';

    // Open/create the databse at a given path
    var expenseDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return expenseDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $expenseTable($colId TEXT, $colNameOfTheRecord TEXT, $colPrice DOUBLE)');
  }

  //fetch operation: Get all records from the database
  Future<List<Map<String, dynamic>>> getExpenseRecordMapList() async {
    Database db = await database;

    var result = await db.query(expenseTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getFilteredExpenseRecordMapList(
      DateTime dateTime) async {
    Database db = await database;
    String filterId = dateTime.day.toString() +
        '/' +
        dateTime.month.toString() +
        '/' +
        dateTime.year.toString();
    var result = await db
        .query(expenseTable, where: '$colId = ?', whereArgs: [filterId]);
    return result;
  }

  //insert operation: insert an expense record to database
  Future<int> insertExpenseRecord(ExpenseRecord expenseRecord) async {
    Database db = await database;
    var result = await db.insert(expenseTable, expenseRecord.toMap());
    return result;
  }

  //delete operation: delete a expense record object from database
  Future<int> deleteExpenseRecord(ExpenseRecord expenseRecord) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $expenseTable WHERE $colId = ? and $colNameOfTheRecord = ? and $colPrice = ?',
        [expenseRecord.id, expenseRecord.nameOfTheRecord, expenseRecord.price]);
    return result;
  }

  Future<List<ExpenseRecord>> getExpenseRecordList() async {
    var expenseRecordMapList = await getExpenseRecordMapList();

    List<ExpenseRecord> expenseRecordList = [];
    for (var element in expenseRecordMapList) {
      expenseRecordList.add(ExpenseRecord.fromMapObject(element));
    }

    return expenseRecordList;
  }

  // filtered fetch operation: when user wants to see the records of a specific date
  Future<List<ExpenseRecord>> getFilteredExpenseRecord(
      DateTime dateTime) async {
    var filteredExpenseRecordMapList =
        await getFilteredExpenseRecordMapList(dateTime);
    List<ExpenseRecord> filteredExpenseRecordList = [];
    for (var element in filteredExpenseRecordMapList) {
      filteredExpenseRecordList.add(ExpenseRecord.fromMapObject(element));
    }

    return filteredExpenseRecordList;
  }
}
