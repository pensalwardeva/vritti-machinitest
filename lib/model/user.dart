class User{
  int? id;
  String? name;
  String? contact;
  String? description;
  userMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name!;
    mapping['contact'] = contact!;
    mapping['description'] = description!;
    return mapping;
  }
}