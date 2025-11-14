/*import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import '../data/local/database.dart';


class ExportService {
  final AppDatabase database;

  ExportService(this.database);

  Future<String?> exportarUsuariosACSV() async {
    final listaUsuarios = await database.getAllUsuarios();
    if (listaUsuarios.isEmpty) {
      throw Exception("No hay datos para exportar.");
    }
    final rows = <List<dynamic>>[
      ['ID Local', 'Nombre', 'Email', 'Dirección', 'Teléfono'],
      ...listaUsuarios.map(
        (user) => [
          user.id,
          user.nombre,
          user.email,
          user.direccion,
          user.telefono,
        ],
      ),
    ];

    final csvData = const ListToCsvConverter().convert(rows);

    final params = SaveFileDialogParams(
      data: Uint8List.fromList(csvData.codeUnits),
      fileName:
          "respaldo_usuarios_${DateTime.now().toIso8601String().replaceAll(':', '-')}.csv",
      mimeTypesFilter: ["text/csv"],
    );

    final filePath = await FlutterFileDialog.saveFile(params: params);

    if (filePath == null) {
      throw Exception("El usuario canceló la selección de ubicación.");
    }

    return filePath;
  }
}

*/
