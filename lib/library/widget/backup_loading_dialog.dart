import 'package:flutter/material.dart';

class BackupLoadingDialog extends StatelessWidget {
  const BackupLoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Backup'),
      content: Text('Processing library backup...'),
    );
  }
}
