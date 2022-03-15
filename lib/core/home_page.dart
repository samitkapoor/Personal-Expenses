import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/components/bottom_sheet_form.dart';
import 'package:personal_expenses/components/expense_item.dart';
import 'package:personal_expenses/controller/expense_controller.dart';
import 'package:personal_expenses/model/expense_record.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  Future<void> insertRecordBottomSheet() {
    Get.bottomSheet(
      InsertRecordBottomSheet(),
      ignoreSafeArea: false,
    );
    return Future.value();
  }

  Future<void> getDatePicker(BuildContext context) async {
    ExpenseController expenseController = Get.find<ExpenseController>();
    await showDatePicker(
      context: context,
      initialDate: expenseController.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        expenseController.filterData(selectedDate);
      }
    });
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
          '${expenseRecord.date}',
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
          actions: [
            IconButton(
              icon: const Icon(Icons.date_range_rounded),
              onPressed: () {
                getDatePicker(context);
              },
              tooltip: 'Filter date',
            ),
          ],
        ),
        body: GetBuilder<ExpenseController>(
          builder: (controller) {
            return Stack(
              children: [
                controller.allRecords.isEmpty
                    ? SizedBox(
                        height: Get.height,
                        child: const Center(
                          child: Text(
                            'No expense records!',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(height: Get.height),
                RefreshIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                  onRefresh: () {
                    ExpenseController expenseController =
                        Get.find<ExpenseController>();
                    expenseController.updateAllRecords();
                    return Future.value();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.allRecords.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await Get.dialog(getDialog(controller.allRecords[
                              controller.allRecords.length - index - 1]));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              controller.updateLastDeletedRecord(controller
                                      .allRecords[
                                  controller.allRecords.length - index - 1]);
                              controller.deleteRecord(controller.allRecords[
                                  controller.allRecords.length - index - 1]);
                              controller.updateAllRecords();
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Record deleted!'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      controller.addRecord(
                                          controller.lastDeletedRecord!);
                                      controller.updateAllRecords();
                                    },
                                  ),
                                ),
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: ExpenseItem(
                              expenseRecord: controller.allRecords[
                                  controller.allRecords.length - index - 1],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
