import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/components/bottom_sheet_form.dart';
import 'package:personal_expenses/components/expense_item.dart';
import 'package:personal_expenses/controller/expense_controller.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: [
                ...controller.allRecords.map(
                  (ele) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Dismissible(
                        key: ObjectKey(ele.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          controller.deleteRecord(ele);
                        },
                        child: ExpenseItem(expenseRecord: ele),
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
          child: const Icon(Icons.add),
          tooltip: 'Add Record',
        ),
      ),
    );
  }
}
