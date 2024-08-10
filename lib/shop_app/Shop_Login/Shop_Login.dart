import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/shop_app_layout/Shop_Layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../Register/Shop_Register_Screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLogin extends StatelessWidget {
  ShopLogin({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextBox(
                          textInputAction: TextInputAction.next,
                          tBController: emailController,
                          keyType: TextInputType.emailAddress,
                          labelText: 'email',
                          preIcon: const Icon(Icons.email_outlined),
                          obscure: false,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email must be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextBox(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  context,
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                          tBController: passwordController,
                          keyType: TextInputType.visiblePassword,
                          labelText: 'password',
                          preIcon: const Icon(Icons.lock_outline),
                          obscure: !cubit.isPass,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          sufIcon: IconButton(
                            onPressed: () {
                              cubit.changePassIcon();
                            },
                            icon: Icon(cubit.passIcon),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    context,
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              text: 'Login',
                              buttonColor: Colors.black12,
                              textColor: defaultColor,
                            );
                          },
                          condition: isLoading,
                          fallback: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t have an account',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  widget: const RegisterScreen(),
                                );
                              },
                              text: 'Register now',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is ShopLoginLoadingState) {
            isLoading = false;
          } else if (state is! ShopLoginLoadingState) {
            isLoading = true;
          }
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              // showMsg(msg: state.loginModel.message, state: ToastStates.success);
              CacheHelper.putData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                pushAndReplacement(context, widget: const Shop_Layout());
              });
            } else {
              // showMsg(msg: state.loginModel.message, state: ToastStates.error);
            }
          } else if (state is ShopLoginErrorState) {
            // showMsg(msg: state.error, state: ToastStates.error);
          }
        },
      ),
    );
  }
}
