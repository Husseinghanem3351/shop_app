import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../layout/shop_app_layout/Shop_Layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    bool isLoading = false;
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        builder: (BuildContext context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextBox(
                        textInputAction: TextInputAction.next,
                        tBController: nameController,
                        keyType: TextInputType.name,
                        labelText: 'name',
                        preIcon: const Icon(Icons.person),
                        obscure: false,

                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextBox(
                        textInputAction: TextInputAction.next,
                        tBController: phoneController,
                        keyType: TextInputType.phone,
                        labelText: 'phone',
                        preIcon: const Icon(Icons.phone),
                        obscure: false,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                            return 'please enter your email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextBox(
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(context,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                email: emailController.text);
                          }
                        },
                        tBController: passwordController,
                        keyType: TextInputType.visiblePassword,
                        labelText: 'password',
                        preIcon: const Icon(Icons.lock_outline),
                        obscure: !cubit.isPass,
                        validate: (value) {
                          if (value!.isEmpty || value.length < 6) {
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
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(context,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  email: emailController.text);
                            }
                          },
                          text: 'Register',
                          buttonColor: Colors.black12,
                          textColor: defaultColor,
                        ),
                        condition: !isLoading,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is ShopRegisterLoadingState) {
            isLoading = true;
          } else if (state is! ShopRegisterLoadingState) {
            isLoading = false;
          }
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              // showMsg(msg: state.registerModel.message, state: ToastStates.success);
              CacheHelper.putData(
                      key: 'token', value: state.registerModel.data?.token)
                  .then((value) {
                pushAndReplacement(context, widget: Shop_Layout());
              });
            } else {
              // showMsg(msg: state.registerModel.message, state: ToastStates.error);
            }
          } else if (state is ShopRegisterErrorState) {
            // showMsg(msg: state.error, state: ToastStates.error);
          }
        },
      ),
    );
  }
}
