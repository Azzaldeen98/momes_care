class Location {
  double? longitude;
  double? latitude;

  Location({this.longitude, this.latitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        longitude: (json['longitude'] as num?)?.toDouble(),
        latitude: (json['latitude'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'longitude': longitude,
        'latitude': latitude,
      };
}
