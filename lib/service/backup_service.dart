import 'dart:io';

class BackupService {
  final Directory _cacheDirectory;
  final bool shouldMock;
  const BackupService(this._cacheDirectory, {this.shouldMock = false});

  static const backupDirName = 'backup/';
  static const mangasJsonFileName = 'mangas.json';

  Future<BackupFiles> getBackupFiles() async {
    final backupDirectory = Directory('${_cacheDirectory.path}/$backupDirName');
    final mangasJsonFile = File('${backupDirectory.path}/$mangasJsonFileName');

    if (!shouldMock) {
      await backupDirectory.create();
      await mangasJsonFile.create();
    }

    return BackupFiles(backupDirectory, mangasJsonFile);
  }
}

class BackupFiles {
  final Directory _backupDirectory;
  final File _mangasJsonFile;

  const BackupFiles(this._backupDirectory, this._mangasJsonFile);

  File get mangasJsonFile => _mangasJsonFile;
  Directory get backupDirectory => _backupDirectory;
}
