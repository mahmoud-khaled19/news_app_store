import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:sizer/sizer.dart';
import '../utils/strings_manager.dart';
import '../utils/values_manager.dart';
import '../view_model/app_state.dart';
import 'elevated_button_widget.dart';

class PaginationList extends StatelessWidget {
  const PaginationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return SizedBox(

          height: AppSize.s30,
          child: Row(
            children: [
              DefaultButton(
                text: AppStrings.previous,
                function: () {
                  cubit.previousNewsPage();
                },
                context: context,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                        right: 0.5.h,
                        left: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: cubit.chosenIndex == index
                            ? Colors.blue
                            : Theme.of(context).splashColor,
                      ),
                      child: InkWell(
                        onTap: () {
                            cubit.chosenIndex == index;
                        },
                        child: Text(
                          '${index + 1}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: AppSize.s12),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              DefaultButton(
                text: AppStrings.next,
                function: () {
                   cubit.nextNewsPage();
                },
                context: context,
              ),
            ],
          ),
        );
      },
    );
  }
}
