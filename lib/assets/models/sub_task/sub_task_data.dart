import 'package:task_managing_application/models/file/file_model.dart';
import 'package:task_managing_application/models/models.dart' show SubTaskModel;

final SubTaskModel instance1 = SubTaskModel(
  id: '20230831-0437-8e17-8620-28c58df16111',
  name: 'Design Website Homepage',
  description: 'Create a visually appealing design for the website homepage.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 15),
  isCompleted: false,
  points: 20,
  files: [
    FileModel(
      fileName: 'homepage_design.pdf',
      uploadDate: DateTime(2023, 9, 1),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const [
    "20230901-2106-8901-8497-af9b3f8d9382",
    "20230901-2106-8201-8509-1baaeb5fb954",
  ],
  progress: 30.0,
  grade: 0,
  leaderComment: '',
);
final instance2 = SubTaskModel(
  id: '20230831-0437-8e17-b631-eb6dfab9622e',
  name: 'Implement User Authentication',
  description: 'Integrate user authentication using Firebase.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 20),
  isCompleted: true,
  points: 15,
  files: [
    FileModel(
      fileName: 'user_auth.pdf',
      uploadDate: DateTime(2023, 9, 4),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'David Wilson',
    ),
    FileModel(
      fileName: 'firebase_config.json',
      uploadDate: DateTime(2023, 8, 27),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'Jane Smith',
    ),
  ],
  comments: const ["20230901-2106-8301-a509-aaa8ac57aed9"],
  progress: 100.0,
  grade: 9,
  leaderComment: 'Great job on implementing authentication!',
);
final instance3 = SubTaskModel(
  id: '20230831-0437-8717-8631-730781d020f9',
  name: 'Write API Documentation',
  description: 'Document the usage of the API endpoints for developers.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 25),
  isCompleted: false,
  points: 12,
  files: [
    FileModel(
      fileName: 'api_endpoints.pdf',
      uploadDate: DateTime(2023, 8, 30),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'Jane Smith',
    ),
  ],
  comments: const ["20230901-2106-8901-9509-c296da10dcbc"],
  progress: 60.0,
  grade: 0,
  leaderComment: '',
);
final instance4 = SubTaskModel(
  //
  id: '20230831-0437-8217-9632-e267d2883df8',
  name: 'Test Cross-Browser Compatibility',
  description: 'Test the website on various browsers for compatibility issues.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 18),
  isCompleted: true,
  points: 18,
  files: [
    FileModel(
      fileName: 'browser_compatibility_report.docx',
      uploadDate: DateTime(2023, 9, 1),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const ["20230901-2106-8e01-8510-369f341de414"],
  progress: 100.0,
  grade: 9,
  leaderComment: 'Thank you for ensuring cross-browser compatibility!',
);
final instance5 = SubTaskModel(
  id: '20230831-0437-8617-b632-8c8d6f037d1f',
  name: 'Optimize Database Queries',
  description: 'Identify and optimize slow-performing database queries.',
  assignee: 'David Wilson20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 23),
  isCompleted: false,
  points: 25,
  files: [
    FileModel(
      fileName: 'query_optimization_notes.csv',
      uploadDate: DateTime(2023, 9, 2),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const ["20230901-2106-8401-9510-e39c269e5b1a"],
  progress: 40.0,
  grade: 0,
  leaderComment: '',
);
final instance6 = SubTaskModel(
  //
  id: '20230831-0442-8540-9148-7529597c79ef',
  name: 'Create User Profile Page',
  description: 'Design and implement the user profile page.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 30),
  isCompleted: true,
  points: 18,
  files: [
    FileModel(
      fileName: 'profile_design.pdf',
      uploadDate: DateTime(2023, 9, 7),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'Jane Smith',
    ),
  ],
  comments: const ["20230901-2106-8101-9510-69c20fc59c7c"],
  progress: 100.0,
  grade: 9,
  leaderComment: 'Impressive work on the user profile page!',
);
final instance7 = SubTaskModel(
  //
  id: '20230831-0442-8640-9158-a07a41ed5778',
  name: 'Test Payment Integration',
  description: 'Test payment gateway integration for purchasing products.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 28),
  isCompleted: true,
  points: 15,
  files: [
    FileModel(
      fileName: 'payment_integration_report.docx',
      uploadDate: DateTime(2023, 9, 8),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const ["20230901-2106-8501-b511-3914e6370c9a"],
  progress: 100.0,
  grade: 9,
  leaderComment: 'Thank you for ensuring smooth payment integration!',
);
final instance8 = SubTaskModel(
  id: '20230831-0442-8240-8158-ee80f5bda239',
  name: 'Write User Documentation',
  description: 'Create comprehensive user documentation for the application.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 30),
  isCompleted: false,
  points: 12,
  files: [
    FileModel(
      fileName: 'user_documentation.pdf',
      uploadDate: DateTime(2023, 9, 10),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'Jane Smith',
    ),
  ],
  comments: const ["20230901-2106-8501-8511-c7667838d9b4"],
  progress: 50.0,
  grade: 0,
  leaderComment: '',
);
final instance9 = SubTaskModel(
  id: '20230831-0442-8e40-a159-3e9f946988dc',
  name: 'Implement Search Functionality',
  description: 'Add search feature to enable users to find content easily.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 25),
  isCompleted: false,
  points: 20,
  files: [
    FileModel(
      fileName: 'search_functionality_notes.docx',
      uploadDate: DateTime(2023, 9, 11),
      ownerId: '20230831-0517-8130-8211-a9c1dfa3e677',
      ownerImageUrl: 'avatars/avatar_2.jpg',
      ownerName: 'Jane Smith',
    ),
  ],
  comments: const ["20230901-2106-8401-8511-bf27373a66b1"],
  progress: 40.0,
  grade: 0,
  leaderComment: '',
);
final instance10 = SubTaskModel(
  id: '20230831-0442-8540-a159-236f0a1d39ff',
  name: 'Bug Fixes and Testing',
  description: 'Identify and fix reported bugs; perform regression testing.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 29),
  isCompleted: false,
  points: 22,
  files: [
    FileModel(
      fileName: 'bug_fixes_report.docx',
      uploadDate: DateTime(2023, 9, 15),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const ["20230901-2106-8b01-b511-5ba65bc1d7c3"],
  progress: 60.0,
  grade: 0,
  leaderComment: '',
);
final instance11 = SubTaskModel(
  id: '20230831-0442-8b40-a159-62d06a1fb33b',
  name: 'Performance Optimization',
  description: 'Identify bottlenecks and optimize application performance.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 27),
  isCompleted: true,
  points: 25,
  files: [
    FileModel(
      fileName: 'performance_optimization.pdf',
      uploadDate: DateTime(2023, 9, 16),
      ownerId: '20230831-0517-8230-a202-0089f860b83a',
      ownerImageUrl: 'avatars/avatar_1.jpg',
      ownerName: 'Matthew Wilson',
    ),
  ],
  comments: const ["20230901-2106-8601-b512-24b194b5305c"],
  progress: 100.0,
  grade: 8,
  leaderComment: 'Thank you for enhancing the application\'s performance!',
);

final subTaskList = [
  instance1,
  instance2,
  instance3,
  instance4,
  instance5,
  instance6,
  instance7,
  instance8,
  instance9,
  instance10,
  instance11,
];
