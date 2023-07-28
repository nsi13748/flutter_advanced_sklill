import '../../common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });


  // factory 생성자이고,  RestaurantModel.fromJson() 이거 자체가 named 생성자이다.
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json
  }) {
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: 'http://$ip${json['thumbUrl']}',
        tags: List<String>.from(json['tags']),
        priceRange: RestaurantPriceRange.values.firstWhere((e) => e.name == json['priceRange']),  /// enum의 값을 리스트로
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee']);
  }
}