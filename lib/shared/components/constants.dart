//GET
//DELETE
//UPDATE
//POST


//GET
// base url:https://newsapi.org/
// method (url) : v2/top-headlines? (THIS BATH INSIDE THE SERVER).
// queries : country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca (THIS OPTIONAL).
//https://newsapi.org/v2/everything?q==tesla&apiKey=00ca5eafa93a44c5b4c4b6b8594d12ee
//create

import '../../shop_app/Shop_Login/Shop_Login.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData('token').then((value) {
// print(value);
// print(CacheHelper.getData(key: 'token'));
    if (value) {
      pushAndReplacement(context, widget: ShopLogin());
    }
  });
}

String? token= CacheHelper.getData(key: 'token');