import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/consts/constants.dart';
import 'package:ushop_admin_panel/controllers/MenuController.dart';
import 'package:ushop_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    children: const [
                      // MyProductsHome(),
                      // SizedBox(height: defaultPadding),
                      // OrdersScreen(),
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