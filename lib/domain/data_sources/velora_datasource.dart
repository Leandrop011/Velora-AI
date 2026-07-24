
abstract class VeloraDatasource {
  
  Future<String> getResponse(String prompt);
  Stream<String> getStreamResponse(String prompt);

}
