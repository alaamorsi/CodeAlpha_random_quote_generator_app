import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_quote_generator/core/services/dio_helper.dart';
import 'package:random_quote_generator/features/view_models/cubit/states.dart';
import 'package:random_quote_generator/features/views/favorite_screen.dart';
import 'package:random_quote_generator/features/views/quote_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  late Box myBox;

  HomeCubit() : super(HomeInitialState()) {
    myBox = Hive.box<List<String>>('myBox');
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const QuoteScreen(),
    const FavoriteScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeAppChangeBottomNavState());
  }

  String quote = '';

  void getNewQuote() {
    emit(HomeGetQuoteLoadingState());
    DioHelper.getData(url: 'random').then((value) {
      quote = value.data[0]['q'];
      emit(HomeGetQuoteSuccessState());
    }).catchError((error) {
      emit(HomeGetQuoteErrorState());
    });
  }

  List<String> favoriteList = [];
  bool isFavorite = false;

  void addToFavorite(String quote) {
    favoriteList.add(quote);
    isFavorite = true;
    saveFavorites();
    emit(HomeAddFavoriteSuccessState());
  }

  void removeToFavorite(String quote) {
    favoriteList.remove(quote);
    isFavorite = false;
    saveFavorites();
    emit(HomeRemoveFavoriteSuccessState());
  }

  void saveFavorites() {
    myBox.put('favorites', favoriteList);
    emit(HomeSaveFavoritesSuccessState());
  }

  void getFavorites() {
    favoriteList = myBox.get('favorites')??[];
    emit(HomeGetFavoritesSuccessState());
  }
}
