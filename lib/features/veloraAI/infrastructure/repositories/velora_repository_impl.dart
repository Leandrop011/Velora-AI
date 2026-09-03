
import 'package:gemini_app/features/veloraAI/domain/data_sources/velora_datasource.dart';
import 'package:gemini_app/features/veloraAI/domain/repositories/velora_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/domain.dart';

class VeloraRepositoryImpl extends VeloraRepository {
  
  final VeloraDatasource datasource;

  VeloraRepositoryImpl({required this.datasource});
  
  @override
  Future<String> getResponse(String prompt) {
    return datasource.getResponse(prompt);
  }
  
  @override
  Stream<String> getStreamResponse(String prompt, {List<XFile> files = const[]}) {
    return datasource.getStreamResponse(prompt, files: files);
  }

  @override
  Stream<String> getChatStreamResponse(String prompt, String chatId, {List<XFile> files = const []}) {
    return datasource.getChatStreamResponse(prompt, chatId, files: files);
  }

  @override
  Future<List<Message>> getMessagesChatById(String chatId) {
    return datasource.getMessagesChatById( chatId );
  }
  
}
