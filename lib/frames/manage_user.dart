import 'package:flutter/material.dart';
import 'package:romberg_test/models/user_model.dart';
import 'package:romberg_test/widgets/manager_user_form.dart';

// ignore: must_be_immutable
class ManageUser extends StatefulWidget {
  UserModel? user;
  ManageUser({Key? key, this.user});

  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  TextEditingController nameUser = TextEditingController();
  TextEditingController weightUser = TextEditingController();
  TextEditingController heightUser = TextEditingController();
  TextEditingController ageUser = TextEditingController();
  bool act = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ModalRoute.of(context)!.settings.arguments as UserModel?;
    if (!user!.generic) {
      nameUser.value = TextEditingValue(text: user.name!);
      weightUser.value = TextEditingValue(text: user.weight.toString());
      heightUser.value = TextEditingValue(text: user.height!.toString());
      ageUser.value = TextEditingValue(text: user.age!.toString());
      act = true;
    }

    return Scaffold(
        appBar: AppBar(),
        body: manageUserForm(
            nameUser, weightUser, heightUser, ageUser, context, act));
  }
}
