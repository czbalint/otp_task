import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp/Bloc/feedback_cubit.dart';
import 'package:otp/Bloc/store_bloc.dart';
import 'package:otp/Bloc/store_event.dart';
import 'package:otp/Bloc/store_state.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _inputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: _inputController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                ],
                decoration: const InputDecoration(
                  labelText: "Enter a word",
                  border: UnderlineInputBorder()
                ),
                style: const TextStyle(
                  fontSize: 20
                ),
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
                validator: (value) {
                  if (value == null) return "Something error!";
                  if (value.isEmpty) return "Empty input! Please write something";
                  if (value.isNotEmpty && value.length > "pneumonoultramicroscopicsilicovolcanoconiosis".length) return "The given word is too long!";
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final bloc = context.read<StoreBloc>();
                  final newWord = _inputController.value.text;
                  if (bloc.wordExsist(newWord)){
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("This word is already exsist!")
                          )
                      );
                    });
                    context.read<FeedBackCubit>().addNewWord("$newWord (wrong)");
                    return;
                  }
                  bloc.add(AddNewWord(_inputController.value.text));
                  _inputController.clear();
                }
              },
              child: const Text("Submit")
            ),
            BlocBuilder<FeedBackCubit, FeedbackCubitState>(
                  builder: (context, state) {
                    if (state is FeedBackCubitChange) {
                      return Flexible(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: state.latestWords.reversed.toList().asMap().entries.map((e) {
                              int idx  = e.key;
                              String value = e.value;
                              if (idx == 0) {
                                return TextSpan(text: "$value\n", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                              }
                              return TextSpan(text: "$value\n");
                            }).toList()
                          )
                        ),
                      );
                    }
                    return Container();
                  }
              )
          ],
        ),
      ),
    );
  }
}
