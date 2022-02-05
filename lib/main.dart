import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class CounterState extends ChangeNotifier{
  int _counter = 0;
  int get counter => _counter;
  set counter(int newCounterValue){
    _counter = newCounterValue;
    notifyListeners();
  }

  addValueToCounter(){
    counter += 1;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterState>(
      create: (_) => CounterState(),
      builder: (childContext,child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Column(
          children: [
            Expanded(child: MyHomePage()),
            ElevatedButton(onPressed: () => Provider.of<CounterState>(childContext,listen: false).addValueToCounter(), child: const Text('Update State From App Widget'))
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    debugPrint("=== UI is re-rendered ====");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterState>(
              builder: (childContext,counterState,child) => Text(
                '${counterState.counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InfoPage()));
            }, child: const Text("Goto Info Page"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<CounterState>(context,listen: false).addValueToCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InfoPage extends StatelessWidget {


  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Info Page")
      ),
      body: Center(
        child: Text("Counter Value is : ${ Provider.of<CounterState>(context,listen: false).counter}"),
      ),
    );
  }
}

