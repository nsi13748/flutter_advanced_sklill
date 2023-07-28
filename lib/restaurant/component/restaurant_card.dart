import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:ch1_basic_ui/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image; // 이미지
  final String name; // 가게 이름
  final List<String> tags; // 태크
  final int ratingsCount; // 평점 개수
  final int deliveryTime; // 배달 시간
  final int deliveryFee; //  배달 요금
  final double ratings; //  평균 평점

  final bool isDetail; // 상세페이지 여부 -> 상세페이지면 좌우 패딩을 덜 주기 위함.
  final String? detail; // 상세 내용


  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
    super.key,
  });


  factory RestaurantCard.fromModel ({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
        image: Image.network(
          model.thumbUrl,
          fit: BoxFit
              .cover, // Image.asset()의 fit: -> BoxFit.cover를 해야 이미지가 꽉찬다.
        ),
        name: model.name,
        tags: model.tags,
        ///  리스트로 받아왔지만, 기본값으로 List<dynamic> 타입으로 들어오게 된다.
        ratingsCount: model.ratingsCount,
        deliveryTime: model.deliveryTime,
        deliveryFee: model.deliveryFee,
        ratings: model.ratings,
        isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상세페이지 인 경우
        if(isDetail)
          image,
        // isDetail이 false 일때만 바로 아래 코드가 실행된다.
        if(!isDetail)
        // 테두리를 깎아주는 위젯
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // stretch를 해야 좌측 정렬이 된다.
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                tags.join(' · '),
                style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(icon: Icons.star, label: ratings.toString()),
                  _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
                  _IconText(
                      icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                  _IconText(icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),),
                ],
              ),
              // 상세 내용
              if(detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(detail!),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// 별 + 별점 을 하나의 위젯으로
class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

