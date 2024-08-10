
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/setting/update_profile.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';


class SettingScreen extends StatelessWidget {
   const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopLayoutState>(
      builder: (context,state) {

        return Scaffold(

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: (){
                      navigateTo(context, widget: Profile());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children:  [
                            Text(
                              'Profile',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children:  [
                          Text(
                            'Dark Mode',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          IconButton(
                            icon:  const Icon(
                              Icons.brightness_4_outlined,
                            ),
                            onPressed: (){
                              ShopCubit.get(context).changeDarkMode();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 30,),
                  defaultButton(
                    function: () {
                      ShopCubit.get(context).signOut(context);
                    },
                    text: 'LogOut',
                    buttonColor: defaultColor,

                  ),
                ],
              ),
            )
          );
          },
      listener: (context,state){},
    );
  }

}
