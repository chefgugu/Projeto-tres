import 'package:flutter/material.dart';
import 'package:projeto_tres/helpers/validator.dart';

class TextInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String initialValue;
  final Function(String) onSaved;

  const TextInputField({
    Key key,
    this.icon,
    this.label,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: Validator.vText,
      initialValue: initialValue,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
      ),
    );
  }
}
