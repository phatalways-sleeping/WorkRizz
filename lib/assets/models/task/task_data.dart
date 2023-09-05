import 'package:task_managing_application/models/models.dart' show Task;
import 'package:task_managing_application/models/task/sub_task_small_info.dart';

const Task instance1 = Task(
  id: '20230831-0447-8e41-b180-662c48acc0b9',
  name: 'Task 1',
  subTasks: [
    '20230831-0437-8e17-8620-28c58df16111',
    '20230831-0437-8e17-b631-eb6dfab9622e',
    '20230831-0437-8717-8631-730781d020f9',
  ],
  project:
      '20230831-0508-8853-9869-082ff370d762', // Replace with actual project ID
  points: 20,
  isCompleted: false,
  subTasksCompleted: 1,
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
);

const Task instance2 = Task(
  id: '20230831-0447-8a41-9189-1f4e72621f8d',
  name: 'Task 2',
  subTasks: [
    '20230831-0437-8217-9632-e267d2883df8',
    '20230831-0442-8540-9148-7529597c79ef',
    '20230831-0442-8640-9158-a07a41ed5778',
  ],
  project:
      '20230831-0508-8853-9869-082ff370d762', // Replace with actual project ID
  points: 15,

  isCompleted: true,
  subTasksCompleted: 3,
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
);

const Task instance3 = Task(
  id: '20230831-0447-8841-b189-624e4164c668',
  name: 'Task 3',
  subTasks: [
    '20230831-0437-8617-b632-8c8d6f037d1f',
  ],
  project:
      '20230831-0508-8d53-a880-b370f9865591', // Replace with actual project ID
  points: 12,

  isCompleted: false,
  subTasksCompleted: 0,
  subTaskSmallInformations: [
    SubTaskSmallInformation(
      id: '20230831-0437-8617-b632-8c8d6f037d1f',
      name: 'Optimize Database Queries',
      isCompleted: false,
      points: 25,
      assigneeImageUrl: 'avatars/avatar_1.jpg',
    ),
  ],
);

const Task instance4 = Task(
  id: '20230831-0447-8e41-8189-6919e8aeb5a2',
  name: 'Task 4',
  subTasks: [
    '20230831-0442-8240-8158-ee80f5bda239',
    '20230831-0442-8e40-a159-3e9f946988dc',
  ],
  project:
      '20230831-0508-8d53-a880-b370f9865591', // Replace with actual project ID
  points: 12,

  isCompleted: false,
  subTasksCompleted: 0,
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
);

const Task instance5 = Task(
  id: '20230831-0447-8841-b189-1cee18c6c2cb',
  name: 'Task 5',
  subTasks: [
    '20230831-0442-8540-a159-236f0a1d39ff',
  ],
  project:
      '20230831-0508-8d53-a880-b370f9865591', // Replace with actual project ID
  points: 12,

  isCompleted: false,
  subTasksCompleted: 0,
  subTaskSmallInformations: [
    SubTaskSmallInformation(
      id: '20230831-0442-8540-a159-236f0a1d39ff',
      name: 'Bug Fixes and Testing',
      isCompleted: false,
      points: 22,
      assigneeImageUrl: 'avatars/avatar_1.jpg',
    ),
  ],
);

const Task instance6 = Task(
  id: '20230831-0447-8141-b190-f16bcf9d8fe1',
  name: 'Task 6',
  subTasks: [
    '20230831-0442-8b40-a159-62d06a1fb33b',
  ],
  project:
      '20230831-0508-8d53-a880-b370f9865591', // Replace with actual project ID
  points: 12,

  isCompleted: true,
  subTasksCompleted: 1,
  subTaskSmallInformations: [
    SubTaskSmallInformation(
      id: '20230831-0442-8b40-a159-62d06a1fb33b',
      name: 'Performance Optimization',
      isCompleted: true,
      points: 25,
      assigneeImageUrl: 'avatars/avatar_1.jpg',
    ),
  ],
);

const taskList = [
  instance1,
  instance2,
  instance3,
  instance4,
  instance5,
  instance6,
];
