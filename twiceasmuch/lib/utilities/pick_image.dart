import 'package:image_picker/image_picker.dart';

class PickImage {
  final picker = ImagePicker();

  Future<XFile?> pickImageFromCamera() async {
    try {
      final photo = await picker.pickImage(source: ImageSource.camera);

      return photo;
    } catch (e) {
      return null;
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final photo = await picker.pickImage(source: ImageSource.gallery);
      return photo;
    } catch (e) {
      return null;
    }
  }
}
