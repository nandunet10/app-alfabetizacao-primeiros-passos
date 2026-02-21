// lib/models/palavras_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/silaba_model.dart';

class SilabasService {
  static Map<String, List<SilabaModel>> _banco = {};

  static Future<void> carregarSilabas() async {
    final String response = await rootBundle.loadString(
      'assets/data/silabas.json',
    );

    final data = json.decode(response);

    _banco = {
      "monossilabas": (data["monossilabas"] as List)
          .map((e) => SilabaModel.fromJson(e))
          .toList(),
      "dissilabas": (data["dissilabas"] as List)
          .map((e) => SilabaModel.fromJson(e))
          .toList(),
      "trissilabas": (data["trissilabas"] as List)
          .map((e) => SilabaModel.fromJson(e))
          .toList(),
      "polissilabas": (data["polissilabas"] as List)
          .map((e) => SilabaModel.fromJson(e))
          .toList(),
    };
  }

  static SilabaModel palavraAleatoria(String tipo) {
    final random = Random();

    if (tipo == 'aleatorio') {
      // Escolhe um tipo aleatório
      final tipos = _banco.keys.toList();
      final tipoEscolhido = tipos[random.nextInt(tipos.length)];
      final lista = _banco[tipoEscolhido]!;
      return lista[random.nextInt(lista.length)];
    } else {
      final lista = _banco[tipo]!;
      return lista[random.nextInt(lista.length)];
    }
  }
}
