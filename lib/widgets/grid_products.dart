import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/consts/constants.dart';
import 'package:ushop_admin_panel/widgets/products_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1,})
      : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  //final bool isInMain; //Checks if the gird is on dashboard screen or not
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
        ),
        itemBuilder: (context, index) {
          return ProductWidget();
        }
        );
  }
}
