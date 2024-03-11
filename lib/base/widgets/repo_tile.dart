import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leadsoft_test_app/data/model/response.dart';

class RepoTile extends StatelessWidget {
  final Item item;
  final bool isFavorite;
  final ValueSetter<Item>? onPressed;

  const RepoTile(
      {super.key,
      required this.item,
      this.onPressed,
      this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(10)
    ),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        if(item.description != null) Text(item.description!)
      ],),
          ),
          IconButton(
            icon: SvgPicture.asset('assets/images/favorite.svg',
              color: isFavorite ?  const Color(0xFF1463F5) : const Color(0xFFBFBFBF),
            ),
            onPressed: () {onPressed?.call(item);},
          )
      ],),
    );
  }

}
