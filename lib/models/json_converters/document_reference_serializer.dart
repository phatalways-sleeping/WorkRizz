
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DocumentReferenceSerializer implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentReferenceSerializer();

  @override
  DocumentReference fromJson(DocumentReference json) => json;

  @override
  DocumentReference toJson(DocumentReference object) => object;
}