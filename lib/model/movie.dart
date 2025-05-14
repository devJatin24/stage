class MovieModel {
  bool favorite = false;
  String? backdropPath;
  int? movieId;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  String? title;

  MovieModel(
      {this.favorite= false,
        this.backdropPath,
        this.movieId,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.title});

  MovieModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path']??"";
    movieId = json['id']??0;
    originalLanguage = json['original_language']??"";
    originalTitle = json['original_title']??"";
    posterPath = json['poster_path']??"";
    title = json['title']??"";
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favorite'] = this.favorite ? 1 : 0;
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.movieId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    return data;
  }
}