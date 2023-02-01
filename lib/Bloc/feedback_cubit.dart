import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FeedbackCubitState extends Equatable {}

class FeedbackCubitInit extends FeedbackCubitState {
  @override
  List<Object?> get props => [];
}

class FeedBackCubitChange extends FeedbackCubitState {
  final List<String> latestWords;

  FeedBackCubitChange(this.latestWords);

  @override
  List<Object?> get props => [latestWords];
}

class FeedBackCubitLoad extends FeedbackCubitState {
  @override
  List<Object?> get props => [];
}

class FeedBackCubit extends Cubit<FeedbackCubitState> {
  FeedBackCubit() : super(FeedbackCubitInit());

  final List<String> words = [];

  void addNewWord(String word) {
    emit(FeedBackCubitLoad());
    words.add(word);
    emit(FeedBackCubitChange(words));
  }

  void clearWords() {
    emit(FeedBackCubitLoad());
    words.clear();
    emit(FeedBackCubitChange(words));
  }
}