// bottom sheet that appears on pressing the floating action button

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertRecordBottomSheet extends StatelessWidget {
  const InsertRecordBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Get.theme.highlightColor,
      child: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            getTextFormField(
              label: 'Name',
              textInputType: TextInputType.name,
              prefixIcon: Icon(
                Icons.shopping_cart_outlined,
                color: Get.theme.primaryColor,
              ),
            ),
            getTextFormField(
              label: 'Price',
              textInputType: TextInputType.number,
              prefixIcon: Icon(
                Icons.attach_money_rounded,
                color: Get.theme.primaryColor,
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
    ),
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
  );
}
