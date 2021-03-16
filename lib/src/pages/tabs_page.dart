import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // cambiamos de Scaffold a ChangeNotifierProvider, para implementar el Provider
    return ChangeNotifierProvider(
      // requiere la clase del modelo a implementar: create
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // context tiene toda la informacion del arbol de widgets.
    // en algun lugar se encuentra la instancia del provider
    // de esta forma obtenemos la instancia de la clase como si fuera un singleton
    // la ventaja es que ahora cuando se actualice la ventana actual, se va a redibujar los widgets
    // que se necesite
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual, // seleccionar current tab
      onTap: (i) => navegacionModel.paginaActual = i, // cambio current tab
      items: [
        // title property is deprecated, we are use label instead that is String no Text(like was with title)
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para tí'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados')
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      // controller
      controller: navegacionModel.pageController,
      // Para evitar se muestre la curvatura cuando no hay mas páginas
      //physics: BouncingScrollPhysics(),
      // se bloquea el slide por parte del usuario para forzar que utilice las tabs
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(color: Colors.red),
        Container(color: Colors.green)
      ],
    );
  }
}

// clase modelo que implementara el provider
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  // para usarlo como referencia
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    // notificar a todos los widgets que estan pendientes de la página actual
    // para que se redibujen si es necesario..
    // se lo hace con ChangeNotifier(clase) y metodo notifyListeners()
    notifyListeners();
  }

  // para que pueda controlar las paginas o page view
  PageController get pageController => this._pageController;
}
