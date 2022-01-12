import "package:share_plus/share_plus.dart";

/// Service use to share files
class ShareService {
  /// share a file
  Future<void> shareFile(String filepath) {
    return Share.shareFiles([filepath]);
  }
}
