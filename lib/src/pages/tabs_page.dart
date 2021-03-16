import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // Para evitar se muestre la curvatura cuando no hay mas páginas
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            color: Colors.red
          ),
          Container(
            color: Colors.green
          )
        ],
      ),
    );
  }
}