import 'package:flutter/material.dart';
import 'package:flutter_authentication/provider/dashboard_provider.dart';
import 'package:flutter_authentication/res/app_localization_text/app_localization_text.dart';
import 'package:flutter_authentication/res/colors/app_color.dart';
import 'package:flutter_authentication/res/components/custom_text.dart';
import 'package:flutter_authentication/view_screen/dashboard/widget/edit_widget.dart';
import 'package:flutter_authentication/view_screen/dashboard/widget/floating_button.dart';
import 'package:flutter_authentication/view_screen/dashboard/widget/image_widget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: CustomTextWidget(
              text: AppLocalizationText.appBar_text,
              fontSize: 18,
              color: AppColors.textBlack,
            ),
          ),
          backgroundColor: AppColors.appBar_color,
          elevation: 10,
          shadowColor: Colors.black54,
          automaticallyImplyLeading: false,
        ),

        //----for list widge
        body: Consumer<DashboardProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final item = value.items[index];
                return GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0) {
                      value.changeDelete(true);

                    } else if (details.delta.dx < 0) {
                      value.changeDelete(false);
                    }
                  },
                  onHorizontalDragEnd: (_) {
                    value.changeDelete(false);
                  },
                  child: Dismissible(
                    key: Key(item.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 20.0,left: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    direction: value.isDeleting ? DismissDirection.none : DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      value.removeItems(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Title: ${item.title} dismissed"),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              value.insertItems(index, item);
                            },
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: [
                            //----for image widget
                            ImageWidget(),

                            SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.description.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //----for edit items
                            EditIconWidget(index: index),
                          ],
                        ),
                      ),

                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingButton()
    );
  }
}




