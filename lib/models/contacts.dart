class Results {
  String id;
  String phone;
  String name;
  String email;

  Results({this.id, this.phone, this.name, this.email});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}