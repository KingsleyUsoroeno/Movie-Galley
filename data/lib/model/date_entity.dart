class DateEntity {
  String maximum;
  String minimum;

  DateEntity({this.maximum, this.minimum});

  @override
  String toString() {
    return 'Dates{maximum: $maximum, minimum: $minimum}';
  }
}
