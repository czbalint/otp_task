import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp/Bloc/store_bloc.dart';
import 'package:otp/Bloc/store_state.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int score = 0;

  List<String> words = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: SizedBox(
        width: screenSize.width,
        child: BlocBuilder<StoreBloc, StoreBlocState>(
          builder: (context, state) {
            if (state is StoreBlocRefreshWords){
              score = state.point;
              words = state.words;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 40),
                  alignment: Alignment.center,
                  height: 70,
                  width: screenSize.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor.withOpacity(.3)
                  ),
                  child: Text(
                    score.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: words.map((word) =>
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(word,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child: Text(word.length.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                    ),
                      )).toList(),
                  )
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
