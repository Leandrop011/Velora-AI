
import 'package:image_picker/image_picker.dart';

import '../domain.dart';


abstract class VeloraRepository {

  Future<String> getResponse(String prompt);
  Stream<String> getStreamResponse(String prompt, {List<XFile> files = const[]});
  Stream<String> getChatStreamResponse(
    String prompt, 
    String chatId, 
    {List<XFile> files = const[]}
  );
  Future<List<Message>> getMessagesChatById( String chatId );
}
