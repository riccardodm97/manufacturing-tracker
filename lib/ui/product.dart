class Product {
  String name;
  String date;
  String id;
  List<String> components;

  Product(
      {this.name = 'Name',
      this.date = 'Date',
      this.id = 'ID',
      this.components = const ['Component1']});
}
