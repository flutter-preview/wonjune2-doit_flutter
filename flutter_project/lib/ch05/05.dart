String _name = 'Hello';

String get name {
  return _name.toUpperCase();
}

set name(value) {
  _name = value;
}

void main(List<String> args) {
  name = 'World';
  print('name: $name');
}
