import 'package:por1/por1.dart' as por1;

void main(List<String> arguments) {
 person some =person(name: "mohammed");
 some.printName();
  print('Hello world');
}
class person {
String? name;
int? age;
person({this.name, this.age});

void printName(){
  print("name $name");
}
}
