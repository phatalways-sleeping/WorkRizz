import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_view.dart';

class FileStructure{
  int fileID = Random().nextInt(1000000);
  String name;
  String url;
  String type;
  String user;
  String avatarImage;
  String originProject;
  Color color;
  DateTime date;
  FileStructure({
    required this.name,
    required this.url,
    required this.type,
    required this.user,
    required this.avatarImage,
    required this.originProject,
    required this.color,
    required this.date,
  });
  bool isSame(FileStructure file){
    if (file.fileID == fileID && file.name == name) return true;
    else return false;
  }
}

class ProjectStructure{
  int projectID = Random().nextInt(1000000);
  String projectName = "";
  Color color = Colors.white;
  List<FileStructure> files = [];

  ProjectStructure(String _projectName, Color _color){
    projectName = _projectName;
    color = _color;
    files = [];
  }
  bool addFile(FileStructure file){
    files.add(file);
    return true;
  }

  bool isSame(ProjectStructure project){
    if (project.projectID == projectID && project.projectName == projectName) return true;
    else return false;
  }
}

class FileManagement{
  List <ProjectStructure> projects = [];
  FileManagement(){
    projects = [];
    ProjectStructure project1 = ProjectStructure("Mobile", Color(0xFF5CD669));;
      project1.addFile(
        FileStructure(
          name: "Instruction", 
          url: "default", 
          type: "docx", 
          user: "vinh", 
          avatarImage: "assets/images/avt.jpg", 
          originProject: project1.projectName, 
          color: project1.color, 
          date: DateTime.now())
      );
      project1.addFile(
      FileStructure(
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
      project2.addFile(
        FileStructure(
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
      project3.addFile(
        FileStructure(
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
      project4.addFile(
        FileStructure(
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
  List <FileStructure> getFiles(){
    List <FileStructure> returnList = [];
    for (int i = 0; i < projects.length; i++){
      for (int j = 0; j < projects[i].files.length; j++){
        returnList.add(projects[i].files[j]);
      }
    }
    return returnList;
  }
}