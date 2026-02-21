import 'dart:convert';
import 'package:alfabetizacao_app/models/letra_model.dart';
import 'package:flutter/services.dart';

class LetrasService {
  static List<LetraModel> _letras = [];
  static int _indiceAtual = 0;

  /// Carrega o JSON das letras
  static Future<void> carregarLetras() async {
    if (_letras.isNotEmpty) return;

    final String jsonString = await rootBundle.loadString(
      'assets/data/letras.json',
    );

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> data = jsonMap['letras'];

    _letras = data.map((e) => LetraModel.fromJson(e)).toList();
  }

  /// Retorna a letra atual
  static LetraModel letraAtual() {
    return _letras[_indiceAtual];
  }

  /// Próxima letra (A → B → C)
  static LetraModel proxima() {
    _indiceAtual = (_indiceAtual + 1) % _letras.length;
    return _letras[_indiceAtual];
  }

  /// Letra anterior (C → B → A)
  static LetraModel anterior() {
    _indiceAtual = (_indiceAtual - 1 + _letras.length) % _letras.length;
    return _letras[_indiceAtual];
  }

  /// Resetar para começar do A
  static void resetar() {
    _indiceAtual = 0;
  }
}
