

class Point {
  final String type;
  final double longitude;
  final double latitude;



  const Point({
    required this.type,
    required this.longitude,
    required this.latitude,

  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      type: json['type'],
      longitude: json['coordinates'][1],
      latitude: json['coordinates'][0],

    );
  }
}