class Zone {
  String? name;

  Zone({this.name});

  Zone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
      
  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name
    };
  }
}