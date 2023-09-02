import 'dart:io';

// import 'package:camera_application/image.dart';
import 'package:camera_cp/main.dart';
import 'package:camera_cp/image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  ValueNotifier<List> image = ValueNotifier([]);

  File? imageFile;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    get();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Camera'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          getimage();
        },
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: image,
          builder: (context, value, child) {
            return GridView.builder(
              itemCount: image.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageView(image: image.value[index]),
                    ));
                  },
                  child: Image(
                    image: FileImage(File(image.value[index])),
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

    void get() async {
    dynamic directory = await getExternalStorageDirectory();
    getItems(directory);
  }

  void getimage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      Directory? directory = await getExternalStorageDirectory();
      File imagePath = File(image.path);
      await imagePath.copy('${directory!.path}/${DateTime.now()}.jpg');

      getItems(directory);
    }
  }

  void getItems(Directory directory) async {
    final listDir = await directory.list().toList();
    image.value.clear();
    for (var i = 0; i < listDir.length; i++) {
      image.value.add(listDir[i].path);
      image.notifyListeners();
    }
  }


}