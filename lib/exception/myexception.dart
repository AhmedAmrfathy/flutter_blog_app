class myException implements Exception{
  final String messege;

  myException(this.messege);

  @override
  String toString() {
    return messege;
  }


}