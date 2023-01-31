import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/services/utils.dart';
import 'package:ushop_admin_panel/widgets/text_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                        "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
                        fit: BoxFit.fill,
                        // width: screenWidth * 0.12,
                        height: size.width * 0.12,
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
                      text: "200₺",
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          "250₺",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: "Quantity",
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4, //2
                ),
                TextWidget(
                  text: 'Title',
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