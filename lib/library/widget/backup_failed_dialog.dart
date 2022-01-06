import "package:flutter/material.dart";

/// Custom dialog to show when backup fails
class BackupFailedDialog extends StatelessWidget {
  /// Custom dialog to show when backup fails
  const BackupFailedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Backup"),
      content: Text("Backup failed"),
    );
  }
}
