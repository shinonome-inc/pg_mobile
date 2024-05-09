enum PGNUnit {
  day,
  week,
  month,
  year;

  String get text {
    switch (this) {
      case PGNUnit.day:
        return 'day';
      case PGNUnit.week:
        return 'week';
      case PGNUnit.month:
        return 'month';
      case PGNUnit.year:
        return 'year';
    }
  }
}
