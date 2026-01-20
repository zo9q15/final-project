import 'package:por1/por1.dart' as por1;

void main(List<String> arguments) {
 person some =person(name: "mohammed");
  person sometwo =person(name: "alsalamah");
 some.printName();
 sometwo.printName();
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
