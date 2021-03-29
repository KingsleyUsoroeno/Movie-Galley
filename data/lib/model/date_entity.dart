class DateEntity {
  String maximum;
  String minimum;

  DateEntity({this.maximum, this.minimum});

  DateEntity.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maximum'] = this.maximum;
    data['minimum'] = this.minimum;
    return data;
  }

  @override
  String toString() {
    return 'Dates{maximum: $maximum, minimum: $minimum}';
  }
}
