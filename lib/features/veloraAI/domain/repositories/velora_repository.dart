
import 'package:image_picker/image_picker.dart';

abstract class VeloraRepository {

  Future<String> getResponse(String prompt);
  Stream<String> getStreamResponse(String prompt, {List<XFile> files = const[]});

}
