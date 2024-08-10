// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';
import '../../shop_app_models/CartModel.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => Column(
              children: [
                SizedBox(
                  height: 420,
                  child: ListView.separated(
                    itemBuilder: (context, index) => Column(
                      children: [
                        buildCartItem(
                            context,
                            ShopCubit.get(context)
                                .cartModel?.data?.cartItems![index]),
                      ],
                    ),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: ShopCubit.get(context).cartModel?.data?.cartItems?.length??0,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'total:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${ShopCubit.get(context).cartModel?.data?.total??0}',
                        style: const TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                    function: () {},
                    text: 'CheckOut',
                    buttonColor: defaultColor,
                  ),
                ),
              ],
            ),
            condition: ShopCubit.get(context).cartModel != null,
          ),
        );
      },
    );
  }

  Widget buildCartItem(context, CartItems? model) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you want to dismiss this item?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    TextButton(
                      child: const Text('Dismiss'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ));
      },
      key: UniqueKey(),
      onDismissed: (direction) {
        return ShopCubit.get(context).removeOrAddCart(model?.product?.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                CachedNetworkImage(
                  imageUrl: model?.product!.image ?? '',
                  fit: BoxFit.values.last,
                  width: 120,
                  height: 120,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                ),
                if (model?.product!.discount != 0)
                  Container(
                    padding: const EdgeInsets.all(2),
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ]),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        model?.product!.name ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                            ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model?.product!.price}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: defaultColor,
                                      height: 1.3,
                                    ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model?.product!.discount != 0)
                            Text(
                              '${model?.product!.price}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.3,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .postFavorites(model?.product!.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShopCubit.get(context)
                                          .isInFavorites[model?.id] ==
                                      true
                                  ? defaultColor
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
