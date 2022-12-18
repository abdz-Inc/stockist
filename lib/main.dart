import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChartView extends StatelessWidget {
  late String stockName;
  ChartView({required this.stockName});
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=NSE%3A" +
          stockName.toLowerCase(),
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("${stockName}"),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  int _counter = 0;
  List<String> stocknames = ["IRFC", "YESBANK", "BANKNIFTY", "IOB", "INDBANK"];

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: const Text('Add Stock')),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 300,
            height: 100,
            child: TextField(
              controller: myController,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            setState(() {
              stocknames.add(myController.text.toUpperCase());
            });
            Navigator.of(context).pop();
          },
          //textColor: Theme.of(context).primaryColor,
          child: const Text('Done'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(50, 100, 0, 0),
                  constraints: BoxConstraints.expand(),
                  child: Text(
                    "STOCKist",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(200, 50),
                        bottomRight: Radius.elliptical(1, 1)),
                    color: Colors.blue.shade600,
                  )),
              flex: 17,
            ),
            Expanded(
                flex: 3,
                child: ListTile(
                  trailing: Icon(
                    Icons.menu_open_outlined,
                    color: Colors.blue.shade600,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                  // padding: EdgeInsets.only(left: 30, top: 50),
                  // constraints: BoxConstraints.expand(),
                  title: Text(
                    "Watchlist",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.blue.shade600, fontSize: 22),
                  ),
                )),
            Expanded(
                flex: 30,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ListView.separated(
                    itemCount: stocknames.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ChartView(stockName: stocknames[index])));
                      },
                      tileColor: Colors.white,
                      minVerticalPadding: 5,
                      contentPadding:
                          EdgeInsets.only(top: 10, left: 20, right: 10),
                      leading: Text(
                        "stock",
                        style: TextStyle(fontSize: 8),
                      ),
                      title: Text(stocknames[index]),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      height: 5,
                    ),
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildPopupDialog(context);
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
