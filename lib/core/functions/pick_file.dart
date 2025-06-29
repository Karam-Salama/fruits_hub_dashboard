import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickImage() async {
  return await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
    withData: true,
  );
}
