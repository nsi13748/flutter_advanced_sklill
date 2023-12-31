import 'package:ch1_basic_ui/common/layout/default_layout.dart';
import 'package:ch1_basic_ui/product/component/product_card.dart';
import 'package:ch1_basic_ui/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '임시 타이틀 불타는 떡볶이',
        child: Column(
          children: [
            RestaurantCard(
              image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
              name: '불타는 떡복이',
              tags: ['tags', '치즈'],
              ratingsCount: 100,
              deliveryTime: 30,
              deliveryFee: 3000,
              ratings: 4.76,
              isDetail: true,
              detail: '맛있는 떡볶이',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 16.0),
              child: ProductCard(),
            ),
          ],
        ));
  }
}
