// lib/models/palavra_model.dart
class PalavraModel {
  final String palavra;
  final List<String> silabas;
  final String imagem;

  PalavraModel({
    required this.palavra,
    required this.silabas,
    required this.imagem,
  });

  factory PalavraModel.fromJson(Map<String, dynamic> json) {
    return PalavraModel(
      palavra: json['palavra'],
      silabas: List<String>.from(json['silabas']),
      imagem: json['imagem'],
    );
  }
}
