import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Market/repository.dart';

class Service {
  Repository? _repository;

  Service() {
    _repository = Repository();
  }

  saveProduct(Product product) async {
    return await _repository!.insertData('Market', product.toJson());
  }

  readProduct() async {
    return await _repository!.readData('Market');
  }

  updateProduct(Product product) async {
    return await _repository!.updateData('Market', product.toJson());
  }

  deleteProduct(dispatchId) async {
    return await _repository!.deleteData('Market', dispatchId);
  }
}
