import 'package:flutter/material.dart';
import 'package:w25_test_flutter/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ABCDE'),
      routes: {
        '/second': (context) => const SecondPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double _counter = 0;

  var isChecked = false;

  // void _incrementCounter() {
  //   setState(() {
      
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: const Drawer(child: Text("Hi There"),),
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
        actions: [
          OutlinedButton(onPressed: (){}, child: const Text("Button 1")),
          const SizedBox(width: 10.0),
          OutlinedButton(onPressed: (){
            Navigator.pushNamed(context, '/second');
          }, child: const Text("Second Page"))
        ],
        
      ),
      body: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Icon(Icons.call),
                  Text(
                    "Call".toUpperCase(),
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.send,
                    color: Colors.teal,
                  ),
                  Text(
                    "Route".toUpperCase(),
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.share,
                    color: Colors.teal,
                  ),
                  Text("Share".toUpperCase(),
                      style: const TextStyle(color: Colors.red))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image.asset("images/ac_logo.jpg", width: 400),
              const Text(
                "Algonquin College",
                style: TextStyle(fontSize: 30.0, backgroundColor: Colors.white),
              )
            ],
          )
        ]),
      ),
      bottomNavigationBar:  BottomNavigationBar(items: const  [
        BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Camera"),
        BottomNavigationBarItem(icon: Icon(Icons.add_call), label: 'Phone'),
      ], onTap: (btnIndex){
        if(btnIndex == 0) {
          // print("Camera button pressed");
        } else {
          // print("Phone button pressed");
        }
      },), 
    );
  }
}
