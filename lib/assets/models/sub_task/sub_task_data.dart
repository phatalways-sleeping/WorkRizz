import 'package:task_managing_application/models/models.dart' show SubTaskModel;

final SubTaskModel instance1 = SubTaskModel(
  id: '20230831-0437-8e17-8620-28c58df16111',
  name: 'Design Website Homepage',
  description: 'Create a visually appealing design for the website homepage.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 15),
  isCompleted: false,
  points: 20,
  files: const ['design_sketch.pdf'],
  comments: const [
    'Remember to follow the brand colors.',
    'Consider mobile responsiveness.'
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
  files: const ['firebase_config.json', 'user_auth.docx'],
  comments: const ['Ensure proper error handling for login and signup.'],
  progress: 100.0,
  grade: 95,
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
  files: const ['api_endpoints.pdf'],
  comments: const ['Include code examples for each endpoint.'],
  progress: 60.0,
  grade: 0,
  leaderComment: '',
);
final instance4 = SubTaskModel(//
  id: '20230831-0437-8217-9632-e267d2883df8',
  name: 'Test Cross-Browser Compatibility',
  description: 'Test the website on various browsers for compatibility issues.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 18),
  isCompleted: true,
  points: 18,
  files: const ['browser_compatibility_report.docx'],
  comments: const ['Pay attention to CSS rendering differences.'],
  progress: 100.0,
  grade: 88,
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
  files: const ['query_optimization_notes.csv'],
  comments: const ['Consider indexing and caching strategies.'],
  progress: 40.0,
  grade: 0,
  leaderComment: '',
);
final instance6 = SubTaskModel( //
  id: '20230831-0442-8540-9148-7529597c79ef',
  name: 'Create User Profile Page',
  description: 'Design and implement the user profile page.',
  assignee: '20230831-0517-8130-8211-a9c1dfa3e677',
  dueDate: DateTime(2023, 9, 30),
  isCompleted: true,
  points: 18,
  files: const ['profile_design.pdf'],
  comments: const ['Include user avatar and recent activity section.'],
  progress: 100.0,
  grade: 92,
  leaderComment: 'Impressive work on the user profile page!',
);
final instance7 = SubTaskModel(//
  id: '20230831-0442-8640-9158-a07a41ed5778',
  name: 'Test Payment Integration',
  description: 'Test payment gateway integration for purchasing products.',
  assignee: '20230831-0517-8230-a202-0089f860b83a',
  dueDate: DateTime(2023, 9, 28),
  isCompleted: true,
  points: 15,
  files: const ['payment_integration_report.docx'],
  comments: const [
    'Simulate different payment scenarios for thorough testing.'
  ],
  progress: 100.0,
  grade: 90,
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
  files: const ['user_documentation.pdf'],
  comments: const ['Include step-by-step guides and troubleshooting tips.'],
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
  files: const ['search_functionality_notes.docx'],
  comments: const ['Consider using full-text search libraries for efficiency.'],
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
  files: const ['bug_fixes_report.docx'],
  comments: const ['Collaborate with QA team for thorough testing.'],
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
  files: const ['performance_optimization.pdf'],
  comments: const ['Focus on critical user interactions and load times.'],
  progress: 100.0,
  grade: 85,
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
