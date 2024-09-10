import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_shop/controller/product_controller.dart';

class ShoppingCartScreen extends StatelessWidget {
  ShoppingCartScreen({super.key});

  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Obx(() {
        if (productController.cart.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }

        double totalPrice = productController.cart.fold(
          0.0,
          (sum, item) => sum + (item.product.price! * item.quantity),
        );

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productController.cart.length,
                itemBuilder: (context, index) {
                  final item = productController.cart[index];
                  return InkWell(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/productDetails',
                          arguments: item.product.id);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      elevation: 4.0,
                      child: Container(
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.network(
                                item.product.image ??
                                    'https://via.placeholder.com/150',
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.product.title!,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Price: \$${item.product.price!.toStringAsFixed(2)}'),
                                        Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.remove),
                                                    onPressed: () {
                                                      if (item.quantity > 1) {
                                                        productController
                                                            .updateQuantity(
                                                                item.product,
                                                                item.quantity -
                                                                    1);
                                                      } else {
                                                        productController
                                                            .removeFromCart(
                                                                item.product);
                                                      }
                                                    },
                                                  ),
                                                  GetBuilder<ProductController>(
                                                    builder: (controller) =>
                                                        Text('${item.quantity}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.add),
                                                    onPressed: () {
                                                      productController
                                                          .updateQuantity(
                                                              item.product,
                                                              item.quantity +
                                                                  1);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () => productController
                                                  .removeFromCart(item.product),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // child: ListTile(
                      //   contentPadding: const EdgeInsets.all(8.0),
                      //   leading: Image.network(
                      //     item.product.image ?? 'https://via.placeholder.com/150',
                      //     width: 60,
                      //     height: 60,
                      //     fit: BoxFit.contain,
                      //   ),
                      //   title: Text(item.product.title!),
                      //   subtitle: Text(
                      //       'Price: \$${item.product.price!.toStringAsFixed(2)}'),
                      //   trailing: SizedBox(
                      //     width: 110,
                      //     child: Wrap(
                      //       children: [
                      //         Container(
                      //           child: Row(
                      //             children: [
                      //               IconButton(
                      //                 icon: const Icon(Icons.remove),
                      //                 onPressed: () {
                      //                   if (item.quantity > 1) {
                      //                     productController.updateQuantity(
                      //                         item.product, item.quantity - 1);
                      //                   } else {
                      //                     productController
                      //                         .removeFromCart(item.product);
                      //                   }
                      //                 },
                      //               ),
                      //               GetBuilder<ProductController>(
                      //                 builder: (controller) => Text(
                      //                     '${item.quantity}',
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyMedium),
                      //               ),
                      //               IconButton(
                      //                 icon: const Icon(Icons.add),
                      //                 onPressed: () {
                      //                   productController.updateQuantity(
                      //                       item.product, item.quantity + 1);
                      //                 },
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         IconButton(
                      //           icon: const Icon(Icons.delete),
                      //           onPressed: () => productController
                      //               .removeFromCart(item.product),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Check out"))
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
