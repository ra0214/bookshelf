import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/user.dart';

class AuthRepository {
  // Simulación de URL base para requerimientos de informe
  final String _baseUrl = 'https://api.bookshelfclub.com/v1/auth';

  Future<User?> login(String email, String password) async {
    // Estructura sugerida para reporte de cliente HTTP (POST)
    /*
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    */

    // Simulación de respuesta exitosa para prototipo funcional
    await Future.delayed(const Duration(seconds: 2));
    
    if (email == "test@bookshelf.com" && password == "123456") {
      return User(
        id: "1", 
        email: email, 
        name: "Lector Premium"
      );
    }
    return null;
  }

  Future<User?> register(String name, String email, String password) async {
    // Estructura sugerida para reporte de cliente HTTP (POST)
    /*
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    */

    await Future.delayed(const Duration(seconds: 2));
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      email: email, 
      name: name
    );
  }
}
