import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/products/widgets/products_builder.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';


class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopLayoutState>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              ProductsBuilder(homeModel:  cubit.homeModel,categoriesModel:  cubit.categoriesModel),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
        if (state is ChangeIsFavoriteErrorState) {
          // showMsg(msg: state.model.message, state: ToastStates.error);
        } else if (state is ChangeIsFavoriteSuccessState &&
            !state.model.status) {
          // showMsg(msg: state.model.message, state: ToastStates.warning);
        }
      },
    );
  }







}
