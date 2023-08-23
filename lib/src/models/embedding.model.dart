class Embedding {
  final List<double> values;

  Embedding({required this.values});

  factory Embedding.fromJson(Map<String, dynamic> json) {
    return Embedding(
      values: List<double>.from(json['value'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': values,
    };
  }
}
