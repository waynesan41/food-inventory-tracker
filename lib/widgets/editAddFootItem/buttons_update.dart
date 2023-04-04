//===
import "package:flutter/material.dart";

class ButtonsUpdate extends StatelessWidget {
  const ButtonsUpdate(this._saveForm, this._buttonType, {super.key});
  final Function _saveForm;
  final int _buttonType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange[700])),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[700])),
          onPressed: () {
            _saveForm();
          },
          child: Text(_buttonType == 1 ? "Add Item" : "Update Item"),
        ),
      ],
    );
  }
}
