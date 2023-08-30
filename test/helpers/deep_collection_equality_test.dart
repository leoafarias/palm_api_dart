import 'package:palm_api/src/helpers/deep_collection_equality.dart';
import 'package:test/test.dart';

void main() {
  final deepEquality = DeepCollectionEquality();

  group('DeepCollectionEquality', () {
    test('should compare lists deeply', () {
      final list1 = [
        1,
        [2, 3],
        4
      ];
      final list2 = [
        1,
        [2, 3],
        4
      ];
      final list3 = [
        1,
        [2, 4],
        4
      ];

      expect(deepEquality.equals(list1, list2), true);
      expect(deepEquality.equals(list1, list3), false);
    });

    test('should compare sets deeply', () {
      final set1 = {
        1,
        {2, 3},
        4
      };
      final set2 = {
        4,
        {3, 2},
        1
      };
      final set3 = {
        1,
        {2, 4},
        4
      };

      expect(deepEquality.equals(set1, set2), true);
      expect(deepEquality.equals(set1, set3), false);
    });

    test('should compare maps deeply', () {
      final map1 = {
        'a': 1,
        'b': {'c': 2, 'd': 3},
        'e': 4,
      };
      final map2 = {
        'e': 4,
        'b': {'d': 3, 'c': 2},
        'a': 1,
      };
      final map3 = {
        'a': 1,
        'b': {'c': 2, 'd': 4},
        'e': 4,
      };

      expect(deepEquality.equals(map1, map2), true);
      expect(deepEquality.equals(map1, map3), false);
    });

    test('should compare custom objects deeply', () {
      final object1 = CustomObject(1, CustomObject(2, null));
      final object2 = CustomObject(1, CustomObject(2, null));
      final object3 = CustomObject(1, CustomObject(3, null));

      expect(deepEquality.equals(object1, object2), true);
      expect(deepEquality.equals(object1, object3), false);
    });

    test('should compute hash codes deeply', () {
      final list = [
        1,
        [2, 3],
        4
      ];
      final set = {
        1,
        {2, 3},
        4
      };
      final map = {
        'a': 1,
        'b': {'c': 2, 'd': 3},
        'e': 4,
      };
      final object = CustomObject(1, CustomObject(2, null));

      final listHashCode = deepEquality.hash(list);
      final setHashCode = deepEquality.hash(set);
      final mapHashCode = deepEquality.hash(map);
      final objectHashCode = deepEquality.hash(object);

      expect(listHashCode, isNotNull);
      expect(setHashCode, isNotNull);
      expect(mapHashCode, isNotNull);
      expect(objectHashCode, isNotNull);
    });
  });
}

class CustomObject {
  final int value;
  final CustomObject? next;

  CustomObject(this.value, this.next);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomObject) return false;

    return value == other.value && next == other.next;
  }

  @override
  int get hashCode => value.hashCode ^ next.hashCode;
}
