import 'dart:async';

import 'package:task_managing_application/apis/apis.dart';

final class StorageRepository {
  const StorageRepository._();

  static const StorageRepository instance = StorageRepository._();

  final StorageAPI api = const CloudFirestoreStorageAPI();

  FutureOr<void> findTask() {
    return api.findTask();
  }

  FutureOr<void> findUser() {
    return api.findUser();
  }

  FutureOr<void> findProject() {
    return api.findProject();
  }

  FutureOr<void> findTeam() {
    return api.findTeam();
  }
}