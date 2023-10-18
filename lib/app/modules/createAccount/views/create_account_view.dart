import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/styles/text_styles.dart';
import 'package:mv_player/widgets/custom_button_widget.dart';
import 'package:mv_player/widgets/custom_textFormField.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({Key? key}) : super(key: key);
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
                      Constants.createAccountHeading,
                      style: createAccountHeading,
                    ),
                    Constants.firstTextFormFieldAndHeadingVerticalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Username'),
                        Constants.formInputFieldAndLabelVerticalSpace,
                        CustomTextFormFieldWidget(hintText: 'username'),
                      ],
                    ),
                    Constants.formTextFormFieldVerticalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email'),
                        Constants.formInputFieldAndLabelVerticalSpace,
                        CustomTextFormFieldWidget(hintText: 'email'),
                      ],
                    ),
                    Constants.formTextFormFieldVerticalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password'),
                        Constants.formInputFieldAndLabelVerticalSpace,
                        CustomTextFormFieldWidget(
                          hintText: 'password',
                          obscureText: true,
                          suffixIcon: Icons.visibility_outlined,
                        ),
                      ],
                    ),
                    Constants.textFormFieldAndButtonVerticalSpace,
                    CustomButtonWidget(
                      borderWidth: 0,
                      bgColor: Colors.black,
                      textColor: Colors.white,
                      text: 'Create Account',
                      onTap: () {
                        Get.toNamed(Routes.HOME);
                      },
                    ),
                    Constants.buttonAndLoginTextVerticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Already have an account ?',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                          child: const Text(
                            'Log in',
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
