import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiment'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //CabinetRepository(context).add(CabinetModel(name: "Special Cab"));
          //UserRepository(context).add(UserModel())
        },
        label: const Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: null, //CabinetRepository(context).getStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            } else {
              return Container(
                child: ElevatedButton(
                  child: Text("Add user"),
                  onPressed: () {
                    //UserRepository(context)
                    //.add(UserModel(cabinets: ["abc", "def"]));
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
