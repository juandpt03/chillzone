class ImageResponse {
  final int created;
  final List<DalleImage> images;

  ImageResponse({
    required this.created,
    required this.images,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        created: json["created"],
        images: List<DalleImage>.from(
            json["data"].map((x) => DalleImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class DalleImage {
  final String url;

  DalleImage({
    required this.url,
  });

  factory DalleImage.fromJson(Map<String, dynamic> json) => DalleImage(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
