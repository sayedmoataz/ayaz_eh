class Store {
  String name;
  String address;
  String description;
  String phone;
  String whatsapp;
  String facebook;
  String instagram;
  String website;
  String location;
  
  Store({
    required this.name,
    required this.address,
    required this.description,
    required this.phone,
    required this.whatsapp,
    required this.facebook,
    required this.instagram,
    required this.website,
    required this.location,
  });

  // Convert a Store object into a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'phone': phone,
      'whatsapp': whatsapp,
      'facebook': facebook,
      'instagram': instagram,
      'website': website,
      'location': location,
    };
  }

  // Create a Store object from a map
  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      name: map['name'],
      address: map['address'],
      description: map['description'],
      phone: map['phone'],
      whatsapp: map['whatsapp'],
      facebook: map['facebook'],
      instagram: map['instagram'],
      website: map['website'],
      location: map['location'],
    );
  }
}
