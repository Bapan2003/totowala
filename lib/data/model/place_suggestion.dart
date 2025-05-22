class PlaceSuggestion {
  String? description;
  String? placeId;
  String? reference;
  String? mainText;

  PlaceSuggestion(
      {this.description,
        this.placeId,
        this.reference,this.mainText});

  PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    description = json['description'];

    placeId = json['place_id'];
    reference = json['reference'];
    mainText=json['structured_formatting']['main_text']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    data['main_text']=this.mainText;
    return data;
  }
}



