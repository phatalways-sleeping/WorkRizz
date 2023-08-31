import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// This is the base class for all the models
// It contains 
//   + the reference to the document in the firestore
//   + the id of the document in the firestore
abstract class Base extends Equatable {
  const Base({
    required this.reference,
    required this.id,
  });

  // This is the reference to the document in the firestore
  final DocumentReference reference;
  // This is the id of the document in the firestore
  final String id;

  // This is the list of all the properties of the model
  // It is used to compare two models when they are updated
  @override
  List<Object> get props => [reference, id];
}



