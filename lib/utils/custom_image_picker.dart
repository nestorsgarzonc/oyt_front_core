import 'package:image_picker/image_picker.dart';
import 'package:oyt_front_core/logger/logger.dart';

class CustomImagePicker {
  static final picker = ImagePicker();

  static Future<XFile?> pickImage() async {
    try {
      return await picker
          .pickImage(source: ImageSource.gallery)
          .timeout(const Duration(seconds: 40));
    } catch (e, s) {
      Logger.logError(e.toString(), s);
      rethrow;
    }
  }

  static Future<XFile?> pickVideo() async {
    return await picker.pickVideo(source: ImageSource.gallery);
  }
}
