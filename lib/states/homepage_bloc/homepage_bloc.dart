import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/repositories/repositories.dart';
//import 'package:task_managing_application/states/homepage_bloc/homepage_event.dart';
//import 'package:task_managing_application/states/homepage_bloc/homepage_state.dart';
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc(this._applicationRepository) : super(const HomepageInitial()) {
    on<HomepageSubscribeToFirestore>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectOnViewStream(),
        onData: (project) => HomepageSubscription(project: project),
        onError: (error, stackTrace) => const HomepageError(),
      );
    });
    on<HomepageMarkProjectAsCompleted>((event, emit) async {
      await _applicationRepository.markProjectCompleted(
        (state as HomepageSubscription).project!.id,
        (state as HomepageSubscription).project!.assignees,
        (state as HomepageSubscription).project!.leader,
      );
    });
    on<HomepageMarkProjectAsUncompleted>((event, emit) async {
      await _applicationRepository.markProjectIncompleted(
        (state as HomepageSubscription).project!.id,
        (state as HomepageSubscription).project!.assignees,
        (state as HomepageSubscription).project!.leader,
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  Future<String> imageUrl(String path) async =>
      _applicationRepository.imageUrlOnStorageOf(path);

  Future<List<String>> assigneeAvatars() async {
    List<String> list = List.empty(growable: true);
    for (var assignee
        in (state as HomepageSubscription).project!.assigneeImageUrls) {
      await imageUrl(assignee).then(
        (value) => list.add(value),
      );
    }
    return list;
  }

  Future<List<NetworkImage>> mostActiveMembers() async {
    List<String> list = List.empty(growable: true);
    List<NetworkImage> imageList = List.empty(growable: true);
    for (var member
        in (state as HomepageSubscription).project!.mostActiveMemebers) {
      await _applicationRepository.userStream(member).first.then(
            (value) => list.add(
              value.imageUrl,
            ),
          );
    }
    for (var imageUrl in list) {
      await this.imageUrl(imageUrl).then(
        (value) => imageList.add(
          NetworkImage(value),
        ),
      );
    }
    return imageList;
  }
}
