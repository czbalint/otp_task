import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp/Bloc/feedback_cubit.dart';
import 'package:otp/Bloc/store_bloc.dart';
import 'package:otp/Bloc/store_event.dart';
import 'package:otp/Bloc/store_state.dart';

void main() {

  group('Store bloc tests', () {
    blocTest<StoreBloc, StoreBlocState>(
        'Store bloc init in zero pont and empty list',
        build: () => StoreBloc(FeedBackCubit()),
        expect: () => [],
        verify: (bloc) {
          expect(bloc.point, 0);
          expect(bloc.words.isEmpty, true);
        }
    );

    blocTest<StoreBloc, StoreBlocState>(
      'Store bloc add new word to list',
      build: () => StoreBloc(FeedBackCubit()),
      act: (bloc) => bloc.add(const AddNewWord('test')),
      expect: () => [StoreBlocLoading(), const StoreBlocRefreshWords(['test'], 4, 'test')],
    );

    blocTest<StoreBloc, StoreBlocState>(
        'Word exsist in store',
        build: () => StoreBloc(FeedBackCubit()),
        act: (bloc) => bloc.add(const AddNewWord('test')),
        verify: (bloc) {
          expect(bloc.wordExsist('test'), true);
        }
    );

    blocTest<StoreBloc, StoreBlocState>(
        'StoreBloc init state',
        build: () => StoreBloc(FeedBackCubit()),
        verify: (bloc) {
          expect(bloc.state, StoreBlocUninitialized());
        }
    );
  });

  group('FeedBack cubit tests', () {
    blocTest<FeedBackCubit, FeedbackCubitState>(
        'Feedback cubit init',
        build: () => FeedBackCubit(),
        verify: (cubit) {
          expect(cubit.state, FeedbackCubitInit());
        }
    );

    blocTest<FeedBackCubit, FeedbackCubitState>(
        'Feedback cubit test',
        build: () => FeedBackCubit(),
        act: (cubit) => cubit.addNewWord('test'),
        expect: () => [FeedBackCubitLoad(), FeedBackCubitChange(const ['test'])]
    );

    blocTest<FeedBackCubit, FeedbackCubitState>(
        'Feedback cubit clear words',
        build: () => FeedBackCubit(),
        act: (cubit) {
          cubit.addNewWord('test');
          expect(cubit.words, ['test']);
          cubit.clearWords();
        },
        verify: (cubit) {
          expect(cubit.words, []);
        }
    );
  });

}
