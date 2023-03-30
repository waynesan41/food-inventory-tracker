//=====
import "dart:async";
import "dart:io";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspaths;

class ImageInput extends StatefulWidget {
  final String? imgUrl;
  final Function onSelectImage;
  const ImageInput(
    this.imgUrl,
    this.onSelectImage,
  );

  @override
  State<ImageInput> createState() => ImageInputState();
}

//==============================================

class ImageInputState extends State<ImageInput> {
  File? _storedImage;
  bool _init = false;
  Future<void> _getGallaryPhoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    print("+++++++ Image File Path ++++++++++++++++");
    print(imageFile.path);
    setState(() {
      _storedImage = File(imageFile.path);
    });
    print("+++++++ _SelectedPath ++++++++++++++++");
    print(_storedImage!.path);

    widget.onSelectImage(_storedImage);
  }

  Future<void> _getCameraPhoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    //If not Picture is Taken after Camera is open
    if (imageFile == null) {
      return;
    }
    print("+++++++ Image File Path ++++++++++++++++");
    print(imageFile.path);
    setState(() {
      _storedImage = File(imageFile.path);
    });
    print(_storedImage!.path);

    widget.onSelectImage(_storedImage);
  }

  @override
  void initState() {
    _init = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      _storedImage =
          widget.imgUrl == null ? null : File(widget.imgUrl.toString());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width - 40;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        height: _screenHeight * 0.5,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              /* decoration:
                  BoxDecoration(border: Border.all(color: Colors.orange)), */
              width: _screenWidth * 0.8,
              child: _storedImage == null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: const Text("No Image Added"),
                      ),
                    )
                  : Image.file(
                      _storedImage!,
                      fit: BoxFit.contain,
                    ),
            ),
            Container(
              width: _screenWidth * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        _getCameraPhoto();
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(
                        Icons.image_outlined,
                      ),
                      onPressed: () {
                        _getGallaryPhoto();
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: _storedImage == null
                          ? () {
                              widget.onSelectImage(null);
                            }
                          : () async {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("DELETE Image"),
                                  content: const Text(
                                      "Do you want to REMOVE Image!"),
                                  actions: <Widget>[
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.green[600],
                                        ),
                                      ),
                                      child: const Text("Cancel",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.red[600],
                                        ),
                                      ),
                                      child: const Text("DELETE",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        setState(() {
                                          widget.onSelectImage(null);
                                          _storedImage = null;
                                        });
                                        Navigator.of(ctx).pop(false);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
