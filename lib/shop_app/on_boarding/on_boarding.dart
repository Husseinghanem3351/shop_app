import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Shop_Login/Shop_Login.dart';

class BoardingModel{
  late final String titles;
  late final Image images;
  late final String body;

  BoardingModel({required this.body, required this.images, required this.titles});
}
class OnBoarding extends StatefulWidget {

   const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController=PageController();

List<BoardingModel> boardingItems=[
  BoardingModel(
    body:'onBoard1 body',
    images:const Image(
        image: AssetImage('assets/images/online.png'),
        fit: BoxFit.cover,
    ),
    titles: 'onBoard1 title',),
  BoardingModel(
    body:'onBoard2 body' ,
    images:const Image(
      image: AssetImage('assets/images/success.png'),
      fit: BoxFit.cover,
    ),
    titles: 'onBoard2 title',),
  BoardingModel(
    body:'onBoard3 body' ,
    images:const Image(
      image: AssetImage('assets/images/cart.png'),
      fit: BoxFit.cover,
    ),
    titles: 'onBoard3 title',),
];
bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
          text: 'skip',
          function: () {
            submit();
          }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boardingItems.length-1){
                    setState(() {
                    isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index)=>buildOnBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingItems.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor:defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing:5,
                    expansionFactor: 2.5
                  ),
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if(!isLast){
                    boardController.nextPage(
                        duration: const Duration(
                            milliseconds: 750
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                  else  {
                    submit();
                  }

                },
                  child: const Icon(Icons.arrow_forward_ios)  ,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel boardingModelItem)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: boardingModelItem.images),
      const SizedBox(height: 30,),
      Text(
        boardingModelItem.titles,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 15,),
      Text(
        boardingModelItem.body,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 30,),
    ],
  );
  void submit(){
    CacheHelper.putData(key: 'isOnBoarding', value: false,).then((value) {
      if(value){
        pushAndReplacement(context,widget: ShopLogin());
      }
    });
  }
}
