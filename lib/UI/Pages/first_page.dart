import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(

                controller: inputController,
                decoration: InputDecoration(
                  labelText: "Enter a word",
                  border: UnderlineInputBorder()
                ),
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Check word")
              ),
            )
          ],
        )
      ),
    );
  }
}
