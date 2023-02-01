import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp/Bloc/feedback_cubit.dart';
import 'package:otp/Bloc/store_event.dart';
import 'package:otp/Bloc/store_state.dart';

class StoreBloc extends Bloc<StoreBlocEvent, StoreBlocState> {

  final List<String> words = [];
  final FeedBackCubit feedBackCubit;
  int point = 0;

  StoreBloc(this.feedBackCubit) : super(StoreBlocUninitialized()) {
    on<AddNewWord>((event, emit) {
      emit(StoreBlocLoading());
      feedBackCubit.addNewWord(event.newWord);
      words.add(event.newWord);
      point += event.newWord.length;
      emit(StoreBlocRefreshWords(words, point, event.newWord));
    });
  }

  bool wordExsist(String word) {
    return words.contains(word);
  }
}
