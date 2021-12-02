import 'package:flutter/material.dart';

class selectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: AssetImage('assets/Images/Logo.png'),
            height: 150,
            width: 150,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "POLICE STATION FACILATION SYSTEM",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              fontStyle: FontStyle.italic,
              fontSize: MediaQuery.of(context).size.width / 22),
        ),
        SizedBox(
          height: 100,
        ),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 60)),
                backgroundColor: MaterialStateProperty.all(Colors.blue[900])),
            onPressed: () {},
            child: Text("Login as Police Staff")),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red[900])),
            onPressed: () {},
            child: Text("Login as Police Operator"))
      ],
    );
  }
}
