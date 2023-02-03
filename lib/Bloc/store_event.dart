import 'package:equatable/equatable.dart';

abstract class StoreBlocEvent{
  const StoreBlocEvent([List props = const []]) : super();
}

class AddNewWord extends StoreBlocEvent {

  final String newWord;

  const AddNewWord(this.newWord);
}