//===
import "dart:io";

import "package:flutter/material.dart";
import "package:food_inventory_tracker/widgets/editAddFootItem/buttons_update.dart";
import "package:provider/provider.dart";
import "package:intl/intl.dart";
import "package:path_provider/path_provider.dart" as syspaths;
import "package:path/path.dart" as path;

import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/widgets/editAddFootItem/input_image.dart";
import "package:food_inventory_tracker/widgets/editAddFootItem/edit_appbar.dart";

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  static const routeName = "/add-food-item";

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  bool _isLoading = false;
  final _form = GlobalKey<FormState>(); // Global Key to submit form

  String? _imgUrl;
  String? _name;
  String? _description;
  DateTime? _addedDate;
  DateTime? _expireDate;
  bool _hidden = false;
  File? _pickedImage;

// Function Use In Child WIdget to Select Image File on This widget
  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _presentDatePicker(DateTime? initDate, int dateType) {
    showDatePicker(
      context: context,
      initialDate: initDate == null ? DateTime.now() : initDate,
      firstDate: DateTime(2000),
      lastDate: dateType == 1 ? DateTime.now() : DateTime(2100),
    ).then((pickedData) {
      setState(() {
        if (pickedData == null) {
          return;
        }
        if (dateType == 1) {
          _addedDate = pickedData;
        } else if (dateType == 2) {
          _expireDate = pickedData;
        }
      });
    });
  }

  void _saveForm() async {
    _form.currentState?.validate();
    _form.currentState?.save();
    setState(() {
      _isLoading = !_isLoading;
    });
    //Add New Image If there are any
    if (_pickedImage != null) {
      if (_pickedImage!.path != _imgUrl) {
        final appDoc = await syspaths.getApplicationDocumentsDirectory();
        final String fileName = path.basename(_pickedImage!.path);
        if (_imgUrl != null) {
          await File(_imgUrl.toString()).delete();
        }
        _imgUrl = "${appDoc.path}/${fileName}";
        await _pickedImage!.copy("${_imgUrl}");
        await _pickedImage!.delete();
      }
    } else {
      _imgUrl = null;
    }
    FoodItem newFood = FoodItem(
      id: 0,
      name: _name == "" ? null : _name,
      description: _description == "" ? null : _description,
      imgUrl: _imgUrl,
      addedDate: DateTime.now(),
      expireDate: _expireDate,
      hidden: _hidden,
    );

    Provider.of<FoodItemList>(context, listen: false).addFoodItem(newFood);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _hidden = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      appBar: AppBar(
          title: _isLoading
              ? const CircularProgressIndicator()
              : Text("${_hidden ? "Add New Hidden Item" : "Add New Item"}"),
          actions: [
            EditAppBar(_isLoading, _saveForm),
          ]),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => _name = value,
                  decoration: InputDecoration(
                      labelText: "Food Name",
                      labelStyle: Theme.of(context).textTheme.titleSmall,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 5,
                      )),
                ),
                ImageInput(
                  _imgUrl,
                  _selectImage,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Expire Date",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        _expireDate == null
                            ? const Text("No Expire Date")
                            : Text(DateFormat.yMd()
                                .format(_expireDate!)
                                .toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _presentDatePicker(_expireDate, 2);
                          },
                          child: const Text("Pick Expire Date"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _expireDate = null;
                            });
                          },
                          child: const Text("Remove Expire Date"),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    onChanged: (value) => _description = value,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: Theme.of(context).textTheme.titleSmall,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                    ),
                  ),
                ),
                ButtonsUpdate(_saveForm, 1),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
