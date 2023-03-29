//===
import "dart:io";

import "package:flutter/material.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/widgets/editAddFootItem/buttons_update.dart";
import 'package:food_inventory_tracker/widgets/editAddFootItem/edit_appbar.dart';
import "package:intl/intl.dart";
import "package:path_provider/path_provider.dart" as syspaths;
import "package:path/path.dart" as path;

import "package:food_inventory_tracker/model/food_item.dart";
import 'package:food_inventory_tracker/widgets/editAddFootItem/input_image.dart';
import "package:provider/provider.dart";

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
  // final _name = TextEditingController();
  String? _imgUrl;

  // final _description = TextEditingController();
  String? _name;
  // String? _imgUrl;
  String? _description;
  DateTime? _addedDate;
  DateTime? _expireDate;
  File? _pickedImage;
  late bool _hidden;
  late DateTime? _deleted;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
    print("XXXXXXXXXX Picked Image XXXXXXXXXXX");
    print(_pickedImage?.path ?? "No Image Selected");
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
      print(foodDetail.name);
      _name = foodDetail.name == null ? "" : foodDetail.name.toString();
      _imgUrl = foodDetail.imgUrl;
      _addedDate = foodDetail.addedDate;
      _expireDate = foodDetail.expireDate;
      _description = foodDetail.description.toString();
      _hidden = foodDetail.hidden;
      _deleted = foodDetail.deleted;
      _pickedImage =
          _imgUrl == null ? null : File(foodDetail.imgUrl.toString());
    }
    super.didChangeDependencies();
  }

  void _saveForm() async {
    _form.currentState?.validate();
    _form.currentState?.save();
    setState(() {
      _isLoading = !_isLoading;
    });
    //Update Edit Food Here
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
      if (_imgUrl != null) {
        await File(_imgUrl.toString()).delete();
        _imgUrl = null;
      }
    }
    FoodItem updatedFood = FoodItem(
      id: _id,
      name: _name == "" ? null : _name,
      description: _description == "" ? null : _description,
      imgUrl: _imgUrl,
      addedDate: _addedDate!,
      expireDate: _expireDate,
      hidden: _hidden,
      deleted: _deleted,
    );
    print("11111111111BMIT ISSSSSS CALL");
    Provider.of<FoodItemList>(context, listen: false)
        .editFoodItem(_id, updatedFood);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              _isLoading ? CircularProgressIndicator() : Text("Edit Food Item"),
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
                  initialValue: _name ?? "",
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
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    onChanged: (value) => _description = value,
                    initialValue: _description ?? "",
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
                ButtonsUpdate(_saveForm, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
