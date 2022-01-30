// bottom sheet that appears on pressing the floating action button
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/controller/expense_controller.dart';
import 'package:personal_expenses/model/expense_record.dart';

class InsertRecordBottomSheet extends StatelessWidget {
  InsertRecordBottomSheet({Key? key}) : super(key: key);
  ExpenseRecord expenseRecord =
      ExpenseRecord(nameOfTheRecord: "", id: DateTime.now(), price: 0);

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submitFunction() {
    if (_formkey.currentState!.validate() == true) {
      print('Adding the expense record...');
      var expenseController = Get.find<ExpenseController>();
      expenseRecord.id = DateTime.now();
      expenseController.addRecord(expenseRecord);
      Get.close(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.highlightColor,
      child: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            getTextFormField(
              label: 'Name',
              textInputType: TextInputType.name,
              prefixIcon: Icon(
                Icons.shopping_cart_outlined,
                color: Get.theme.primaryColor,
                size: 35,
              ),
              onChanged: (str) {
                expenseRecord.nameOfTheRecord = str.toString();
              },
            ),
            getTextFormField(
              label: 'Price',
              textInputType: TextInputType.number,
              prefixIcon: Icon(
                Icons.attach_money_rounded,
                color: Get.theme.primaryColor,
                size: 35,
              ),
              onChanged: (str) {
                expenseRecord.price = double.parse(str.toString());
              },
            ),
            const SizedBox(height: 30),
            //submit button in the bottom sheet
            ElevatedButton(
              onPressed: _submitFunction,
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: Get.theme.textTheme.bodyText1!.fontFamily,
                  fontWeight: Get.theme.textTheme.bodyText1!.fontWeight,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Get.theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//model function for each textfield
getTextFormField({
  required String label,
  required TextInputType textInputType,
  required Icon prefixIcon,
  required Function(String)? onChanged,
}) {
  return TextFormField(
    autocorrect: false,
    decoration: InputDecoration(
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      label: Text(label, style: Get.theme.textTheme.bodyText1),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: prefixIcon,
      errorStyle: Get.theme.textTheme.subtitle1,
      isDense: true,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: textInputType,
    cursorColor: Get.theme.primaryColor,
    cursorHeight: 25,
    cursorWidth: 2,
    style: Get.theme.textTheme.bodyText2,
    toolbarOptions: const ToolbarOptions(
      copy: true,
      selectAll: true,
      cut: true,
      paste: true,
    ),
    onChanged: onChanged,
    validator: (str) {
      if (str!.isEmpty) {
        return "This field cannot be empty!";
      }
      return null;
    },
  );
}
