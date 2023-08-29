import 'dart:async';

sealed class StorageAPI {
  const StorageAPI();

  Future<void> findTask();

  Future<void> findUser();

  Future<void> findProject();

  Future<void> findTeam();

  Future<void> findComment();
}

final class LocalStorageAPI extends StorageAPI {
  const LocalStorageAPI();

  @override
  Future<void> findTask() async {}

  @override
  Future<void> findUser() async {}

  @override
  Future<void> findProject() async {}

  @override
  Future<void> findTeam() async {}

  @override
  Future<void> findComment() async {}
}

final class CloudFirestoreStorageAPI extends StorageAPI {
  const CloudFirestoreStorageAPI();

  @override
  Future<void> findTask() async {}

  @override
  Future<void> findUser() async {}

  @override
  Future<void> findProject() async {}

  @override
  Future<void> findTeam() async {}

  @override
  Future<void> findComment() async {}
}
