import 'package:image_picker/image_picker.dart';

class ImagePickerMethods {
  final imagePicker = ImagePicker();
  Future<XFile?> selectPicture() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      return null;
    }
  }
}
