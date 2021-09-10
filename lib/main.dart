import 'package:flutter/material.dart';

void main() {
  runApp(QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuotApp',
      home: StatefulHomePage(),
    );
  }
}

class Quote {
  final String imageUrl;
  final String text;
  final String detail;
  Quote(this.imageUrl, this.text, this.detail);
}

class StatefulHomePage extends StatefulWidget {
  const StatefulHomePage({Key? key}) : super(key: key);
  @override
  _StatefulHomePageState createState() => _StatefulHomePageState();
}

class _StatefulHomePageState extends State<StatefulHomePage> {
  final _formkey = GlobalKey<FormState>();

  String? _inputimageUrl;
  String? _inputtext;
  String? _inputdetail;

  List<Quote>? qoutes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'จดรายการอาหาร',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'imageUrl',
                          helperText: 'รูปภาพ'),
                      onSaved: (String? value) {
                        _inputimageUrl = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'text',
                          helperText: 'ชื่อ'),
                      onSaved: (String? value) {
                        _inputtext = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'detail',
                        helperText: 'ราคา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (String? value) {
                        _inputdetail = value;
                      },
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: () {
                        _formkey.currentState?.save();
                        print(_inputimageUrl);
                        print(_inputtext);
                        print(_inputdetail);
                        setState(() {
                          qoutes?.insert(
                            0,
                            Quote(_inputimageUrl!, _inputtext!, _inputdetail!),
                          );
                        });
                        _formkey.currentState?.reset();
                      },
                      child: Container(
                        child: Row(
                          children: [Icon(Icons.send), Text('เพิ่มข้อมูล')],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: qoutes!.length == 0
                  ? Center(
                      child: Text('empty'),
                    )
                  : ListView.builder(
                      itemCount: qoutes?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardYoda(qoutes![index].imageUrl,
                            qoutes![index].text, qoutes![index].detail);
                      },
                    ),
            ),
          ],
        ));
  }
}

// class Homepage extends StatelessWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           'Quot',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: ListView(
//         children: [
//           CardYoda('1', '11'),
//           CardYoda('2', '22'),
//           CardYoda('3', '33'),
//           CardYoda('4', '251321'),
//         ],
//       ),
//     );
//   }
// }

class CardYoda extends StatelessWidget {
  final String _images;
  final String _text;
  final String _detail;
  const CardYoda(
    this._images,
    this._text,
    this._detail, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      margin: EdgeInsets.all(8),
      elevation: 10,
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(_images),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_text',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$_detail',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                    fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
