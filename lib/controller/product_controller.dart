import 'package:get/get.dart';
import 'package:lets_shop/model/cart_model.dart';
import 'package:lets_shop/model/product_model.dart';
import 'package:lets_shop/services/api_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  final ApiService apiService = ApiService();
  var cart = <CartItem>[].obs;

  var quantity = 1.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var fetchedProducts = await apiService.fetchProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void addToCart(Product product, {required int quantity}) {
    var existingItem =
        cart.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      cart.add(CartItem(product: product, quantity: quantity));
    }
    update(); // Notify listeners
  }

  void updateQuantity(Product product, int quantity) {
    var existingItem =
        cart.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      if (quantity <= 0) {
        cart.remove(existingItem);
      } else {
        existingItem.quantity = quantity;
      }
    }
    update(); // Notify listeners
  }

  void removeFromCart(Product product) {
    var itemToRemove =
        cart.firstWhereOrNull((item) => item.product.id == product.id);
    if (itemToRemove != null) {
      cart.remove(itemToRemove);
    }
    update(); // Notify listeners
  }
}
