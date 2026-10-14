import 'package:streetbite/core/errors/error_kind.dart';

class Failure implements Exception {
  const Failure(this.kind);

  final ErrorKind kind;
}
