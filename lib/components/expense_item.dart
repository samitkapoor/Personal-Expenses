import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/model/expense_record.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseRecord expenseRecord;
  ExpenseItem({Key? key, required this.expenseRecord}) : super(key: key);

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
    return ListTile(
      onTap: () {
        Get.dialog(getDialog(expenseRecord));
      },
      title: Text(
        expenseRecord.nameOfTheRecord,
        style: Get.theme.textTheme.headline1,
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        expenseRecord.date,
        style: Get.theme.textTheme.subtitle2,
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '₹${expenseRecord.price.toStringAsFixed(2)}',
        style: Get.theme.textTheme.headline2,
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
