class Countries {
  final String country;
  final int newConfirmed;
  final int toatldeath;
  final int newdeaths;
  final int confirmed;
  final int totalrecovered;
  final int newrecovered;
  final String slug;

  Countries(this.country, this.newConfirmed, this.toatldeath, this.newdeaths,
      this.confirmed, this.totalrecovered, this.newrecovered, this.slug);

  List<Countries> coun = [];
}
