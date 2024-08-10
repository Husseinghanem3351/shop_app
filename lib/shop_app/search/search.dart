import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';
import '../../shop_app_models/search_model.dart';
import '../products/description.dart';


class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);
  final TextEditingController searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopLayoutState>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextBox(
                    onFieldSubmitted:(String value){
                      ShopCubit.get(context).getSearchData(searchController.text);
                    },
                    tBController: searchController,
                    keyType: TextInputType.text,
                    labelText: 'search',
                    preIcon: const Icon(Icons.search),
                    obscure: false,
                    validate: (value){
                      if(value!=null){
                        return 'the field must be not empty';
                      }
                      return null;
                    },
                  ),
                ),
                if(state is ShopSearchLoadingDataState)
                  const LinearProgressIndicator(),
                if(state is ShopSearchSuccessDataState)
                buildSearch(ShopCubit.get(context).searchModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearch(SearchModel? model,context)=>Container(
    color: Colors.grey[300],
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.count(
        childAspectRatio: 1/1.58,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children:List.generate(
          model!.data!.data!.length,
              (index) => buildGridProduct(model.data!.data![index],context),
        ),
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      ),
    ),
  );

   Widget buildGridProduct(Data? model, context){
     return Column(
       children: [
         Container(
           padding: const EdgeInsets.all(5),
           color: CacheHelper.getData(key: 'isDark')? Colors.black:Colors.white,
           height: 170,
           child: Stack(
             alignment: Alignment.bottomLeft,
             children: [
               CachedNetworkImage(
                 imageUrl:model?.image??"",
                 placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                 fit: BoxFit.cover,
                 height: 170,
                 width: double.infinity,
               ),
               if(model!.inCart==false)
                 Container(
                   width: double.infinity,
                   height: 35,
                   color: Colors.grey.withOpacity(.5),
                   child: IconButton(
                     onPressed: (){
                       ShopCubit.get(context).removeOrAddCart(model.id,);
                     },
                     icon: const Icon(
                       Icons.shopping_cart_outlined,
                       color: Colors.white,
                       size: 25,
                     ),
                   ),
                 ),
               if(model.discount!=0)
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

             ],
           ),
         ),
         InkWell(
           onTap: (){
             navigateTo(context, widget: Description(
               description: model.description,
               images: model.images,));
           },
           child: Container(
             padding: const EdgeInsets.all(5),
             color: CacheHelper.getData(key: 'isDark')? Colors.black:Colors.white,
             height: 101,
             width: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 const SizedBox(height: 5,),
                 Text(
                   model.name??"",
                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                     height: 1.5,
                     overflow: TextOverflow.ellipsis,
                   ),
                   maxLines: 2,
                 ),
                 const Spacer(),
                 Row(children: [
                   Text(
                     '${model.price?.round()??''}',
                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                       color: defaultColor,
                     ),
                   ),
                   const SizedBox(
                     width: 10,
                   ),
                   if(model.discount!=0)
                     Text(
                       '${model.oldPrice?.round()??''}',
                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                         color: Colors.grey,
                         decoration: TextDecoration.lineThrough,
                       ),
                     ),
                   const Spacer(),
                   IconButton(

                     onPressed: (){

                       ShopCubit.get(context).postFavorites(model.id);
                     },

                     icon: CircleAvatar(

                       radius: 15,

                       backgroundColor: ShopCubit.get(context).isInFavorites[model.id]==true? defaultColor: Colors.grey,

                       child: const Icon(

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
     );
   }
}
