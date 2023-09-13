import 'dart:math';
import 'package:flutter/material.dart';

class MessageStructure{
  int messageID = Random().nextInt(1000000);

  String content;
  String url;
  String type;
  String user;
  String image;
  String originUser;
  Color color;
  DateTime date;
  MessageStructure({
    required this.content,
    required this.url,
    required this.type,
    required this.user,
    required this.image,
    required this.originUser,
    required this.color,
    required this.date,
  });
  bool isSender(){
    if (user == "Vinh") return true;
    else return false;
  }
  bool isSame(MessageStructure message){
    if (message.messageID == messageID && message.content == content) return true;

  String name;
  String url;
  String type;
  String user;
  String avatarImage;
  String originProject;
  Color color;
  DateTime date;
  MessageStructure({
    required this.name,
    required this.url,
    required this.type,
    required this.user,
    required this.avatarImage,
    required this.originProject,
    required this.color,
    required this.date,
  });
  bool isSame(MessageStructure message){
    if (message.messageID == messageID && message.name == name) return true;
    else return false;
  }
}


class UserStructure{
  int userID = Random().nextInt(1000000);
  String userName = "";
  String image = "";
  Color color = Colors.white;
  List<MessageStructure> messages = [];

  UserStructure(String _userName, Color _color){
    userName = _userName;
  }
}
class ProjectStructure{
  int projectID = Random().nextInt(1000000);
  String projectName = "";
  Color color = Colors.white;
  List<MessageStructure> messages = [];

  ProjectStructure(String _projectName, Color _color){
    projectName = _projectName;

    color = _color;
    messages = [];
  }
  bool addMessage(MessageStructure message){
    messages.add(message);
    return true;
  }

  bool isSender(){
    if (userName == "Vinh") return true;
    else return false;
  }
  bool isSame(UserStructure user){
    if (user.userID == userID && user.userName == userName) return true;
    else return false;
  }
  List <MessageStructure> getMessages(){
    List <MessageStructure> returnList = [];
    for (int j = 0; j < messages.length; j++){
      returnList.add(messages[j]);
    }
    return returnList;
  }
}

class MessageManagement{
  List <UserStructure> users = [];
  MessageManagement(){
    users = [];
    UserStructure user1 = UserStructure("Nhu Binh", Color(0xFF5CD669));;
      user1.addMessage(
        MessageStructure(
          content: "Here are the resource files of todays’     physics class", 
          url: "default", 
          type: "text", 
          user: user1.userName, 
          image: "assets/images/avt.jpg", 
          originUser: user1.userName, 
          color: user1.color, 
          date: DateTime.now())
      );
      user1.addMessage(
      MessageStructure(
        content: "Introduction to force", 
        url: "default", 
        type: "file", 
        user: user1.userName, 
        image: "assets/images/avt.jpg", 
        originUser: user1.userName, 
        color: user1.color, 
        date: DateTime.now())
    );
    users.add(user1);
  // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    UserStructure user2 = UserStructure("Vinh", Color(0xFFFFAFAF));;
      user2.addMessage(
        MessageStructure(
          content: "Thanks a lot Maya.😍😍 Is anyone please share your class note of this lecture. 🙏🙏", 
          url: "default", 
          type: "text", 
          user: user2.userName, 
          image: "assets/images/avt.jpg", 
          originUser: user2.userName, 
          color: user2.color, 
          date: DateTime.now())
      );
    users.add(user2);
    // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    UserStructure user3 = UserStructure("Kim Phat", Color(0xFF9C9AFF));
    for (int i = 0; i < 2; i++)
      user3.addMessage(
        MessageStructure(
          content: "I didn’t write down class note of this lecture. But I have made powerpoint presentation on force, energy and work.", 
          url: "default", 
          type: "text", 
          user: user3.userName, 
          image: "assets/images/avt.jpg", 
          originUser: user3.userName, 
          color: user3.color, 
          date: DateTime.now())
      );
    users.add(user3);
    // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    UserStructure user4 = UserStructure("Alice", Color(0xFFF6BB54));
    for (int i = 0; i < 10; i++)
      user4.addMessage(
        MessageStructure(
          content: "Thank you so much Vishal ❤️❤️", 
          url: "default", 
          type: "text", 
          user: user4.userName, 
          image: "assets/images/avt.jpg", 
          originUser: user4.userName, 
          color: user4.color, 
          date: DateTime.now())
      );
    users.add(user4);
  }
  List <MessageStructure> getMessages(){
    List <MessageStructure> returnList = [];
    for (int i = 0; i < users.length; i++){
      for (int j = 0; j < users[i].messages.length; j++){
        returnList.add(users[i].messages[j]);

  bool isSame(ProjectStructure project){
    if (project.projectID == projectID && project.projectName == projectName) return true;
    else return false;
  }
}

class MessageManagement{
  List <ProjectStructure> projects = [];
  MessageManagement(){
    projects = [];
    ProjectStructure project1 = ProjectStructure("Mobile", Color(0xFF5CD669));;
      project1.addMessage(
        MessageStructure(
          name: "Instruction", 
          url: "default", 
          type: "docx", 
          user: "vinh", 
          avatarImage: "assets/images/avt.jpg", 
          originProject: project1.projectName, 
          color: project1.color, 
          date: DateTime.now())
      );
      project1.addMessage(
      MessageStructure(
        name: "Instruction", 
        url: "default", 
        type: "docx", 
        user: "vinh", 
        avatarImage: "assets/images/avt.jpg", 
        originProject: project1.projectName, 
        color: project1.color, 
        date: DateTime.now())
    );
    projects.add(project1);
  // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    ProjectStructure project2 = ProjectStructure("Ethics", Color(0xFFFFAFAF));;
      project2.addMessage(
        MessageStructure(
          name: "Instruction", 
          url: "default", 
          type: "docx", 
          user: "vinh", 
          avatarImage: "assets/images/avt.jpg", 
          originProject: project2.projectName, 
          color: project2.color, 
          date: DateTime.now())
      );
    projects.add(project2);
    // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    ProjectStructure project3 = ProjectStructure("Databases", Color(0xFF9C9AFF));
    for (int i = 0; i < 3; i++)
      project3.addMessage(
        MessageStructure(
          name: "Instruction", 
          url: "default", 
          type: "docx", 
          user: "vinh", 
          avatarImage: "assets/images/avt.jpg", 
          originProject: project3.projectName, 
          color: project3.color, 
          date: DateTime.now())
      );
    projects.add(project3);
    // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    ProjectStructure project4 = ProjectStructure("Calculus", Color(0xFFF6BB54));
    for (int i = 0; i < 10; i++)
      project4.addMessage(
        MessageStructure(
          name: "Instruction", 
          url: "default", 
          type: "docx", 
          user: "vinh", 
          avatarImage: "assets/images/avt.jpg", 
          originProject: project4.projectName, 
          color: project4.color, 
          date: DateTime.now())
      );
    projects.add(project4);
  }
  List <MessageStructure> getMessages(){
    List <MessageStructure> returnList = [];
    for (int i = 0; i < projects.length; i++){
      for (int j = 0; j < projects[i].messages.length; j++){
        returnList.add(projects[i].messages[j]);

      }
    }
    return returnList;
  }



  List <UserStructure> getUser(){
    return users;
  }

  bool sendMessage(String inputMessage, String userName){
    if (inputMessage == "") return false;
    MessageStructure newMess = MessageStructure(
            content: inputMessage, 
            url: "default", 
            type: "text", 
            user: userName, 
            image: "assets/images/avt.jpg", 
            originUser: userName, 
            color: Color(0xFF5CD669),
            date: DateTime.now());
            
    if (users.length == 0 || users.last.userName != userName){
      UserStructure newUser = UserStructure(userName, Color(0xFF5CD669));
      newUser.addMessage(newMess);
      users.add(newUser);
      return true;
    } 
    else{
      users.last.addMessage(newMess);
      return true;
    }
    return false;
  }
}