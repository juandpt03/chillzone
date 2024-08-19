class ImageRequest {
  final String model;
  final String prompt;
  final int n;
  final String size;

  ImageRequest({
    this.model = 'dall-e-2',
    required this.prompt,
    this.n = 1,
    this.size = '1024x1024',
  });

  factory ImageRequest.fromJson(Map<String, dynamic> json) => ImageRequest(
        model: json["model"],
        prompt: json["prompt"],
        n: json["n"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "prompt": prompt,
        "n": n,
        "size": size,
      };
}
