import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/model/expense_record.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseRecord expenseRecord;
  ExpenseItem({Key? key, required this.expenseRecord}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      height: 55,
      decoration: BoxDecoration(
        color: Get.theme.highlightColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              expenseRecord.nameOfTheRecord,
              style: Get.theme.textTheme.headline1,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '₹${expenseRecord.price.toStringAsFixed(2)}',
            style: Get.theme.textTheme.headline2,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
