import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_button_widget.dart';
import '../../../../widgets/custom_textFormField.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Form(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Constants.loginHeading,
                      style: loginHeading,
                    ),
                    Constants.firstTextFormFieldAndHeadingVerticalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email address'),
                        Constants.formInputFieldAndLabelVerticalSpace,
                        CustomTextFormFieldWidget(hintText: 'email'),
                      ],
                    ),
                    Constants.formTextFormFieldVerticalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Password'),
                        Constants.formInputFieldAndLabelVerticalSpace,
                        CustomTextFormFieldWidget(
                          hintText: 'password',
                          obscureText: true,
                          suffixIcon: Icons.visibility_off_outlined,
                        ),
                      ],
                    ),
                    Constants.passwordTffAndForgotPassVerticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const Text(
                          'Forgot Password ? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                        Constants.passwordTffAndForgotPassVerticalSpace,
                        CustomButtonWidget(
                          borderWidth: 0,
                          bgColor: Colors.black,
                          textColor: Colors.white,
                          text: 'Log in ',
                          onTap: () {
                            Get.offAllNamed(Routes.BOTTOMNAVIGATIONBAR);
                          },
                        ),
                      ],
                    ),
                    Constants.buttonAndLoginTextVerticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.CREATE_ACCOUNT);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
