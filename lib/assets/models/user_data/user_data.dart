import 'package:task_managing_application/models/models.dart'
    show UserDataModel;

const user1 = UserDataModel(
  id: '20230831-0517-8230-a202-0089f860b83a',
  username: 'Matthew Wilson',
  email: 'matwil@gmail.com',
  subTasks: [
    '20230831-0437-8e17-8620-28c58df16111', // instance 1
    '20230831-0437-8217-9632-e267d2883df8', // instance 4
    '20230831-0437-8617-b632-8c8d6f037d1f', // instance 5
    '20230831-0442-8640-9158-a07a41ed5778', // instance 7
    '20230831-0442-8540-a159-236f0a1d39ff', // instance 10
    '20230831-0442-8b40-a159-62d06a1fb33b', // instance 11
  ],
  projects: [
    '20230831-0447-8e41-b180-662c48acc0b9',
    '20230831-0447-8a41-9189-1f4e72621f8d',
  ],
  tasks: [
    '20230831-0447-8e41-b180-662c48acc0b9', // task 1
    '20230831-0447-8a41-9189-1f4e72621f8d', // task 2
    '20230831-0447-8841-b189-624e4164c668', // task 3
    '20230831-0447-8841-b189-1cee18c6c2cb', // task 5
    '20230831-0447-8141-b190-f16bcf9d8fe1', // task 6
  ],
  personalSchedules: [
    '20230831-0518-8125-a912-e3d7d81fee82',
    '20230831-0518-8725-8922-9e9ecda033fe',
  ],
);
const user2 = UserDataModel(
  id: '20230831-0517-8130-8211-a9c1dfa3e677',
  username: 'Jane Smith',
  email: 'jane@example.com',
  subTasks: [
    '20230831-0437-8e17-b631-eb6dfab9622e', // instance 2
    '20230831-0437-8717-8631-730781d020f9', // instance 3
    '20230831-0442-8540-9148-7529597c79ef', // instance 6
    '20230831-0442-8240-8158-ee80f5bda239', // instance 8
    '20230831-0442-8e40-a159-3e9f946988dc', // instance 9
  ],
  projects: [
    '20230831-0447-8841-b189-624e4164c668',
  ],
  tasks: [
    '20230831-0447-8e41-b180-662c48acc0b9', // task 1
    '20230831-0447-8a41-9189-1f4e72621f8d', // task 2
    '20230831-0447-8e41-8189-6919e8aeb5a2', // task 4
  ],
  personalSchedules: [
    '20230831-0518-8825-9922-2669e5bb1d1d',
    '20230831-0518-8425-b922-14b4375c2bb5',
    '20230831-0518-8e25-b923-a3d16941e901',
  ],
);
