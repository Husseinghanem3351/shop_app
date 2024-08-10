import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shop_app/Cart/Cart.dart';
import '../../shop_app/search/search.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class Shop_Layout extends StatelessWidget {
   const Shop_Layout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopLayoutState>(
      builder: (BuildContext context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateTo(context, widget: const Cart());
            },
            child: const Icon(Icons.shopping_cart),
          ),
        appBar:AppBar(
          title: const Text('salla'),
          actions: [
            IconButton(
                onPressed: (){
                  navigateTo(context, widget:  Search());
                },
                icon: const Icon (Icons.search)),
          ],
        ) ,
        bottomNavigationBar: BottomNavigationBar(
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),

          ] ,
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNav(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
         body: cubit.bottomList[cubit.currentIndex],
      ); },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
