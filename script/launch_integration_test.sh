#!/bin/bash
# Run the integration tests.with flutter drive because integration_test is not that great
if ! command -v adb &> /dev/null
then
    echo "adb could not be found"
    exit
fi

adb shell pm grant com.example.cross_reader android.permission.READ_EXTERNAL_STORAGE
flutter drive \
  --driver=integration_test/driver.dart \
  --target=integration_test/cross_reader_app_test.dart