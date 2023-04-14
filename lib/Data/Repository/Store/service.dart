import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Store/repository.dart';

class Service {
  Repository? _repository;

  Service() {
    _repository = Repository();
  }

  saveProduct(Product product) async {
    return await _repository!.insertData('store', product.toJson());
  }

  readProduct() async {
    return await _repository!.readData('store');
  }

  deleteProduct(dispatchId) async {
    return await _repository!.deleteData('store', dispatchId);
  }
}