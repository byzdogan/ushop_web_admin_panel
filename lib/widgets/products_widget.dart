import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/inner_screens/edit_product.dart';
import 'package:ushop_admin_panel/services/global_method.dart';
import 'package:ushop_admin_panel/services/utils.dart';
import 'package:ushop_admin_panel/widgets/text_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = false;
  String title = "";
  String productCategory = "";
  String? imageUrl;
  String price = "0.0";
  double salePrice = 0.0;
  bool isOnSale = false;
  //bool isPiece = false;

  @override
  void initState() {
    getProductsData();
    super.initState();
  }

  Future<void> getProductsData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.id)
          .get();
      if (productsDoc == null) {
        return;
      } else {
        setState(() {
          title = productsDoc.get("title");
          productCategory = productsDoc.get("productCategoryName");
          imageUrl = productsDoc.get("imageUrl");
          price = productsDoc.get("price");
          salePrice = productsDoc.get("salePrice");
          isOnSale = productsDoc.get("isOnSale");
          //isPiece = productsDoc.get('isPiece');
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(error: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell( //it allows you to press on it
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditProductScreen(
                      id: widget.id,
                      title: title,
                      price: price,
                      salePrice: salePrice,
                      productCat: productCategory,
                      imageUrl: imageUrl == null
                          ? "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg"
                          : imageUrl!,
                      isOnSale: isOnSale,
                      //isPiece: isPiece
              ))
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0), //8 yapınca pixel error
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        imageUrl == null
                        ? "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg"
                        : imageUrl!,
                        fit: BoxFit.fill,
                        // width: screenWidth * 0.12,
                        height: size.width * 0.14, //12
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            child: Text("Edit"),
                            value: 1,
                          ),
                          PopupMenuItem(
                            onTap: () {},
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            value: 2,
                          ),
                        ])
                  ],
                ),
                const SizedBox(
                  height: 4, //
                ),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale ? '${salePrice.toStringAsFixed(2)}₺' : '$price₺',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: isOnSale,
                        child: Text(
                          "$price ₺",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    /*TextWidget(
                      text: "Quantity", //isPiece ? "Piece" : "Kg",
                      color: color,
                      textSize: 18,
                    ),*/
                  ],
                ),
                TextWidget(
                  text: "Stock :", //isPiece ? "Piece" : "Kg",
                  color: color,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 4, //2
                ),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}