//===
import "dart:io";

import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/widgets/editFootItem/input_image.dart";

class EditFoodScreen extends StatefulWidget {
  const EditFoodScreen({super.key});
  static const routName = "/edit-food-item";

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  bool _initial = true;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>(); // Global Key to submit form
  late int _id;
  String? _name;
  String? _imgUrl;
  String? _description;
  DateTime? _addedDate;
  DateTime? _expireDate;
  File? _pickedImage;

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

  @override
  void initState() {
    _initial = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_initial) {
      final foodDetail = ModalRoute.of(context)?.settings.arguments as FoodItem;
      _id = foodDetail.id;
      _name = foodDetail.name;
      _imgUrl = foodDetail.imgUrl;
      _addedDate = foodDetail.addedDate;
      _expireDate = foodDetail.expireDate;
      _description = foodDetail.description;
    }
    super.didChangeDependencies();
  }

  void _saveForm() async {
    _form.currentState?.validate(); //Check Filter Input from form
    _form.currentState?.save(); // Save Form
    setState(() {
      _isLoading = !_isLoading;
    });

    FoodItem updatedFood = FoodItem(id: _id, addedDate: _addedDate!);

    /* setState(() {
      _isLoading = false;
    }); */
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    /* final foodDetail = ModalRoute.of(context)?.settings.arguments as FoodItem;
    _addedDate = foodDetail.addedDate;
    _expireDate = foodDetail.expireDate; */
    return Scaffold(
      appBar: AppBar(
        title:
            _isLoading ? CircularProgressIndicator() : Text("Edit Food Item"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
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
          )
        ],
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _name,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Added Date",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(DateFormat.yMd()
                            .add_jm()
                            .format(_addedDate!)
                            .toString()),
                        ElevatedButton(
                          onPressed: () {
                            _presentDatePicker(_addedDate, 1);
                          },
                          child: const Text("Change Added Date"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _addedDate = DateTime.now();
                            });
                          },
                          child: const Text("Set  Date to Now"),
                        )
                      ],
                    ),
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
                        ElevatedButton(
                          onPressed: () {
                            _presentDatePicker(_expireDate, 2);
                          },
                          child: const Text("Change Expire Date"),
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
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    initialValue: _description,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: Text("Cancel"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[700])),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text("Update"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[700])),
                      onPressed: () {
                        _saveForm();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
