class Product {
  String name;
  String date;
  String id;
  List<String> components;

  Product(
      {this.name = 'No name',
      this.date = 'No date',
      this.id = 'No ID',
      this.components = const ['No components']});
}
