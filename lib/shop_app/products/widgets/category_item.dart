
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../shop_app_models/categories_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.model, required this.height, required this.width,});

  final double height;
  final double width;
  final DataModel? model;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: model?.image ?? '',
          fit: BoxFit.fill,
          width: width/2.5,
          height: height/6,
          placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
        ),
        Container(
          color: Colors.grey.withOpacity(.5),
          width: 120,
          height: 15,
          child: Text(
            model?.name ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                height: 1.5),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}



