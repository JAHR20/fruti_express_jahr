import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/service_locator.dart';

class AuthProvider extends ChangeNotifier {
  final AppDatabase _database = locator<AppDatabase>();

  Usuario? _perfilLocal;

  Usuario? get perfilLocal => _perfilLocal;

  User? get firebaseUser => FirebaseAuth.instance.currentUser;

  bool get isLoggedIn => _perfilLocal != null;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null) {
      _perfilLocal = null;
      notifyListeners();
    } else {
      _perfilLocal = await _database.getUsuarioPorRemoteId(user.uid);
      notifyListeners();
    }
  }

  void setPerfilLocal(Usuario perfil) {
    _perfilLocal = perfil;
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
