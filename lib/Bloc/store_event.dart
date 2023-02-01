import 'package:equatable/equatable.dart';

abstract class StoreBlocEvent extends Equatable {
  const StoreBlocEvent([List props = const []]) : super();
}

class AddNewWord extends StoreBlocEvent {

  final String newWord;

  const AddNewWord(this.newWord);

  @override
  List<Object?> get props => [newWord];
}