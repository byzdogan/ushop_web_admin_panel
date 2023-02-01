import 'package:flutter/material.dart';
import 'package:ushop_admin_panel/consts/constants.dart';
import 'package:ushop_admin_panel/widgets/orders_widget.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.yellow[700]?.withOpacity(0.8),//Theme.of(context).cardColor, //çerçevenin rengi
        borderRadius: const BorderRadius.all(Radius.circular(8)), //10//çervenin köşesi
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Column(
              children: const [
                OrdersWidget(),
                Divider(thickness: 3,),
              ],
            );
          }),
    );
  }
}