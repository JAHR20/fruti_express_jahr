import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/service_locator.dart';
import 'package:fruti_express_jahr/services/SyncService.dart';
import 'package:go_router/go_router.dart';

class SyncingScreen extends StatefulWidget {
  const SyncingScreen({Key? key}) : super(key: key);

  @override
  _SyncingScreenState createState() => _SyncingScreenState();
}

class _SyncingScreenState extends State<SyncingScreen> {
  @override
  void initState() {
    super.initState();
    _startSyncAndNavigate();
  }

  Future<void> _startSyncAndNavigate() async {
    try {
      final syncService = locator<SyncService>();
      await syncService.initializeSync();
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      print("Error fatal de sincronización: $e");
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Sincronizando tus datos...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
