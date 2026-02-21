class SilabaModel {
  final String palavra;
  final List<String> silabas;
  final String imagem;
  final String audio;

  SilabaModel({
    required this.palavra,
    required this.silabas,
    required this.imagem,
    required this.audio,
  });

  factory SilabaModel.fromJson(Map<String, dynamic> json) {
    return SilabaModel(
      palavra: json['palavra'],
      silabas: List<String>.from(json['silabas']),
      imagem: json['imagem'],
      audio: json['audio'],
    );
  }
}
