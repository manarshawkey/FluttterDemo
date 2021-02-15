import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'package:app1/WorkManagerFactory.dart';
import 'package:app1/Notifications.dart';
import 'package:app1/DemoUtils.dart';
void setMeUp()async{
}
void main() {
  setMeUp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  /*Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(document['name'],),),
          Container(
            decoration: const BoxDecoration(color: Colors.deepPurple),
            padding: const EdgeInsets.all(10.0),
            child: Text(document['vote'].toString()),
          ),
        ],
      ),
      onTap: (){
        document.reference.update({'votes': document['votes'] + 1});
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A Cool App!"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children:[
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FancyButton(phoneCall, Icon(Icons.call, color: Colors.purple[100],), 'Call Me!'),
              SizedBox(width: 30.0,),
              FancyButton(browse, Icon(Icons.code_sharp, color: Colors.purple[100],), 'Open Flutter docs!'),
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FancyButton(Notifications.notifications.fireAfternoonNotification, Icon(Icons.notifications, color: Colors.purple[100],), 'Notify!'),
                SizedBox(width: 30.0,),
                FancyButton(WorkManagerFactory.workManager.registerPeriodicBackgroundMessages, Icon(Icons.timer, color: Colors.purple[100],), 'Notify in a minute!'),
              ],
            ),
            /*StreamBuilder(
              stream: FirebaseFirestore.instance.collection('names').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
                );
              }
            ),*/
        ],
        ),
      )
      , // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}