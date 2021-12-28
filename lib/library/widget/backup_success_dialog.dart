import 'package:flutter/material.dart';

class BackupSuccessDialog extends StatelessWidget {
  const BackupSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Backup"),
      content: Text("Backup success"),
    );
  }
}
