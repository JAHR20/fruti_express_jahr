import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/firebase_options.dart';
import 'package:fruti_express_jahr/models/Categoria_Producto.dart';
import 'package:fruti_express_jahr/providers/auth_provider.dart';
import 'package:fruti_express_jahr/providers/carrito_provider.dart';
import 'package:fruti_express_jahr/providers/direccion_provider.dart';
import 'package:fruti_express_jahr/screens/CategoriaScreen.dart';
import 'package:fruti_express_jahr/screens/HomeScreens.dart';
import 'package:fruti_express_jahr/screens/CarritoCompra.dart';
import 'package:fruti_express_jahr/screens/LoginScreen.dart';
import 'package:fruti_express_jahr/screens/PagoScreen.dart';
import 'package:fruti_express_jahr/screens/RegisterScreen.dart';
import 'package:fruti_express_jahr/screens/addDireccionUsuario.dart';
import 'package:fruti_express_jahr/screens/syncing_screen.dart';
import 'package:fruti_express_jahr/service_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => CarritoProvider()),
        ChangeNotifierProvider(create: (context) => DireccionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'fruti express Jahr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 12, 75, 193),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/syncing', builder: (context, state) => SyncingScreen()),
    GoRoute(
      path: '/registroUser',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/categoria',
      builder: (context, state) {
        final categoria = state.extra as Categoria;
        return CategoriaScreen(categoria: categoria);
      },
    ),
    GoRoute(path: '/carrito', builder: (context, state) => CarritoCompra()),
    GoRoute(
      path: "/SeleciconarDirec",
      builder: (context, state) => SeleccionarDireccionScreen(),
    ),
    GoRoute(
      path: '/pago',
      builder: (context, state) {
        // Recibe la dirección de la pantalla anterior
        final Direccion direccion = state.extra as Direccion;
        return ResumenDePagoScreen(direccion: direccion);
      },
    ),
  ],
);
