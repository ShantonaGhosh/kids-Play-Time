class VideoListModel {
  String? name;
  int? playLimit;
  List<Playlist>? playlist;

  VideoListModel({this.name, this.playLimit, this.playlist});

  VideoListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playLimit = json['play_limit'];
    if (json['playlist'] != null) {
      playlist = <Playlist>[];
      json['playlist'].forEach((v) => playlist!.add(Playlist.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['play_limit'] = playLimit;
    if (playlist != null) {
      data['playlist'] = playlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlist {
  String? title;
  String? link;
  int? duration;

  Playlist({this.title, this.link, this.duration});

  Playlist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['duration'] = duration;
    return data;
  }
}
