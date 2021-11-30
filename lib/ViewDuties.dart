import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PoliceSFSDutiesProvider.dart';

class ViewDuties extends StatefulWidget {
  static final routeName = 'ViewDuties';

  @override
  _ViewDutiesState createState() => _ViewDutiesState();
}

class _ViewDutiesState extends State<ViewDuties> {
  final postId = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            'Your Duties',
            textAlign: TextAlign.center,
          ),
        ),
        body:
            // FutureBuilder(
            //     future: Provider.of<Feedbacks>(context, listen: false)
            //         .fetchAndSetProducts(
            //             true, Provider.of<Auth>(context, listen: false).userid),
            //     builder: (context, snapshot) {
            //       return Consumer<Feedbacks>(
            //           builder: (ctx, feedbackData, child) => feedbackData
            //                       .feedback.length >
            //                   0
            //               ?
            GridView.builder(
                itemCount: postId.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Duty ID",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "D1",
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Title",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Raid on Emaan Center",
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Raid',
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Johar town',
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Priority",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'High',
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text('View Details')),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  // MediaQuery.of(context).size.width /
                  // (MediaQuery.of(context).size.height / 1.4)
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                )));
  }
}
