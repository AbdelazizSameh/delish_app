import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

part 'general_popular_items_state.dart';

class PopularItemsCubit extends Cubit<GenaralPopularItemsState> {
  PopularItemsCubit() : super(GenaralPopularItemsInitialState());

  StreamSubscription? _subscription;

  void fetchPopularItems() {
    emit(GenaralPopularItemsLoadingState());
    log("Fetching popular items...");

    try {
      _subscription = FirestoreGetters().getPopularItems().listen(
        (snapshot) {
          final items = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          log("Loaded ${items.length} popular items");

          emit(GenaralPopularItemsLoadedState());
        },
        onError: (e) {
          log("Error: $e");
          emit(GenaralPopularItemsFailureState(message: e.toString()));
        },
      );
    } catch (e) {
      emit(GenaralPopularItemsFailureState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
