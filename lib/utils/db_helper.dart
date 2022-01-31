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
  Future<List<Map<String, dynamic>>> getExpenseMapList() async {
    Database db = await database;

    var result = await db.query(expenseTable);
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
        'DELETE FROM $expenseTable WHERE $colId = ?', [expenseRecord.id]);
    return result;
  }

  Future<List<ExpenseRecord>> getExpenseList() async {
    var expenseRecordMapList = await getExpenseMapList();

    List<ExpenseRecord> expenseList = [];
    expenseRecordMapList.forEach((element) {
      expenseList.add(ExpenseRecord.fromMapObject(element));
    });

    return expenseList;
  }
}