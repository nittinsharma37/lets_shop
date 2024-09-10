import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lets_shop/controller/product_controller.dart';
import 'package:lets_shop/model/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments;
    final product = productController.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => Product(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/cart');
            },
            icon: const Icon(Icons.shopping_cart_rounded),
            iconSize: 28,
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (product == null) {
          return const Center(child: Text('Product not found.'));
        }

        return Container(
          margin: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.image ?? 'https://via.placeholder.com/150',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                product.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBarIndicator(
                    rating: product.rating!.rate ?? 0.0,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (productController.quantity.value > 1) {
                        productController.quantity.value--;
                      }
                    },
                  ),
                  Obx(() {
                    return Text(
                      '${productController.quantity.value}',
                      style: const TextStyle(fontSize: 18.0),
                    );
                  }),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      productController.quantity.value++;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Obx(() {
                final isInCart = productController.cart
                    .any((item) => item.product.id == product.id);
                return ElevatedButton(
                  onPressed: () {
                    if (isInCart) {
                      productController.updateQuantity(
                          product, productController.quantity.value);
                      Get.snackbar(
                          'Cart Update', '${product.title} quantity updated.');
                    } else {
                      productController.addToCart(product,
                          quantity: productController.quantity.value);
                      Get.snackbar('Added to Cart',
                          '${product.title} has been added to your cart.');
                    }
                  },
                  child: Text(isInCart ? 'Update Quantity' : 'Add to Cart'),
                );
              }),
              const SizedBox(height: 16.0),
              Text(
                '\$${product.price!.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.green, fontSize: 20.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                textAlign: TextAlign.end,
                product.category!.toUpperCase() ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                textAlign: TextAlign.start,
                product.description! ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }),
    );
  }
}
