class LetraModel {
  final String letra; // Ex: "A"
  final String imagem; // Ex: "abelha.png"
  final String audio; // Ex: "audios/letras/A.mp3"

  LetraModel({required this.letra, required this.imagem, required this.audio});

  factory LetraModel.fromJson(Map<String, dynamic> json) {
    return LetraModel(
      letra: json['letra'],
      imagem: json['imagem'],
      audio: json['audio'],
    );
  }

  Map<String, dynamic> toJson() => {
    'letra': letra,
    'imagem': imagem,
    'audio': audio,
  };
}
