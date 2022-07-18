import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:application/utils/contants.dart';
import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

class FormScreen extends StatefulWidget {
  final PostModel? postModel;

  FormScreen({this.postModel});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Declaration
  PostService _postService = PostService();

  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerMatkul = TextEditingController();
  TextEditingController _controllernidn = TextEditingController();
  TextEditingController _controllerbidang = TextEditingController();

  @override
  void initState() {
    if (widget.postModel != null) {
      _controllerTitle.text = widget.postModel!.nama;
      _controllerDescription.text = widget.postModel!.prodi;
      _controllerMatkul.text = widget.postModel!.matkul;
      _controllernidn.text = widget.postModel!.nidn;
      _controllerbidang.text = widget.postModel!.bidang;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.postModel == null ? 'Form Create' : 'Form Update',
            style: primaryText.copyWith(color: secondaryColor)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerTitle,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'nama',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'masukkan nama',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _controllernidn,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required description';
                    }

                    return null;
                  },
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'NIDN',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'masukkan NIDN',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  controller: _controllerbidang,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required description';
                    }

                    return null;
                  },
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Rumpun Bidang Dosen',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'masukkan Rumpun Bidang Dosen',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  controller: _controllerDescription,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required description';
                    }

                    return null;
                  },
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'program studi',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'msaukan pogram studi',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  controller: _controllerMatkul,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required description';
                    }

                    return null;
                  },
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Mata kuliah',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'masukkan mata kuliah',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),


                ElevatedButton(
                  onPressed: () async {
                    // Check validate
                    if (_formKey.currentState!.validate()) {
                      // Declartion loading, controller, & model
                      setState(() => _isLoading = true);

                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      PostModel postModel = PostModel(
                        userId: (sharedPreferences.getInt("userId"))!,
                        nama: _controllerTitle.text.toString(),
                        prodi: _controllerDescription.text.toString(),
                        matkul: _controllerMatkul.text.toString(),
                        nidn: _controllernidn.text.toString(),
                        bidang: _controllerbidang.text.toString(),
                      );
                      PostModel _postModel = postModel;

                      if (widget.postModel == null) {
                        // Create post
                        _postService.createPost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Create Post Failed')),
                            );
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                        });
                      } else {
                        // Update post
                        _postModel.id = widget.postModel!.id;

                        _postService.updatePost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Update Post Failed')),
                            );
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                        });
                      }
                    }
                  },
                  // Loading or text
                  child: _isLoading
                      ? Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: secondaryColor),
                          child: SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator()),
                        )
                      : Text('Save'),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
