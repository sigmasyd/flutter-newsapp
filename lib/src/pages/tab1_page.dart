import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

// cambiamos la clase a StatefulWidget para usar los estados
class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

// utilizamos AutomaticKeepAliveClientMixin para mantener el estado actual de la lista de noticias
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    //final newsService = Provider.of<NewsService>(context);
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: (headlines.length==0)
        ? Center(
          child: CircularProgressIndicator(),
        )
        : ListaNoticias(headlines)
    );
  }

  // para utilizar AutomaticKeepAliveClientMixin debemos implementar el metodo wantKeepAlive
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; // Set true para indicar que siempre mantenga el estado
}
