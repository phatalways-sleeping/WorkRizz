import 'package:task_managing_application/models/models.dart' show Project, Tag;

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
);

final projectList = [
  project1,
  project2,
];
