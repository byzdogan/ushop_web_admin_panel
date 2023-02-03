import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushop_admin_panel/controllers/MenuController.dart';
import 'package:ushop_admin_panel/responsive.dart';
import 'package:ushop_admin_panel/services/utils.dart';
import 'package:ushop_admin_panel/widgets/buttons.dart';
import 'package:ushop_admin_panel/widgets/header.dart';
import 'package:ushop_admin_panel/widgets/side_menu.dart';
import 'package:ushop_admin_panel/widgets/text_widget.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {

  final _formKey = GlobalKey<FormState>();
  String _catValue = "Clothes";
  late final TextEditingController _titleController, _priceController;

  int _groupValue = 1;
  bool isPiece = false;

  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      key: context.read<MenuController>().getAddProductScaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Header(
                         title: "Add Product",
                         showTextField: false,
                         fct: () {
                           context.read<MenuController>().controlAddProductsMenu();
                         }),
                  ),                  
                  const SizedBox(height: 25,),
                  Container(
                    width: size.width > 650 ? 650 : size.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextWidget(
                            text: 'Product title*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _titleController,
                            key: const ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Title';
                              }
                              return null;
                            },
                            decoration: inputDecoration,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'Price in ₺*',
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: TextFormField(
                                          controller: _priceController,
                                          key: const ValueKey('Price ₺'),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Price is missed';
                                            }
                                            return null;
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]')),
                                          ],
                                          decoration: inputDecoration,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextWidget(
                                        text: "Category of the Product", //Product category
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(height: 10),
                                      // Drop down menu code here
                                      _categoryDropDown(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextWidget(
                                        text: "\"Measure unit\"",
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      // Radio button code here
                                      Row(
                                        children: [
                                          TextWidget(
                                            text: "option1",
                                            color: color,
                                          ),
                                          Radio(
                                            value: 1,
                                            groupValue: _groupValue,
                                            onChanged: (valuee) {
                                              setState(() {
                                                _groupValue = 1;
                                                isPiece = false;
                                              });
                                            },
                                            activeColor: Colors.cyan,
                                          ),
                                          TextWidget(
                                            text: "option2",
                                            color: color,
                                          ),
                                          Radio(
                                            value: 2,
                                            groupValue: _groupValue,
                                            onChanged: (valuee) {
                                              setState(() {
                                                _groupValue = 2;
                                                isPiece = true;
                                              });
                                            },
                                            activeColor: Colors.cyan,
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              // Image to be picked code is here
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.width > 755
                                        ? 350
                                        : size.width * 0.45,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: dottedBorder(color: color),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: TextWidget(
                                            text: 'Clear',
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: TextWidget(
                                            text: 'Update image',
                                            color: Colors.cyan,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                  onPressed: () {},
                                  text: 'Clear form',
                                  icon: IconlyBold.danger,
                                  backgroundColor: Colors.red.shade300,
                                ),
                                ButtonsWidget(
                                  onPressed: () {
                                    _uploadForm();
                                  },
                                  text: 'Upload',
                                  icon: IconlyBold.upload,
                                  backgroundColor: Colors.cyan,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0), //8
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {}),
                    child: TextWidget(
                      text: "Choose an image",
                      color: Colors.cyan,
                    ))
              ],
            ),
          )),
    );
  }

  Widget _categoryDropDown() {
    final color = Utils(context).color;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize:18,
              ),
              value: _catValue,
              onChanged: (value) {
                setState(() {
                  _catValue = value!;
                });
                print(_catValue);
              },
              hint: const Text("Select a category"),
              items: const [
                DropdownMenuItem(
                  child: Text(
                    "Clothes",
                  ),
                  value: "Clothes",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Cat2",
                  ),
                  value: "Cat2",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Cat3",
                  ),
                  value: "Cat3",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Others",
                  ),
                  value: "Others",
                ),
              ],
            )),
      ),
    );
  }
}