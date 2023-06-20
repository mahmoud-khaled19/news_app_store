import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/widgets/default_custom_text.dart';
import 'package:shimmer/shimmer.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    Key? key,
    required this.author,
    required this.image,
    required this.title,
    required this.url,
    required this.content,
  }) : super(key: key);
  final String author;
  final String image;
  final String url;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                        imageUrl: image,
                        height: AppSize.s100,
                        width: double.infinity,
                        placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[500]!,
                              child: Container(
                                height: AppSize.s100,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error)),
                  ],
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                DefaultCustomText(
                  text: 'Title',
                  alignment: Alignment.centerLeft,
                  fontSize: AppSize.s18,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                DefaultCustomText(
                  maxLines: 3,
                  text: title,
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                DefaultCustomText(
                  text: 'Description',
                  alignment: Alignment.centerLeft,
                  fontSize: AppSize.s18,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                DefaultCustomText(
                  maxLines: 100,
                  text: content,
                  alignment: Alignment.centerLeft,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
