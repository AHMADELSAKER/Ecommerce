class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  // Future<String> login() async {
  //   var response = await http.get(
  //       Url.base("https://etrans.herokuapp.com/test/2"),
  //       headers: {'Content-Type': 'application/json'});
  //   var data = json.decode(response.body);

  //   print(data[0].name);
  //   return "Success!";
  // }

  List<BannerModel> Banners = [];
  List<ProductModel> Products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      // print("element============================: $element");
      Banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      Products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? name;
  String? image;
  bool? in_favorites;
  bool? in_cart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    old_price = json['old_price'];
    name = json['name'];
    image = json['image'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
