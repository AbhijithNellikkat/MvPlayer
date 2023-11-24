import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/constants/constants.dart';

void toastMessageWidget({
  required String message,
  required ToastGravity gravity,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: Constants.black,
    textColor: Constants.white,
    fontSize: 13.0,
  );
}
