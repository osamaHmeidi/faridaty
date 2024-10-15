

class NearMousqueModel{

    String? name;
    double? lat;
    double? long;


    NearMousqueModel({
      this.name,
      this.lat,
      this.long
    });

    factory NearMousqueModel.fromJson(Map<String,dynamic> json){
      return NearMousqueModel(
        name: json["results"][0]["name"],
        lat: json["results"][0]["geometry"]["location"]["lat"],
        long: json["results"][0]["geometry"]["location"]["lng"]
      );
    }
  }