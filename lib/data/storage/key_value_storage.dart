import 'dart:async';

abstract class KeyValueStorage {
  const KeyValueStorage();
  FutureOr<void> delete(String key);
  void deleteAll();
  FutureOr<T?> read<T>(String key, {T? defaultValue});
  FutureOr<void> write(String key, dynamic value);
}
