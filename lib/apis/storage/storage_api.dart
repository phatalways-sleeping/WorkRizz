import 'dart:async';

part 'firestore_storage_api.dart';
part 'shared_preference_storage_api.dart';

sealed class StorageAPI {
  const StorageAPI();

  Future<void> findTask();

  Future<void> findUser();

  Future<void> findProject();

  Future<void> findTeam();

  Future<void> findComment();
}
