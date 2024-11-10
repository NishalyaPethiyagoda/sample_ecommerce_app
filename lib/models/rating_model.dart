

class RatingModel {
  final double? rating;
  final int? count;

  RatingModel({required this.rating, required this.count}); 

  factory RatingModel.fromJson(Map<String, dynamic> json){
    return RatingModel(
      rating: (json["rate"] is int) ? (json["rate"] as int).toDouble() : json["rate"] ?? 0.0,
      count: json["count"] ?? 0,
    );
  }
}