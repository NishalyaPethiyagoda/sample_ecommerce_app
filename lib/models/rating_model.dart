

class RatingModel {
  final double? rating;
  final int? count;

  RatingModel({required this.rating, required this.count}); 

  factory RatingModel.fromJson(Map<String, dynamic> json){
    return RatingModel(
      rating: json["rating"] , 
      count: json["count"],
    );
  }
}