import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'package:tyba_test/src/utils/routes/navigation.dart';
import 'package:tyba_test/src/utils/routes/open_url.dart';

import '../utils/theme/colors.dart';
import '../utils/theme/text_style.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = 'detailScreen';
  // ignore: prefer_typing_uninitialized_variables
  final bloc;
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const DetailScreen({this.bloc, this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _content(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToHome(context, true, widget.bloc);
        },
        backgroundColor: AppColors.primaryDarkColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _content(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: GestureDetector(
                onTap: () {
                  _openGallery();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child:
                      widget.bloc.state.universities[widget.index].image == null
                          ? Image.asset('assets/no-Image-Icon.png')
                          : Image.file(
                              fit: BoxFit.cover,
                              File(widget.bloc.state.universities[widget.index]
                                  .image!),
                            ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(32),
              height: 350,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: AppColors.primaryLigthColor.withOpacity(0.4),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 1.h),
                      Text(
                        widget.bloc.state.universities[widget.index].name,
                        style: title,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Country: ${widget.bloc.state.universities[widget.index].country}',
                        style: subTitle,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Open website',
                            style: subTitle,
                          ),
                          IconButton(
                            onPressed: () {
                              launchURL(widget.bloc.state
                                  .universities[widget.index].webPages[0]);
                            },
                            icon: Icon(
                              Icons.pageview_rounded,
                              color: AppColors.primaryDarkColor,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        width: 70.w,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            labelText: 'Number of students',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white),
                            ),
                            labelStyle:
                                TextStyle(color: AppColors.primaryDarkColor),
                            icon: Icon(
                              Icons.person_add,
                              color: AppColors.primaryDarkColor,
                            ),
                          ),
                          onFieldSubmitted: (d) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       widget.bloc.state.universities[widget.index].name = 'xd';
            //     });
            //   },
            //   child: Text(widget.bloc.state.universities[widget.index].name),
            // ),
          ],
        ),
      );

  void _openGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );

      setState(() {
        if (result != null) {
          if (result.files.isNotEmpty) {
            widget.bloc.state.universities[widget.index].image =
                result.files[0].path;
          }
        }
      });
    } catch (e) {
      throw Error();
    }
  }
}
