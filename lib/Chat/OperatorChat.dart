import 'package:flutter/material.dart';
import 'package:policesfs/drawner/chat/Operatormessage.dart';
import 'package:policesfs/drawner/chat/Operatornew.dart';
import 'package:policesfs/drawner/chat/new_message.dart';

class OperatorChat extends StatelessWidget {
  static final routeName = 'OperatorChat';
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments as Map;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(
            'OperatorChat',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: OperatorMessages(id),
                ),
                Operatornew(id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
