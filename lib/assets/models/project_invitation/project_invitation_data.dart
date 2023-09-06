import 'package:task_managing_application/models/project_invitation/project_invitation.dart';

const invitation1 = ProjectInvitationModel(
  id: '20230905-1421-8602-9136-1980da534b1e',
  senderId: '20230831-0517-8130-8211-a9c1dfa3e677',
  senderImageUrl: 'avatars/avatar_4.jpg',
  projectId: '20230831-0508-8d53-a880-b370f9865591',
  projectName: 'Project 1',
  projectLeaderId: '20230831-0517-8230-a202-0089f860b83a',
  projectLeaderImageUrl: 'avatars/avatar_1.jpg',
  receiverId: '20230831-0517-8230-a202-0089f860b83a',
  senderEmail: 'jane@example.com',
  senderUsername: 'Jane Smith',

);

const invitation2 = ProjectInvitationModel(
  id: '20230905-1421-8a02-a150-cfbe1e98961f',
  senderId: '20230831-0517-8130-8211-a9c1dfa3e677',
  senderImageUrl: 'avatars/avatar_4.jpg',
  projectId: '20230831-0508-8853-9869-082ff370d762',
  projectName: 'Project 2',
  projectLeaderId: '20230831-0517-8130-8211-a9c1dfa3e677',
  projectLeaderImageUrl: 'avatars/avatar_4.jpg',
  receiverId: '20230831-0517-8230-a202-0089f860b83a',
  senderEmail: 'jane@example.com',
  senderUsername: 'Jane Smith',
);

const invitationList = [
  invitation1,
  invitation2,
];