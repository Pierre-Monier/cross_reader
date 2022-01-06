import "package:flutter/material.dart";

/// Custom dialog to show when the backup is processing
class BackupLoadingDialog extends StatelessWidget {
  /// Custom dialog to show when the backup is processing
  const BackupLoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Backup"),
      content: Text("Processing library backup..."),
    );
  }
}
