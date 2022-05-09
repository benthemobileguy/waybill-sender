
class User {
  String emailAddress;
  String names;
  String image_path;
  String surname;
  String phone;
  String city;
  String country;
  String birthday;
  String latitude;
  String longitude;
  var statuss;

  User({this.emailAddress,
    this.names,
    this.surname,
    this.image_path,
    this.phone,
    this.city,
    this.statuss,
    this.country,
    this.birthday,
    this.latitude,
    this.longitude});

  User.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email_address'];
    names = json['names'];
    statuss = json['statuss'];
    image_path =json['image_path'];
    surname = json['surname'];
    phone = json['phone'];
    city = json['city'];
    country = json['country'];
    birthday = json['birthday'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_address'] = this.emailAddress;
    data['statuss'] = this.statuss;
    data['names'] = this.names;
    data['surname'] = this.surname;
    data['image_path'] = this.image_path;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['country'] = this.country;
    data['birthday'] = this.birthday;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}