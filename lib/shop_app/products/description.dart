import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({Key? key, required this.description,required this.images}) : super(key: key);
  final List<String>? images;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildProductDescription(description: description,images: images,context: context),
    );
  }

  Widget buildProductDescription({required List<String>? images,required String? description,context}){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 150,
            child: ListView.separated(
              itemBuilder: (context, index) {return CachedNetworkImage(
                imageUrl: images![index],
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                placeholder:(context, url) =>  const Center(child: CircularProgressIndicator()),
              );},
              separatorBuilder:(context, index)=> const SizedBox(width: 20,),
              itemCount: images!.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              description!,
              style: Theme.of(context ).textTheme.bodyLarge
              ,
            ),
          ),
        ],
      ),
    );
  }
}
