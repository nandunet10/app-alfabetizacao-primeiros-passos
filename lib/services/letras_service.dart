import 'dart:convert';
import 'dart:math';
import 'package:alfabetizacao_app/models/letra_model.dart';
import 'package:flutter/services.dart';

class LetrasService {
  static List<LetraModel> _letras = [];

  /// Carrega o JSON das letras
  static Future<void> carregarLetras() async {
    if (_letras.isNotEmpty) return;

    final String jsonString = await rootBundle.loadString(
      'assets/data/letras.json',
    );
    final List<dynamic> data = json.decode(jsonString);

    _letras = data.map((e) => LetraModel.fromJson(e)).toList();
  }

  /// Retorna uma letra aleatória
  static LetraModel letraAleatoria() {
    final random = Random();
    return _letras[random.nextInt(_letras.length)];
  }

  /// Retorna todas as letras
  static List<LetraModel> todas() => _letras;
}
