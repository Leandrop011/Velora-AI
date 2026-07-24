
import 'package:gemini_app/domain/data_sources/velora_datasource.dart';
import 'package:gemini_app/domain/repositories/velora_repository.dart';

class VeloraRepositoryImpl extends VeloraRepository {
  
  final VeloraDatasource datasource;

  VeloraRepositoryImpl({required this.datasource});
  
  @override
  Future<String> getResponse(String prompt) {
    return datasource.getResponse(prompt);
  }
  
  @override
  Stream<String> getStreamResponse(String prompt) {
    return datasource.getStreamResponse(prompt);
  }
  
}
