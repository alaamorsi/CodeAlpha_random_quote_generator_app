import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_quote_generator/core/constant/colors.dart';
import 'package:random_quote_generator/features/view_models/cubit/cubit.dart';
import 'package:random_quote_generator/features/view_models/cubit/states.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('Random Quote Generator',style: TextStyle(fontSize: 24.0.sp,fontWeight: FontWeight.bold,color: Colors.white),),
            centerTitle: true,
            backgroundColor: mainColor,
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            bottom: PreferredSize(preferredSize: Size(10.0.w, 10.0.h), child: Container(decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 2.0,color: Colors.black))),)),
          ),
          body: HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: Container(
            decoration:  const BoxDecoration(
                border: BorderDirectional(
                    top: BorderSide(
                        width: 1.0, color: Colors.black))),
            child: SalomonBottomBar(
              backgroundColor: mainColor,
              currentIndex: HomeCubit.get(context).currentIndex,
              onTap: (index) => HomeCubit.get(context).changeBottomNav(index),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  selectedColor: Colors.black,
                ),
                SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  title: const Text(
                    "Favorite",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  selectedColor: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
