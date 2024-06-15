import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login_seccion/models/usuarios.dart';
import 'package:login_seccion/urlUsuarios.dart';

final urlapi = url;

class Usuarios_Provider with ChangeNotifier{
  List<Usuario> usuarios = [];

  Usuarios_Provider(){
    getUsuarios();
  }

  getUsuarios() async {
    final response = await http.get(Uri.parse(urlapi));
    final resp = usuarioFromJson(response.body);
    usuarios = resp;

    notifyListeners();
  }
}