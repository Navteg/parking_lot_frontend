import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_lot_system/data/storage/key_value_storage.dart';

class KeyValueStorageImpl extends KeyValueStorage {
  FlutterSecureStorage storage;
  KeyValueStorageImpl({
    this.storage = const FlutterSecureStorage(),
  });
  @override
  FutureOr<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  FutureOr<T?> read<T>(String key, {T? defaultValue}) async {
    final returnValue = await storage.read(key: key);
    if (returnValue != null) {
      final dynamic newValue = jsonDecode(returnValue);
      debugPrint(newValue.toString());
      return jsonDecode(returnValue) as T?;
    } else {
      return defaultValue;
    }
  }

  @override
  FutureOr<void> write(String key, dynamic value) async {
    final storeValue = jsonEncode(value);
    debugPrint(storeValue);
    await storage.write(key: key, value: storeValue);
  }
}
