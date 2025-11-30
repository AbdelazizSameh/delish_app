import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_index_state.dart';

class CarouselIndexCubit extends Cubit<int> {
  CarouselIndexCubit() : super(0);

  int carouselItems = 4;
  int indexCarousel = 0;

  void changeIndex(int index) {
    indexCarousel = index;
    emit(index);
  }
}
