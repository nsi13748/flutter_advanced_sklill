import 'package:ch1_basic_ui/restaurant/component/restaurant_card.dart';
import 'package:ch1_basic_ui/restaurant/model/restaurant_model.dart';
import 'package:ch1_basic_ui/restaurant/view/restaurant_detail_screen.dart';
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
          // => Api 요청을 해서 resp.data['data'] 를 반환하는 함수
          builder: (context, AsyncSnapshot<List> snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(json: item);

                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(model: pItem));
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
