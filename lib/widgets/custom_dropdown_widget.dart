import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../services/comFuncService.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<dynamic> valArr;
  final Function(dynamic) onChanged;
  final String? labelText;
  final String Function(dynamic) labelField;
  final dynamic selectedItem;
  final double? height;
  final double? width;
  final double? labelStyleFs;
  final Color? labelColor;
  final String? Function(dynamic)? validator;

  CustomDropdownWidget({
    super.key,
    required this.valArr,
    required this.onChanged,
    this.labelText,
    this.validator,
    required this.labelField,
    this.height,
    this.selectedItem,
    this.width,
    this.labelColor,
    this.labelStyleFs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.0,
      margin: const EdgeInsets.all(0.0),
      width: width ?? MediaQuery.of(context).size.width - 10.0,
      child: DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          //showSearchBox: true,
        ),
        items: valArr.toList(),
        itemAsString: (item) => labelField(item),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
            floatingLabelStyle: TextStyle(fontSize: 10.0, color: labelColor ?? AppColors.primary),
            hintStyle: TextStyle(fontSize: labelStyleFs ?? 16, color: labelColor ?? AppColors.dark),
            labelStyle: TextStyle(fontSize: labelStyleFs ?? 16.0, color: labelColor ?? AppColors.dark),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: AppColors.light),
              //borderRadius: BorderRadius.circular(30)
            ),
            // focusedBorder: defaultBorder(),
            //border: idleBorder(),
            border: null,
            labelText: labelText,
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          alignment: Alignment.centerRight,
          icon: const Icon(
            Icons.keyboard_arrow_down, // Your custom icon here
            color: Colors.black, // Custom color for the icon
            size: 21, // Custom size for the icon
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        selectedItem: selectedItem,
      ),
    );
  }
}
