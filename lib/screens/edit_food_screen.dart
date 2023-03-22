//===
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
  final _form = GlobalKey<FormState>(); // Global Key to submit form
  DateTime? _addedDate;
  DateTime? _expireDate;

  @override
  void dispose() {
    //To Avoid Memory Leak
    /* _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodDetail = ModalRoute.of(context)?.settings.arguments as FoodItem;
    _addedDate = foodDetail.addedDate;
    _expireDate = foodDetail.expireDate;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Food Item"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
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
                  initialValue: foodDetail.name,
                  decoration: InputDecoration(
                      labelText: "Food Name",
                      labelStyle: Theme.of(context).textTheme.titleSmall,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 5,
                      )),
                ),
                ImageInput(
                  imgUrl: foodDetail.imgUrl!,
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
                          onPressed: () {},
                          child: const Text("Change Added Date"),
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
                            ? Text("No Expire Date")
                            : Text(DateFormat.yMd()
                                .format(_expireDate!)
                                .toString()),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Change Expire Date"),
                        )
                      ],
                    )
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
