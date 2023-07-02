import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/assets_manager.dart';
import 'package:news_app_store/view/empty_screen.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/widgets/news_Item.dart';
import '../view_model/app_state.dart';

class BookMarksScreen extends StatelessWidget {
  const BookMarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Marks Screen'),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          return StreamBuilder<QuerySnapshot>(
            stream: cubit.bookMarks.snapshots(includeMetadataChanges: true),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot.connectionState == ConnectionState.active) {
                if (snapShot.hasData || snapShot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var data = snapShot.data!.docs[index];
                      return NewsItem(
                        bookMarkIcon: data['bookMarked'] == true
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined,
                        image: data['image'],
                        title: data['title'],
                        description: data['description'],
                        date: data['date'],
                        url: data['url'],
                        function: () {
                          cubit.bookMarks
                              .doc(data['id'])
                              .update({'bookMarked': false});
                          cubit.bookMarks.doc(data['id']).delete();

                        },
                      );
                    },
                    itemCount: snapShot.data!.docs.length,
                  );
                }
              } else {
                return const EmptyScreen(
                    text: 'No BookMarks yet !',
                    image: ImagesManager.emptyScreenImage);
              }
              return const EmptyScreen(
                  text: 'Oops !! Error Happened Restart The App',
                  image: ImagesManager.emptyScreenImage);
            },
          );
        },
      ),
    );
  }
}
