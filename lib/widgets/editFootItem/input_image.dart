//=====
import "dart:async";
import "dart:io";

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

class ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _getPath() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    //If not Picture is Taken after Camera is open
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDoc = await syspaths.getApplicationDocumentsDirectory();
    final appSup = await syspaths.getApplicationSupportDirectory();
    // final downDir = await syspaths.getDownloadsDirectory();
    final exterCash = await syspaths.getExternalCacheDirectories();
    final exterStor = await syspaths.getExternalStorageDirectory();
    // final libDir = await syspaths.getLibraryDirectory();
    final tempDir = await syspaths.getTemporaryDirectory();

    print("======= App Directory =======");
    print(appDoc.path);
    print("======= App Support =======");
    print(appSup.path);
    /* print("======= Download Path =======");
    print(downDir?.path); */
    print("======= External Cash  =======");
    print(exterCash);
    print("======= External Storage =======");
    print(exterStor?.path);
    /* print("======= Library Directory =======");
    print(libDir.path); */
    print("======= Temporary Directory =======");
    print(tempDir.path);
    final fileName = path.basename(imageFile.path);
    /* await _storedImage!.copy("${appDoc.path}/${fileName}");
    await _storedImage!.copy("${appSup.path}/${fileName}");
    await _storedImage!.copy("${exterStor?.path}/${fileName}");
    await _storedImage!.copy("${tempDir.path}/${fileName}"); */

    widget.onSelectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width - 40;
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: 0),
        // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        height: _screenHeight * 0.5,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              /* decoration:
                  BoxDecoration(border: Border.all(color: Colors.orange)), */
              width: _screenWidth * 0.8,
              child: widget.imgUrl == null
                  ? Image(
                      image: AssetImage('assets/images/noimage.jpg'),
                    )
                  : Image.file(
                      File(widget.imgUrl.toString()),
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
                        _getPath();
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.image_outlined),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
