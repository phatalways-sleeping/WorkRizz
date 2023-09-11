import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

sealed class DownloadException implements Exception {
  const DownloadException(this.message);
  final String message;
}

final class DioDownloadException extends DownloadException {
  const DioDownloadException(String message) : super(message);

  factory DioDownloadException.from(DioException exception) => DioDownloadException(exception.message?? 'Unknown error with code ${exception.response?.statusCode}');
}

final class FileDownloadException extends DownloadException {
  const FileDownloadException(String message) : super(message);

  factory FileDownloadException.from(FileSystemException exception) => FileDownloadException(exception.message);
}

final class FirebaseDownloadException extends DownloadException {
  const FirebaseDownloadException(String message) : super(message);

  factory FirebaseDownloadException.from(FirebaseException exception) => FirebaseDownloadException(exception.message?? 'Unknown error with code ${exception.code}');
}