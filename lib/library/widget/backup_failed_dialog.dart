import 'package:flutter/material.dart';

class BackupFailedDialog extends StatelessWidget {
  const BackupFailedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Backup"),
      content: Text("Backup failed"),
    );
  }
}
