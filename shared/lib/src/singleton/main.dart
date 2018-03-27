import 'package:flutter/material.dart';

import 'package:reactive_exploration/common/models/cart.dart';
import 'package:reactive_exploration/common/models/catalog.dart';
import 'package:reactive_exploration/common/widgets/product_square.dart';

void main() => runApp(new MyApp());

Catalog _catalog = new Catalog.empty();

final Cart _cart = new Cart();

class CartPage extends StatefulWidget {
  static const routeName = "/cart";

  CartPage({Key key}) : super(key: key);

  @override
  State<CartPage> createState() => new _CartPageState();
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  @override
  void initState() {
    super.initState();

    updateCatalog(_catalog).then((_) => setState(() {
          // Calling setState with nothing at all in it is code smell.
          // But this is also the easiest way to do it without introducing more
          // advanced techniques.
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Singleton',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => new CartPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _CartPageState extends State<CartPage> {
  _CartPageState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Your Cart"),
      ),
      body: new Text("Cart: ${_cart.items}"),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Singleton"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              }),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Container(
              padding: const EdgeInsets.all(24.0),
              child: new Text("Cart: ${_cart.items}")),
          new Expanded(
            child: new GridView.count(
              crossAxisCount: 2,
              children: _catalog.products.map((product) {
                return new ProductSquare(
                  product: product,
                  onTap: () => setState(() {
                        _cart.add(product);
                      }),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
