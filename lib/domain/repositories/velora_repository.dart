
abstract class VeloraRepository {

  Future<String> getResponse(String prompt);
  Stream<String> getStreamResponse(String prompt);

}
