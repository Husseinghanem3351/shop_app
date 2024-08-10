import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';
import '../../shop_app_models/Favorites_model.dart';
import '../products/description.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopLayoutState>(
      builder: (BuildContext context, state) {
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
            itemBuilder: (context,index)=>buildFavoritesProducts(cubit.getFavoritesModel!.data?.data![index].product,context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: cubit.getFavoritesModel!.data?.data?.length??0,
            physics:const BouncingScrollPhysics(),
          ),
          fallback: (context)=>const Center(child:  CircularProgressIndicator()),
          condition: ShopCubit.get(context).getFavoritesModel!=null&&ShopCubit.get(context).homeModel!=null,
        );
        },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}

Widget buildFavoritesProducts(Product? model,context)=>InkWell(
  onTap: (){
    navigateTo(context, widget: Description(description: model!.description,images: [model.image],));
    },
  child:   Padding(

    padding: const EdgeInsets.symmetric(horizontal: 10.0),

    child:   Container(

      padding: const EdgeInsets.all(8),

      child:   Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Stack(

              alignment: Alignment.bottomLeft,

              children: [

                CachedNetworkImage(

                  imageUrl: model?.image??'',

                  fit: BoxFit.values.last,

                  width: 120,

                  height: 120,

                  placeholder: (context,url)=>const Center(child: CircularProgressIndicator()),

                ),

                if(model?.discount!=0)

                Container(

                  padding: const EdgeInsets.all(2),

                  color: Colors.red,

                  child: const Text(

                    'Discount',

                    style: TextStyle(

                        color: Colors.white,

                        fontSize: 10

                    ),

                  ),

                ),

              ]







          ),

          const SizedBox(width: 20,),

          Expanded(

            child: SizedBox(

              height: 120,

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Text(

                    model?.name??'',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style:Theme.of(context).textTheme.bodyLarge?.copyWith(

                      height: 1.5,

                    ),

                  ),

                  const Spacer(),

                  Row(children: [

                    Text(

                      '${model?.price?.round()}',

                      style: Theme.of(context).textTheme.bodySmall!.copyWith(

                        color: defaultColor,
                      ),

                      overflow: TextOverflow.ellipsis,

                      maxLines: 3,



                    ),



                    const SizedBox(width: 5,),



                    if(model!.discount!=0)

                    Text(

                      '${model.oldPrice?.round()}',

                      style: const TextStyle(

                          fontSize: 14,


                          color: Colors.grey,

                          decoration: TextDecoration.lineThrough



                      ),



                    ),

                    const Spacer(),


                    if(ShopCubit.get(context).isInCart[model.id]==false)
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).removeOrAddCart(model.id,);
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),


                    IconButton(



                      onPressed: (){



                        ShopCubit.get(context).favoritesOnPressed(model);

                      },



                      icon:const CircleAvatar(



                        radius: 15,



                        backgroundColor: defaultColor,



                        child: Icon(



                          Icons.favorite_border,



                          size: 20,



                          color: Colors.white,



                        ),



                      ),



                    ),



                  ],),







                ],







              ),







            ),







          ),







        ],







      ),



    ),

  ),
);