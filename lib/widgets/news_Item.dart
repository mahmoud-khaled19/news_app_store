import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/widgets/default_custom_text.dart';
import 'package:sizer/sizer.dart';
class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);

  final String image;
  final String title;
  final String description;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor),
      height: AppSize.s100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 80.sp,
              width: AppSize.s100,
              imageUrl: image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).splashColor,
            height: AppSize.s70,
            width: 1,
          ),
          Expanded(
            child: Column(
              children: [
                DefaultCustomText(
                  text: title,
                  maxLines: 1,
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 2.sp,
                ),
                DefaultCustomText(
                  text: description,
                  maxLines: 2,
                  alignment: Alignment.centerLeft,
                ),
                Row(
                  children: [
                    const Icon(Icons.link),
                    const Spacer(),

                    DefaultCustomText(
                      text:date,
                      fontSize: AppSize.s12,
                      maxLines: 1,
                      alignment: Alignment.centerRight,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
