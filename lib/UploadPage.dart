import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPage extends StatefulWidget {
  final Function(String) onTextUploaded;
  final Function() onDeleteUploadedText;
  final Function(String) onImageUploaded;

  UploadPage({
    Key? key,
    required this.onTextUploaded,
    required this.onDeleteUploadedText,
    required this.onImageUploaded,
  }) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  String uploadedText = '';
  String? uploadedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        uploadedImage = pickedFile.path;
      });

      widget.onImageUploaded(uploadedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Upload Page !!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Name !!',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0)),
                prefixIcon: Icon(Icons.drive_file_rename_outline_outlined, color: Colors.greenAccent,),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Price !!',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0)),
                prefixIcon: Icon(Icons.currency_rupee_outlined, color: Colors.greenAccent,),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Pick Image'),
            ),
            if (uploadedImage != null)
              Image.file(
                File(uploadedImage!),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String enteredText = _textFieldController.text;
                      String enteredNumber = _numberController.text;
                      widget.onTextUploaded('$enteredText: \$$enteredNumber');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Uploaded: $enteredText', style: TextStyle(color: Colors.black),),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.greenAccent,
                          behavior: SnackBarBehavior.floating,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        ),
                      );
                      },
                    child: Text('Upload'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String deletedText = uploadedText;
                      widget.onDeleteUploadedText();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted: $deletedText'),
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          ),
                      );
                      },
                    child: Text('Delete'),
                  ),
                ]
            ),

            SizedBox(height: 20),
            Text('=> $uploadedText'),


          ],
        ),
      ),
    );
  }
}