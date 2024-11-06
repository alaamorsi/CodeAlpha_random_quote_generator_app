import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_quote_generator/core/constant/colors.dart';
import 'package:random_quote_generator/core/shared_widgets/shared_button.dart';
import 'package:random_quote_generator/features/view_models/cubit/cubit.dart';
import 'package:random_quote_generator/features/view_models/cubit/states.dart';
import 'package:share_plus/share_plus.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(
              left: 10.0.sp, right: 10.0.sp, bottom: 10.0.sp, top: 50.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 1.sw,
                    ),
                    child: Card(
                      elevation: 5.0.sp,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0.sp),
                          side: BorderSide(width: 2.0.sp, color: Colors.white)),
                      borderOnForeground: true,
                      color: mainColor.withOpacity(0.7),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.0.sp,
                            right: 10.0.sp,
                            top: 10.0.sp,
                            bottom: 35.0.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeCubit.get(context).quote,
                              style: TextStyle(
                                  fontSize: 21.0.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (HomeCubit.get(context).isFavorite) {
                          HomeCubit.get(context)
                              .removeToFavorite(HomeCubit.get(context).quote);
                        } else {
                          HomeCubit.get(context)
                              .addToFavorite(HomeCubit.get(context).quote);
                        }
                      },
                      icon: Icon(
                        HomeCubit.get(context).isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: HomeCubit.get(context).isFavorite
                            ? Colors.red
                            : Colors.white,
                        size: 30.0.sp,
                      ))
                ],
              ),
              SizedBox(
                height: 50.0.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SharedButton(
                    color: Colors.green,
                    text: 'New Quote',
                    onPressed: () {
                      HomeCubit.get(context).getNewQuote();
                      HomeCubit.get(context).isFavorite = false;
                    },
                  ),
                  const Spacer(),
                  SharedButton(
                    color: Colors.blue,
                    text: 'Share',
                    icon: Icons.share_outlined,
                    onPressed: () async {
                      await Share.share(HomeCubit.get(context).quote);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
