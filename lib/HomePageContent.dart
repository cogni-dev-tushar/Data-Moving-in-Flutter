import 'dart:io';

import 'package:flutter/material.dart';
import 'UploadPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> uploadedTexts = [];
  List<String> uploadedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page !!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < uploadedTexts.length; i++)
              Column(
                children: [
                  Text('=> ${uploadedTexts[i]}', style: TextStyle(fontSize: 20)),
                  if (i < uploadedImages.length)
                    Image.file(
                      File(uploadedImages[i]),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            //var text in uploadedTexts) Text('=> $text', style: TextStyle(fontSize: 20),),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPage(
                onTextUploaded: (text) {
                  setState(() {
                    uploadedTexts.add(text);
                  });
                  },
                onImageUploaded: (imagePath) {
                  setState(() {
                    uploadedImages.add(imagePath);
                  });
                },
                onDeleteUploadedText: () {
                  setState(() {
                    if (uploadedTexts.isNotEmpty) {
                      uploadedTexts.removeLast();
                    }
                    if (uploadedImages.isNotEmpty) {
                      uploadedImages.removeLast();
                    }
                  });
                },
              ),
            ),
          );
          },
        child: Icon(Icons.file_upload_outlined),
      ),
    );
  }
}