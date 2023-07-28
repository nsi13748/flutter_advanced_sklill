import 'package:ch1_basic_ui/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image; // 이미지
  final String name; // 가게 이름
  final List<String> tags; // 태크
  final int ratingsCount; // 평점 개수
  final int deliveryTime; // 배달 시간
  final int deliveryFee; //  배달 요금
  final double ratings; //  평균 평점

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 테두리를 깎아주는 위젯
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 16),
        Column(
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
                _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                _IconText(icon: Icons.monetization_on, label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),),
              ],
            )
          ],
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

