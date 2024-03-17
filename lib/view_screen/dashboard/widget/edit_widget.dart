import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/dashboard_provider.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/custom_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/custom_textformfield.dart';

class EditIconWidget extends StatefulWidget {
  int index;
  EditIconWidget({super.key,required this.index});

  @override
  State<EditIconWidget> createState() => _EditIconWidgetState();
}

class _EditIconWidgetState extends State<EditIconWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.icon_color,
      ),
      child: IconButton(
        onPressed: (){
          _showAddItemBottomSheetEditable(context,widget.index);
        },
        icon: Icon(
          Icons.edit,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  void _showAddItemBottomSheetEditable(BuildContext context, int index) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final provider=Provider.of<DashboardProvider>(context,listen: false);
    titleController.text = provider.items[index].title;
    descriptionController.text = provider.items[index].description;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
            final screenHeight = MediaQuery.of(context).size.height;
            final maxFraction = 0.5; // Maximum fraction of screen height for bottom sheet when keyboard is hidden
            final minFraction = 1.0; // Minimum fraction of screen height for bottom sheet when keyboard is shown

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: maxFraction * screenHeight,
                    maxHeight: minFraction * screenHeight,
                  ),
                  padding: EdgeInsets.only(
                    top: (screenHeight - keyboardHeight < maxFraction * screenHeight) ? (screenHeight - keyboardHeight) / 2 : 0,
                    bottom: keyboardHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                            text: "Edit Item"
                        ),
                        SizedBox(height: 16.0),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15
                              ),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey,
                                child: Image.asset(
                                  'assets/aaa.jpg', // Add your image path here
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextButton(
                                  onPressed: (){
                                    dialog(context);
                                  },
                                  child: Text("Pick",style: TextStyle(color: Colors.blueAccent),)),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        CustomTextField(
                            controller: titleController,
                            labelText: "Title"
                        ),
                        SizedBox(height: 16.0),
                        CustomTextField(
                            controller: descriptionController,
                            labelText: "Description"
                        ),
                        SizedBox(height: 16.0),
                        CustomElevatedButton(
                          text: "Save",
                          backgroundColor: AppColors.btn_color,
                          onPressed:  () {
                            provider.editItems(index, titleController.text, descriptionController.text);
                            Navigator.pop(context);
                          },),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container()),
                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  getImgCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              // margin: EdgeInsets.only(top: 20,left: 15),
                              child: Text("Camera",style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                            )
                          ],
                        )
                    ),


                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: IconButton(
                                icon: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  getImgGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text("Gallery",style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                            )
                          ],
                        )
                    ),

                    Flexible(
                        flex: 1,
                        child: Container()),
                  ],
                )
            ),
          );
        });
  }
  void getImgCamera() async {
    try {
      final image11 = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxWidth: 400,
          maxHeight: 800);
      if (image11 == null) return;
      final imageTemp = File(image11.path);
    }
    on PlatformException catch (e) {
      log(e.toString());
    }
  }
  void getImgGallery() async {
    try {
      final image11 = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxWidth: 400,
          maxHeight: 800);
      if (image11 == null) return;
      final imageTemp = File(image11.path);
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }
}
