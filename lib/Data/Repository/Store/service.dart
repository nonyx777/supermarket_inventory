import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Store/repository.dart';

class Service {
  Repository? _repository;

  Service() {
    _repository = Repository();
  }

  saveProduct(Product product) async {
    return await _repository!.insertData('Store', product.toJson());
  }

  readProduct() async {
    return await _repository!.readData('Store');
  }

  updateProduct(Product product) async {
    return await _repository!.updateData('Store', product.toJson());
  }

  deleteProduct(dispatchId) async {
    return await _repository!.deleteData('Store', dispatchId);
  }
}