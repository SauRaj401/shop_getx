import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoft/controllers/cart_controller.dart';
import 'package:websoft/controllers/shopping_Controller.dart';

class ShoppingPage extends StatelessWidget {
  //appling dependency injection
  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetX<ShoppingController>(builder: (controller) {
              return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.products[index].productName}',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                        '${controller.products[index].productDescription}'),
                                  ],
                                ),
                                Text('\$${controller.products[index].price}',
                                    style: TextStyle(fontSize: 24)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                cartController
                                    .addToCart(controller.products[index]);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // Obx(
                            //   () => IconButton(
                            //     icon: controller
                            //             .products[index].isFavorite.value
                            //         ? Icon(Icons.check_box_rounded)
                            //         : Icon(
                            //             Icons.check_box_outline_blank_outlined),
                            //     onPressed: () {
                            //       controller.products[index].isFavorite
                            //           .toggle();
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  });
            }),
          ),
          GetX<CartController>(builder: (controller) {
            return Text('Total amount: \$ ${controller.totalPrice} ');
          }),
          SizedBox(
            height: 100,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.amber,
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.black,
          ),
          label: GetX<CartController>(builder: (controller) {
            return Text(
              controller.count.toString(),
              style: TextStyle(color: Colors.black, fontSize: 24),
            );
          })),
    );
  }
}
