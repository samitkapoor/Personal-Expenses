import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/components/bottom_sheet_form.dart';
import 'package:personal_expenses/components/expense_item.dart';
import 'package:personal_expenses/controller/expense_controller.dart';
import 'package:personal_expenses/model/expense_record.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  //function that triggers the bottom sheet to enter the record
  Future<void> insertRecordBottomSheet() {
    Get.bottomSheet(
      InsertRecordBottomSheet(),
      ignoreSafeArea: false,
    );
    return Future.value();
  }

  getDialog(ExpenseRecord expenseRecord) {
    return SimpleDialog(
      backgroundColor: Get.theme.highlightColor,
      contentPadding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.all(10),
      titlePadding: const EdgeInsets.all(10),
      title: Text(
        expenseRecord.nameOfTheRecord,
        style: Get.theme.textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
      children: [
        Text(
          '₹${expenseRecord.price.toStringAsFixed(2)}',
          style: Get.theme.textTheme.headline3,
        ),
        Text(
          '${expenseRecord.id.day}/${expenseRecord.id.month}/${expenseRecord.id.year}',
          style: Get.theme.textTheme.headline3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Expenses',
          ),
        ),
        body: GetBuilder<ExpenseController>(
          builder: (controller) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              children: [
                ...controller.allRecords.map(
                  (expenseRecord) {
                    return InkWell(
                      onTap: () async {
                        await Get.dialog(getDialog(expenseRecord));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Dismissible(
                          key: ObjectKey(expenseRecord.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            controller.deleteRecord(expenseRecord);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.delete,
                                size: 35,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          child: ExpenseItem(
                            expenseRecord: expenseRecord,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await insertRecordBottomSheet();
          },
          child: const Icon(Icons.add, color: Colors.black, size: 50),
          tooltip: 'Add Record',
        ),
      ),
    );
  }
}
