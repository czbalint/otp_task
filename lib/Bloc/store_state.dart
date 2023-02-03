import 'package:equatable/equatable.dart';

abstract class StoreBlocState extends Equatable {
  const StoreBlocState([List props = const []]) : super();
}

class StoreBlocUninitialized extends StoreBlocState {
  @override
  List<Object?> get props => [];
}

class StoreBlocRefreshWords extends StoreBlocState {
  final List<String> words;
  final int point;
  final String newWord;

  const StoreBlocRefreshWords(this.words, this.point, this.newWord);

  @override
  List<Object?> get props => [words, point, newWord];
}

class StoreBlocLoading extends StoreBlocState {
  @override
  List<Object?> get props => [];
}
