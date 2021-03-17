import 'package:bandicoot/src/validate/matches_property.dart';
import 'package:test/test.dart';

void main() {
  test('matchesProperty returns true when two properties match', () {
    Map map1 = {'prop1': 'test', 'prop2': 'test'};
    Map map2 = {'prop1': 'test &89*; ()-=', 'prop2': 'test &89*; ()-='};
    Map map3 = {'prop1': 23, 'prop2': 23};

    expect(matchesProperty('prop1', 'prop2', map1), equals(true));
    expect(matchesProperty('prop1', 'prop2', map2), equals(true));
    expect(matchesProperty('prop1', 'prop2', map3), equals(true));
  });

  test('matchesProperty returns false when two properties do not match', () {
    Map map1 = {'prop1': 'test1', 'prop2': 'test2'};
    Map map2 = {'prop1': 'dfjdfUi *&099', 'prop2': 'dfjdfUi*&099'};
    Map map3 = {'prop1': 23, 'prop2': 233};

    expect(matchesProperty('prop1', 'prop2', map1), equals(false));
    expect(matchesProperty('prop1', 'prop2', map2), equals(false));
    expect(matchesProperty('prop1', 'prop2', map3), equals(false));
  });
}
