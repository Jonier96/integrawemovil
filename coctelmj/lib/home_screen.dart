import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class Producto {
  final String imagen;

  Producto(this.imagen);
}

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Center(
        child: Text('Contenido del carrito aquí'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _buildScreens() {
    List<List<String>> categorias = [
      List.generate(8, (index) => Constants.coctelesImage(index)),
      List.generate(6, (index) => Constants.shotsImage(index)),
      List.generate(6, (index) => Constants.naturalesImage(index)),
    ];

    return categorias.map((categoria) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Categoría'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: categoria.length,
          itemBuilder: (context, index) {
            final producto = Producto(categoria[index]);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    producto.imagen,
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    String mensaje = 'Quiero este coctel: ${producto.imagen}';
                    String url =
                        'https://wa.me/3206925172?text=${Uri.encodeComponent(mensaje)}';
                    Uri uri =
                        Uri.parse(url); // Convierte la cadena a un objeto Uri

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      print('No se pudo abrir WhatsApp.');
                    }
                  },
                  child: Text('Pedir'),
                ),
              ],
            );
          },
        ),
      );
    }).toList();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/cocteles.png', width: 30, height: 30),
        title: 'Cocteles',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/shots.png', width: 30, height: 30),
        title: 'Shots',
        activeColorPrimary: Color.fromARGB(255, 54, 71, 218),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/naturales.png', width: 30, height: 30),
        title: 'Naturales',
        activeColorPrimary: Color.fromARGB(255, 147, 46, 220),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PersistentTabView(
        context,
        controller: PersistentTabController(initialIndex: 0),
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
