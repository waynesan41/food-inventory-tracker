//=====
import "package:flutter/material.dart";

class ImageInput extends StatefulWidget {
  final String? imgUrl;
  const ImageInput({this.imgUrl});

  @override
  State<ImageInput> createState() => ImageInputState();
}

class ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width - 40;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        height: _screenHeight * 0.5,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              /* decoration:
                  BoxDecoration(border: Border.all(color: Colors.orange)), */
              width: _screenWidth * 0.8,
              child: Image.network(widget.imgUrl!),
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
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: Icon(Icons.image_outlined),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: Icon(Icons.cancel_outlined),
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
