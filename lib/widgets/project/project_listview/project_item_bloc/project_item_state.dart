part of 'project_item_bloc.dart';

sealed class ProjectItemState extends Equatable {
  const ProjectItemState({
    this.name,
    this.leader,
    this.assigneeImageUrls,
    this.leaderImageUrl,
    this.isCompleted,
    this.endDate,
    this.tags,
    this.thread,
    this.totalFileLinks,
  });

  final String? name;
  final DateTime? endDate;
  final List<Tag>? tags;
  final String? leader;
  final String? leaderImageUrl;
  final List<String>? assigneeImageUrls;
  final bool? isCompleted;
  final String? thread;
  final int? totalFileLinks;

  @override
  List<Object> get props => [
        if (name != null) name!,
        if (endDate != null) endDate!,
        if (tags != null) tags!,
        if (leaderImageUrl != null) leaderImageUrl!,
        if (leader != null) leader!,
        if (assigneeImageUrls != null) assigneeImageUrls!,
        if (isCompleted != null) isCompleted!,
        if (thread != null) thread!,
        if (totalFileLinks != null) totalFileLinks!,
      ];
}

final class ProjectItemInitial extends ProjectItemState {
  const ProjectItemInitial();
}

sealed class ProjectItemLoading extends ProjectItemState {
  const ProjectItemLoading();
}

final class ProjectItemLoadingNonFilter extends ProjectItemLoading {
  const ProjectItemLoadingNonFilter();
}

// final class ProjectItemLoadingFilter extends ProjectItemLoading {
//   const ProjectItemLoadingFilter();
// }

final class ProjectItemSuccess extends ProjectItemState {
  const ProjectItemSuccess({
    required super.name,
    required super.assigneeImageUrls,
    required super.leaderImageUrl,
    required super.isCompleted,
    required super.endDate,
    required super.tags,
    required super.thread,
    required super.leader,
    required super.totalFileLinks,
  });

  ProjectItemSuccess copyWith({
    String? name,
    DateTime? endDate,
    List<Tag>? tags,
    String? leaderImageUrl,
    String? leader,
    List<String>? assigneeImageUrls,
    bool? isCompleted,
    String? thread,
    int? totalFileLinks,
  }) =>
      ProjectItemSuccess(
        name: name ?? this.name,
        assigneeImageUrls: assigneeImageUrls ?? this.assigneeImageUrls,
        leaderImageUrl: leaderImageUrl ?? this.leaderImageUrl,
        isCompleted: isCompleted ?? this.isCompleted,
        endDate: endDate ?? this.endDate,
        tags: tags ?? this.tags,
        thread: thread ?? this.thread,
        leader: leader ?? this.leader,
        totalFileLinks: totalFileLinks ?? this.totalFileLinks,
      );
}

final class ProjectItemSuccessWithFilterStatus extends ProjectItemState {
  const ProjectItemSuccessWithFilterStatus({
    required super.name,
    required super.assigneeImageUrls,
    required super.leaderImageUrl,
    required super.isCompleted,
    required super.endDate,
    required super.tags,
    required super.thread,
    required this.filterColor,
    required super.leader,
    required super.totalFileLinks,
  });

  final Color filterColor;

  @override
  List<Object> get props => [...super.props, filterColor];

  ProjectItemSuccessWithFilterStatus copyWith({
    String? name,
    DateTime? endDate,
    List<Tag>? tags,
    String? leaderImageUrl,
    List<String>? assigneeImageUrls,
    bool? isCompleted,
    String? thread,
    Color? filterColor,
    String? leader,
    int? totalFileLinks,
  }) =>
      ProjectItemSuccessWithFilterStatus(
        name: name ?? this.name,
        assigneeImageUrls: assigneeImageUrls ?? this.assigneeImageUrls,
        leaderImageUrl: leaderImageUrl ?? this.leaderImageUrl,
        isCompleted: isCompleted ?? this.isCompleted,
        endDate: endDate ?? this.endDate,
        tags: tags ?? this.tags,
        thread: thread ?? this.thread,
        leader: leader ?? this.leader,
        filterColor: filterColor ?? this.filterColor,
        totalFileLinks: totalFileLinks ?? this.totalFileLinks,
      );
}

final class ProjectItemError extends ProjectItemState {
  const ProjectItemError();
}
