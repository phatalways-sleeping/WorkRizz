// Generate instances of FileMessageModel
import 'package:task_managing_application/models/models.dart'
    show FileMessageModel, FileTypeMode, ImageMessageModel, TextMessageModel;

final fileMessage1 = FileMessageModel(
  id: '20230831-1221-8a41-9240-a5f34671da42',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  fileUrl: 'files/Books.pdf',
  fileName: 'Books.pdf',
  fileType: FileTypeMode.pdf,
);

final fileMessage2 = FileMessageModel(
  id: '20230831-1221-8841-9251-d30a04db0387',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  fileUrl: 'files/Work_And_Energy.txt',
  fileName: 'Work_And_Energy.txt',
  fileType: FileTypeMode.txt,
);

final fileMessage3 = FileMessageModel(
  id: '20230831-1221-8741-9251-b774e32523ac',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  fileUrl: 'files/income.csv',
  fileName: 'income.csv',
  fileType: FileTypeMode.csv,
);

// Generate instances of ImageMessageModel
final imageMessage1 = ImageMessageModel(
  id: '20230831-1221-8941-b251-c70ed6df7013',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  imageUrl: 'images/sample_1.jfif',
);

final imageMessage2 = ImageMessageModel(
  id: '20230831-1221-8341-9252-0e2d14cb8ee1',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  imageUrl: 'images/sample_2.jfif',
);
final imageMessage3 = ImageMessageModel(
  id: '20230831-1221-8341-a252-f6a2a815bbcc',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  imageUrl: 'images/sample_3.jfif',
);

// Generate instances of TextMessageModel
final textMessage1 = TextMessageModel(
  id: '20230831-1221-8641-9252-1a153de1ec20',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  text: 'Hello, how are you?',
);

final textMessage2 = TextMessageModel(
  id: '20230831-1221-8241-b253-62a77253e90e',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  text: 'I received the document. Thanks!',
);

final textMessage3 = TextMessageModel(
  id: '20230831-1221-8c41-9253-272db6cada09',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  text: 'Good morning, everyone!',
);

final textMessage4 = TextMessageModel(
  id: '20230831-1221-8141-9253-8aa53f37360f',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  text: 'Have a great day ahead!',
);
final textMessage5 = TextMessageModel(
  id: '20230831-1230-8d16-8302-abc8d05f7993',
  sender: '20230831-0517-8230-a202-0089f860b83a',
  time: DateTime.now(),
  text: 'Just finished a meeting.',
);

final textMessage6 = TextMessageModel(
  id: '20230831-1230-8c16-8311-749ecc5cd09b',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  text: 'Let\'s catch up later!',
);
final textMessage7 = TextMessageModel(
  id: '20230831-1230-8016-9311-dfba2168913b',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  text: 'Just got back from vacation!',
);

final textMessage8 = TextMessageModel(
  id: '20230831-1230-8216-a311-460ac4f98ff3',
  sender: '20230831-0517-8130-8211-a9c1dfa3e677',
  time: DateTime.now(),
  text: 'Let\'s plan a team outing!',
);

final messageList = [
  textMessage1,
  textMessage2,
  textMessage3,
  fileMessage1,
  imageMessage1,
  imageMessage2,
  textMessage4,
  textMessage5,
  fileMessage2,
  fileMessage3,
  imageMessage3,
  textMessage6,
  textMessage7,
  textMessage8,
];
