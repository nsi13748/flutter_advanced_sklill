import 'package:ch1_basic_ui/restaurant/component/restaurant_card.dart';
import 'package:ch1_basic_ui/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  // restaurant API에서 data 라는 키값에 있는 List형식의 데이터를 가져오는 함수 구현
  Future<List> pagenateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List>(
          future: pagenateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel(
                      id: item['id'],
                      name: item['name'],
                      thumbUrl: 'http://$ip${item['thumbUrl']}',
                      tags: List<String>.from(item['tags']),
                      priceRange: RestaurantPriceRange.values.firstWhere((e) => e.name == item['priceRange']),  /// enum의 값을 리스트로
                      ratings: item['ratings'],
                      ratingsCount: item['ratingsCount'],
                      deliveryTime: item['deliveryTime'],
                      deliveryFee: item['deliveryFee']);

                  return RestaurantCard(
                      image: Image.network(
                        pItem.thumbUrl,
                        fit: BoxFit
                            .cover, // Image.asset()의 fit: -> BoxFit.cover를 해야 이미지가 꽉찬다.
                      ),
                      name: pItem.name,
                      tags: pItem.tags,
                      ///  리스트로 받아왔지만, 기본값으로 List<dynamic> 타입으로 들어오게 된다.
                      ratingsCount: pItem.ratingsCount,
                      deliveryTime: pItem.deliveryTime,
                      deliveryFee: pItem.deliveryFee,
                      ratings: pItem.ratings);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 8,
                  );
                });
          },
        ),
      )),
    );
  }
}
