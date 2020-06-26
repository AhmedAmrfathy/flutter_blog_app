import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  BuildContext context;

  editcontext(BuildContext buildContext) {
    context = buildContext;
  }
}
