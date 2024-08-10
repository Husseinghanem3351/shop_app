
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shop_app_models/categories_model.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopLayoutState>(
      builder: (context, state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
            itemBuilder:(context, index) => catBuilder(cubit.categoriesModel!.data.data[index],context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: cubit.categoriesModel?.data.data.length??0,
          ),
          condition: ShopCubit.get(context).categoriesModel!=null,
          fallback: (Context)=> const Center(child: CircularProgressIndicator(),),
        );
      },
      listener: (context,state){},
    );
  }

  Widget catBuilder(DataModel model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: model.image??'',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          placeholder: (context,url)=>const Center(child: CircularProgressIndicator()),
        ),
        const SizedBox(width: 20 ,),
        Text(
          model?.name??'',
          style:Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
