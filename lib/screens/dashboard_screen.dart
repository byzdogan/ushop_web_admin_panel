import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/consts/constants.dart';
import 'package:ushop_admin_panel/controllers/MenuController.dart';
import 'package:ushop_admin_panel/responsive.dart';
import 'package:ushop_admin_panel/services/utils.dart';
import 'package:ushop_admin_panel/widgets/grid_products.dart';
import 'package:ushop_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:ushop_admin_panel/widgets/products_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MenuController>().controlDashboarkMenu(); //how to access a provider
              },
            ),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGridWidget(
                          crossAxisCount: size.width < 755 ? 2 : 4, //650
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        ),
                        desktop: ProductGridWidget(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}