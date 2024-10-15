
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PrayertimeImage extends StatelessWidget {
  const PrayertimeImage({super.key, required this.image});
 final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child:  CachedNetworkImage(
        errorWidget: (context, url, error) => Center(child: Column(children: [Icon(Icons.error,color: Colors.grey,)],),),
        fit: BoxFit.cover,
        imageUrl: image,
        /* child: Image.network(
          image,
          fit: BoxFit.cover,
        ), */
      ),
    );
  }
}
