import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_quote_generator/core/constant/colors.dart';
import 'package:random_quote_generator/features/view_models/cubit/cubit.dart';
import 'package:random_quote_generator/features/view_models/cubit/states.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(10.0.sp),
          child: Column(
            children: [
              Expanded(
                child: HomeCubit.get(context).favoriteList.isEmpty
                    ? Center(
                        child: Text(
                        'No Favorites yet!',
                        style: TextStyle(
                            fontSize: 21.0.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ))
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Card(
                              elevation: 5.0.sp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0.sp),
                                side: BorderSide(
                                    width: 2.0.sp, color: Colors.white),
                              ),
                              color: mainColor.withOpacity(0.7),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0.sp,
                                  right: 10.0.sp,
                                  top: 10.0.sp,
                                  bottom: 35.0.sp,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      HomeCubit.get(context)
                                          .favoriteList[index],
                                      style: TextStyle(
                                        fontSize: 21.0.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                        HomeCubit.get(context).quote);
                                  },
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: Colors.white,
                                    size: 30.0.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).removeToFavorite(
                                        HomeCubit.get(context)
                                            .favoriteList[index]);
                                  },
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red,
                                    size: 30.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.0.sp,
                        ),
                        itemCount: HomeCubit.get(context).favoriteList.length,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
