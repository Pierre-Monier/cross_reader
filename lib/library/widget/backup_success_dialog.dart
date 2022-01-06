import "package:flutter/material.dart";

/// Custom dialog to show when the backup is done
class BackupSuccessDialog extends StatelessWidget {
  /// Custom dialog to show when the backup is done
  const BackupSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Backup"),
      content: Text("Backup success"),
    );
  }
}
