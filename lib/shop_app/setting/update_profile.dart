import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';
import '../../layout/shop_app_layout/cubit/states.dart';

class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);
  final TextEditingController emailController=TextEditingController();
   final TextEditingController phoneController=TextEditingController();
   final TextEditingController nameController=TextEditingController();
   final TextEditingController passwordController=TextEditingController();
   final GlobalKey<FormState> formKey=GlobalKey<FormState>();
   bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopCubit()..getProfile(),
      child: BlocConsumer<ShopCubit,ShopLayoutState>(
        builder: (context,state)
        {
          emailController.text=ShopCubit.get(context).profileModel?.data!.email??'';
          phoneController.text=ShopCubit.get(context).profileModel?.data?.phone??'';
          nameController.text=ShopCubit.get(context).profileModel?.data?.name??'';

          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              fallback: (context)=> const Center(child: CircularProgressIndicator(),),
              builder: (context) => Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if(isLoading)
                          const LinearProgressIndicator(),
                        defaultTextBox(
                          tBController: nameController,
                          keyType: TextInputType.name,
                          labelText: 'name',
                          preIcon: const Icon(Icons.person),
                          obscure: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name must be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextBox(
                          tBController: emailController,
                          keyType: TextInputType.emailAddress,
                          labelText: 'email',
                          preIcon: const Icon(Icons.email),
                          obscure: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email must be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextBox(
                          tBController: phoneController,
                          keyType: TextInputType.phone,
                          labelText: 'phone',
                          preIcon: const Icon(Icons.phone),
                          obscure: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'phone must be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextBox(
                          tBController: passwordController,
                          keyType: TextInputType.visiblePassword,
                          labelText: 'new password',
                          preIcon: const Icon(Icons.lock),
                          obscure: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'new password must be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateProfile(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'update profile',
                          buttonColor: defaultColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              condition: ShopCubit.get(context).profileModel!=null,
            ),
          );
        },
        listener: (context, state){
          if(state is UpdateProfileLoading) {
             isLoading=true;
          }
          else {isLoading=false;}

        },
      ),
    );
  }
}
