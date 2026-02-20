// lib/models/palavras_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/palavra_model.dart';

class PalavrasService {
  static Map<String, List<PalavraModel>> _banco = {};

  static Future<void> carregarPalavras() async {
    final String response = await rootBundle.loadString(
      'assets/data/palavras.json',
    );
    final data = json.decode(response);

    _banco = {
      "monossilabas": (data["monossilabas"] as List)
          .map((e) => PalavraModel.fromJson(e))
          .toList(),
      "dissilabas": (data["dissilabas"] as List)
          .map((e) => PalavraModel.fromJson(e))
          .toList(),
      "trissilabas": (data["trissilabas"] as List)
          .map((e) => PalavraModel.fromJson(e))
          .toList(),
      "polissilabas": (data["polissilabas"] as List)
          .map((e) => PalavraModel.fromJson(e))
          .toList(),
    };
  }

  static PalavraModel palavraAleatoria(String tipo) {
    final lista = _banco[tipo]!;
    final random = Random();
    return lista[random.nextInt(lista.length)];
  }
}
