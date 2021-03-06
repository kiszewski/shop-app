import 'package:shopApp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository(this._firestore);

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map(
              (document) => ProductModel.fromJson(document.id, document.data()))
          .toList();
    });
  }

  Future<String> addProduct(ProductModel product) async {
    DocumentReference document = await _firestore.collection('products').add({
      'name': product.name,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'description': product.description,
    });

    return document.id;
  }

  void updateProduct(ProductModel product, String name, String imageUrl,
      double price, String description) async {
    final CollectionReference products = _firestore.collection('products');

    products.doc(product.id).update({
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description
    });
  }

  void removeProduct(ProductModel product) async {
    final CollectionReference products = _firestore.collection('products');

    await products.doc(product.id).delete();
  }
}
