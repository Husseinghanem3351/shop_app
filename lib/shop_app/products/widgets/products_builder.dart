import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/products/widgets/category_item.dart';
import 'package:shop_app/shop_app/products/widgets/grid_product.dart';
import 'package:shop_app/shop_app_models/categories_model.dart';
import 'package:shop_app/shop_app_models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProductsBuilder extends StatelessWidget {
  const ProductsBuilder({
    super.key,
    required this.categoriesModel,
    required this.homeModel,
  });

  final HomeModel? homeModel;
  final CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
       return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel?.data?.banners!
                .map((e) => CachedNetworkImage(
              imageUrl: e.image,
              errorWidget: (context, url, error) => const Image(
                image: AssetImage(
                    'D:\flutter project\new_flutter_udemy\assets\images\bannerImageError.PNG'),
              ),
            ))
                .toList(),
            options: CarouselOptions(
              height: height/4,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: height/5,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CategoryItem(model: categoriesModel?.data.data[index],height: height,width: width,);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel?.data.data.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Text(
                  'New Products',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.count(
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  homeModel?.data?.products.length ?? 0,
                      (index) =>
                      GridProduct(productModel: homeModel?.data!.products[index],width:width,height:height ),
                ),
                // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


