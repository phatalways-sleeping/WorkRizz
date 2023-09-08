import 'package:task_managing_application/models/models.dart' show Project, Tag;
import 'package:task_managing_application/models/project/sub_task_small_info.dart';
import 'package:task_managing_application/models/project/task_small_info.dart';

final Project project1 = Project(
  id: '20230831-0508-8853-9869-082ff370d762',
  name: 'Software Development Project',
  tags: const [Tag(title: 'Development'), Tag(title: 'Software')],
  startDate: DateTime(2023, 8, 31),
  endDate: DateTime(2023, 12, 31),
  tasks: const [
    '20230831-0447-8e41-b180-662c48acc0b9', // task 1
    '20230831-0447-8a41-9189-1f4e72621f8d', // task 2
  ],
  leader: '20230831-0517-8230-a202-0089f860b83a',
  creatorId: '20230831-0517-8230-a202-0089f860b83a',
  leaderImageUrl: 'avatars/avatar_1.jpg',
  assignees: const [
    '20230831-0517-8230-a202-0089f860b83a',
    '20230831-0517-8130-8211-a9c1dfa3e677'
  ],
  assigneeImageUrls: const [
    'avatars/avatar_1.jpg',
    'avatars/avatar_4.jpg',
  ],
  mostActiveMemebers: const [
    '20230831-0517-8230-a202-0089f860b83a',
    '20230831-0517-8130-8211-a9c1dfa3e677'
  ],
  thread: '20230831-0729-8457-a023-e2fa64ce2b29',
  totalActivities: 6,
  tasksCompleted: 1,
  activitiesCompleted: 4,
  totalFileLinks: 7,
  taskSmallInformations: const [
    TaskSmallInformation(
      id: '20230831-0447-8e41-b180-662c48acc0b9',
      name: 'Task 1',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0437-8e17-8620-28c58df16111',
          name: 'Design Website Homepage',
          points: 20,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
          isCompleted: false,
        ),
        SubTaskSmallInformation(
          id: '20230831-0437-8e17-b631-eb6dfab9622e',
          name: 'Implement User Authentication',
          isCompleted: true,
          points: 15,
          assigneeImageUrl: 'avatars/avatar_2.jpg',
        ),
        SubTaskSmallInformation(
          id: '20230831-0437-8717-8631-730781d020f9',
          name: 'Write API Documentation',
          isCompleted: false,
          points: 12,
          assigneeImageUrl: 'avatars/avatar_2.jpg',
        ),
      ],
    ),
    TaskSmallInformation(
      id: '20230831-0447-8a41-9189-1f4e72621f8d',
      name: 'Task 2',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0437-8217-9632-e267d2883df8',
          name: 'Test Cross-Browser Compatibility',
          isCompleted: true,
          points: 18,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
        ),
        SubTaskSmallInformation(
          id: '20230831-0442-8540-9148-7529597c79ef',
          name: 'Create User Profile Page',
          isCompleted: true,
          points: 18,
          assigneeImageUrl: 'avatars/avatar_2.jpg',
        ),
        SubTaskSmallInformation(
          id: '20230831-0442-8640-9158-a07a41ed5778',
          name: 'Test Payment Integration',
          isCompleted: true,
          points: 15,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
        ),
      ],
    ),
  ],
);

final Project project2 = Project(
  id: '20230831-0508-8d53-a880-b370f9865591',
  name: 'Ordinary Coffee House',
  tags: const [
    Tag(title: 'Development'),
    Tag(title: 'Software'),
    Tag(title: 'Flutter'),
    Tag(title: 'Architecture'),
  ],
  startDate: DateTime(2023, 9, 31),
  endDate: DateTime(2023, 11, 31),
  tasks: const [
    '20230831-0447-8841-b189-624e4164c668', // task 3
    '20230831-0447-8e41-8189-6919e8aeb5a2', // task 4
    '20230831-0447-8841-b189-1cee18c6c2cb', // task 5
    '20230831-0447-8141-b190-f16bcf9d8fe1', // task 6
  ],
  leader: '20230831-0517-8130-8211-a9c1dfa3e677',
  creatorId: '20230831-0517-8130-8211-a9c1dfa3e677',
  leaderImageUrl: 'avatars/avatar_4.jpg',
  assignees: const [
    '20230831-0517-8230-a202-0089f860b83a',
    '20230831-0517-8130-8211-a9c1dfa3e677'
  ],
  assigneeImageUrls: const [
    'avatars/avatar_1.jpg',
    'avatars/avatar_4.jpg',
  ],
  mostActiveMemebers: const [
    '20230831-0517-8230-a202-0089f860b83a',
    '20230831-0517-8130-8211-a9c1dfa3e677'
  ],
  thread: '20230831-0729-8657-b022-9b5f41734dcc',
  tasksCompleted: 1,
  totalActivities: 5,
  activitiesCompleted: 1,
  totalFileLinks: 5,
  taskSmallInformations: const [
    TaskSmallInformation(
      id: '20230831-0447-8841-b189-624e4164c668',
      name: 'Task 3',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0437-8617-b632-8c8d6f037d1f',
          name: 'Optimize Database Queries',
          isCompleted: false,
          points: 25,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
        ),
      ],
    ),
    TaskSmallInformation(
      id: '20230831-0447-8e41-8189-6919e8aeb5a2',
      name: 'Task 4',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0442-8240-8158-ee80f5bda239',
          name: 'Write User Documentation',
          isCompleted: false,
          points: 12,
          assigneeImageUrl: 'avatars/avatar_2.jpg',
        ),
        SubTaskSmallInformation(
          id: '20230831-0442-8e40-a159-3e9f946988dc',
          name: 'Implement Search Functionality',
          isCompleted: true,
          points: 20,
          assigneeImageUrl: 'avatars/avatar_2.jpg',
        ),
      ],
    ),
    TaskSmallInformation(
      id: '20230831-0447-8841-b189-1cee18c6c2cb',
      name: 'Task 5',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0442-8540-a159-236f0a1d39ff',
          name: 'Bug Fixes and Testing',
          isCompleted: false,
          points: 22,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
        ),
      ],
    ),
    TaskSmallInformation(
      id: '20230831-0447-8141-b190-f16bcf9d8fe1',
      name: 'Task 6',
      subTaskSmallInformations: [
        SubTaskSmallInformation(
          id: '20230831-0442-8b40-a159-62d06a1fb33b',
          name: 'Performance Optimization',
          isCompleted: true,
          points: 25,
          assigneeImageUrl: 'avatars/avatar_1.jpg',
        ),
      ],
    )
  ],
);

final projectList = [
  project1,
  project2,
];
