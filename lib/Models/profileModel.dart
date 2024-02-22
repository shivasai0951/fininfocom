class profileModel {
  List<Results>? results;


  profileModel({this.results});

  profileModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Results {

  Name? name;
  Location? location;
  var email;
  Dob? dob;
  Dob? registered;
  Picture? picture;


  Results(
      {
        this.name,
        this.location,
        this.email,
        this.dob,
        this.registered,
        this.picture,
       });

  Results.fromJson(Map<String, dynamic> json) {

    name = json['name'] != null ?  Name.fromJson(json['name']) : null;
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    email = json['email'];

    dob = json['dob'] != null ?  Dob.fromJson(json['dob']) : null;
    registered = json['registered'] != null
        ?  Dob.fromJson(json['registered'])
        : null;

    picture =
    json['picture'] != null ?  Picture.fromJson(json['picture']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['email'] = email;

    if (dob != null) {
      data['dob'] = dob!.toJson();
    }
    if (registered != null) {
      data['registered'] = registered!.toJson();
    }

    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }

    return data;
  }
}

class Name {
  var title;
  var first;
  var last;

  Name({this.title, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}

class Location {
  var city;
  var state;
  var country;
  var postcode;


  Location(
      {
        this.city,
        this.state,
        this.country,
        this.postcode,
       });

  Location.fromJson(Map<String, dynamic> json) {

    city = json['city'];
    state = json['state'];
    country = json['country'];
    postcode = json['postcode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postcode'] = this.postcode;

    return data;
  }
}


class Dob {
  var date;
  int? age;

  Dob({this.date, this.age});

  Dob.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['age'] = this.age;
    return data;
  }
}



class Picture {
  var large;
  var medium;
  var thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
