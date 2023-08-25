import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  // Inicializar Firebase y obtener el usuario actual
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    final user = _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

  // Lista de categorías
  final List<String> categories = [
    "Cocteles",
    "Bebidas Naturales",
    "Otros",
    // Agrega más categorías según sea necesario
  ];

  // Categoría seleccionada
  String selectedCategory = "Cocteles";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Quita el app bar
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                selectedCategory,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // Abre el menú lateral
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.apps), // Cambia el icono a "apps"
              onPressed: () {
                // Muestra el menú flotante de categorías
                _showCategoryMenu(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navegar a la pantalla del carrito de pedidos
                Navigator.of(context).pushNamed('/cart');
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_user?.displayName ?? ''),
              accountEmail: Text(_user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _user?.displayName?.substring(0, 1) ?? '',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Historial de Pedidos'),
              onTap: () {
                // Navegar a la pantalla de historial de pedidos
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/order_history');
              },
            ),
            ListTile(
              title: Text('Editar Perfil'),
              onTap: () {
                // Navegar a la pantalla de edición de perfil
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/edit_profile');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () async {
                // Cerrar sesión
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el menú flotante de categorías
  void _showCategoryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildCategoryButton(context, categories[index]);
            },
          ),
        );
      },
    );
  }

  // Función para construir un botón de categoría en el menú flotante
  Widget _buildCategoryButton(BuildContext context, String categoryName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Cambia la categoría seleccionada
          setState(() {
            selectedCategory = categoryName;
          });
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // Color de fondo del botón
          onPrimary: Colors.white, // Color del texto del botón
        ),
        child: Text(categoryName),
      ),
    );
  }
}
