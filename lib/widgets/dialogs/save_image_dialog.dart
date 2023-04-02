//==

import "package:flutter/material.dart";
import "package:gallery_saver/gallery_saver.dart";

import "package:food_inventory_tracker/model/food_item.dart";

class SaveImageDialog extends StatelessWidget {
  final FoodItem _foodDetail;
  const SaveImageDialog(this._foodDetail);

  @override
  Widget build(BuildContext context) {
    void _saveImage() {
      if (_foodDetail.imgUrl != null) {
        GallerySaver.saveImage(_foodDetail.imgUrl!,
            albumName: "Food Inventory Tracker");
      }
    }

    return AlertDialog(
      title: const Text("Save Image To Gallary"),
      content: const Text(
          "Image is save to Food Inventory Track Folder in Photo Gallary"),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blue[600],
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green[600],
            ),
          ),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
          onPressed: () {
            _saveImage();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: const Duration(seconds: 3),
              content: Text("Image Saved"),
            ));

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
