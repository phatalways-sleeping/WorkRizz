import 'dart:async';

sealed class StorageAPI {
  const StorageAPI();

  FutureOr<void> findTask();

  FutureOr<void> findUser();

  FutureOr<void> findProject();

  FutureOr<void> findTeam();

  FutureOr<void> findComment();
}

final class LocalStorageAPI extends StorageAPI {
  const LocalStorageAPI();

  @override
  FutureOr<void> findTask() {}

  @override
  FutureOr<void> findUser() {}

  @override
  FutureOr<void> findProject() {}

  @override
  FutureOr<void> findTeam() {}

  @override
  FutureOr<void> findComment() {}
}

final class CloudFirestoreStorageAPI extends StorageAPI {
  const CloudFirestoreStorageAPI();

  @override
  FutureOr<void> findTask() {}

  @override
  FutureOr<void> findUser() {}

  @override
  FutureOr<void> findProject() {}

  @override
  FutureOr<void> findTeam() {}

  @override
  FutureOr<void> findComment() {}
}
