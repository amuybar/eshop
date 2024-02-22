
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String initialValue;
  final Function(String?) onChanged;
  final List<String> items;

  const CustomDropDown({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      onChanged: onChanged,
      
      dropdownColor: Colors.grey,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}