
import 'package:flutter/material.dart';
import '../../layout/shop_app_layout/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color buttonColor = Colors.blue,
  Color textColor = Colors.white,
  required Function function,
  required String text,
  bool isUpperCase = false,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );

Widget defaultTextBox({
  required TextEditingController tBController,
  required TextInputType keyType,
  Function()? onTap,
  required String labelText,
  required Icon preIcon,
  Widget? sufIcon,
  Function(String value)? onFieldSubmitted,
  required bool obscure,
  InputBorder Bborder = const OutlineInputBorder(),
  required String? Function(String?)? validate,
  bool onlyRead = false,
  InputBorder? enableBorder,
  Function(String value)? onChange,
  TextInputAction? textInputAction,
}) =>
    TextFormField(
      textInputAction: textInputAction,
      controller: tBController,
      keyboardType: keyType,
      onFieldSubmitted: (String value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted(value);
        }
      },
      onChanged: (String value) {
        if (onChange != null) {
          onChange(value);
        }
      },
// onChanged: (value) => print(value),
      validator: validate,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      obscureText: obscure,
      decoration: InputDecoration(
        border: Bborder,
        hintText: labelText,
        prefixIcon: preIcon,
        enabledBorder: enableBorder,
        suffixIcon: sufIcon,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: sufIcon != null ? 16.0 : 12.0),
      ),
      readOnly: onlyRead,
    );



Widget myDivider() => Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );


Future navigateTo(context, {required widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future? pushAndReplacement(context, {required widget}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultTextButton({
  required String text,
  required Function() function,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );

// Future<bool?> Toast({
//   required String message,
//   required Toast? toast,
// }){
//   return Fluttertoast.showToast(
//       msg: message,
//       toastLength: ,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.redAccent,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
// }

//  void showMsg(
// {
//   required String msg,
//   required ToastStates state,

// }) => Fluttertoast.showToast(
// msg: msg,
// toastLength:Toast.LENGTH_LONG,
// gravity: ToastGravity.BOTTOM,
// timeInSecForIosWeb: 5,
// backgroundColor: toastColor(state),
// textColor: Colors.white,
// fontSize: 16.0
// );

// enum ToastStates { error, success, warning, }

// Color toastColor(ToastStates state){
//   if(state  == ToastStates.error){
//     return Colors.red;
//   }
//   else if(state  == ToastStates.warning){
//     return Colors.orangeAccent;
//   }
//   else {
//     return Colors.blue;
//   }
// }

void popTo(context) {
  Navigator.pop(context);
}

bool isInCart(int id, context) {
  if (ShopCubit.get(context).homeModel!.data!.products[id].inCart) {
    return true;
  } else {
    return false;
  }
}
