import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/components/bottom_sheet_form.dart';

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
