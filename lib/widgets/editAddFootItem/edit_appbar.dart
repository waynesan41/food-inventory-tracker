import 'package:flutter/material.dart';

class EditAppBar extends StatelessWidget {
  final bool _isLoading;
  final Function _saveForm;

  EditAppBar(this._isLoading, this._saveForm);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel_outlined),
        ),
        IconButton(
          onPressed: () {
            _saveForm();
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
