
import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/products/description.dart';
import 'package:shop_app/shop_app_models/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../layout/shop_app_layout/cubit/cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key,required this.productModel, required this.height, required this.width});

  final double height;
  final double width;

  final ProductsModel? productModel;

  @override
  Widget build(BuildContext context) {
    double productHeight=(width/2)*1.5-20;
    bool isDark =CacheHelper.getData(key: 'isDark')??false;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: productHeight-100,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: productModel?.image??'',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.cover,
                  height: productHeight-120,
                  width: double.infinity,
                ),
                if (productModel?.inCart == false)
                  Container(
                    width: double.infinity,
                    height: 35,
                    color: Colors.grey.withOpacity(.5),
                    child: IconButton(
                      onPressed: () {
                        ShopCubit.get(context).removeOrAddCart(
                          productModel?.id,
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                if (productModel?.discount != 0)
                  Container(
                    padding: const EdgeInsets.all(2),
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            color: isDark
                ? Colors.black
                : Colors.white,
            height: 100,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                navigateTo(
                  context,
                  widget: Description(
                      description: productModel?.description, images: productModel?.images),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    productModel?.name??'',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      height: 1.2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Row(children: [
                    Text(
                      '${productModel?.price.round()}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (productModel?.discount != 0)
                      Text(
                        '${productModel?.oldPrice.round()}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).postFavorites(productModel?.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                        ShopCubit.get(context).isInFavorites[productModel?.id] ==
                            true
                            ? defaultColor
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


