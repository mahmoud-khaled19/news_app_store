import 'package:flutter/material.dart';
import 'package:news_app_store/utils/values_manager.dart';

class SuggestionsContainerWidget extends StatefulWidget {
  const SuggestionsContainerWidget({Key? key}) : super(key: key);

  @override
  State<SuggestionsContainerWidget> createState() =>
      _SuggestionsContainerWidgetState();
}

class _SuggestionsContainerWidgetState
    extends State<SuggestionsContainerWidget> {
  final List<String> keyWords = [
    'All News',
    'Trends',
  ];
  int currentSuggestIndex = 0;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: AppSize.s40,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: keyWords.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentSuggestIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              height: size * 0.05,
              width: size * 0.1,
              decoration: BoxDecoration(
                color: currentSuggestIndex == index
                    ? Colors.blue
                    : Theme.of(context).cardColor,
                border: Border.all(color: Theme.of(context).splashColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  keyWords[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
