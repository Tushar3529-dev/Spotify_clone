import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/appbar/app_bar.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';
import 'package:spotify/domain/usecase/auth/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _sigupText(context),
        appBar: BasicAppBar(
          title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "If You Need Any Support !",
                      style: TextStyle(color: AppColors.grey, fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ).copyWith(
                            overlayColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                      child: Text(
                        "Click Here",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                _emailField(context),
                const SizedBox(height: 20),

                _passwordField(context),
                const SizedBox(height: 5),
                _recoveryPassword(context),

                const SizedBox(height: 20),
                BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SigninUsecase>().call(
                      params: SigninUserRequest(
                        email: _emailController.text.toString(),
                        password: _passwordController.text.toString(),
                      ),
                    );
                    result.fold(
                      (l) {
                        var snackbar = SnackBar(
                          content: Text(l),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        Future.delayed(Duration(milliseconds: 2));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    );
                  },
                  title: "Sign In",
                ),
                const SizedBox(height: 15),
                _linesorlines(context),
                const SizedBox(height: 15),
                _thirdPartyLogin(context),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return Text(
      'Log In',
      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "Enter Username Or Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: " Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _linesorlines(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 1,
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          "Or",
          style: TextStyle(
            fontSize: 15,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 1,
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _thirdPartyLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: GestureDetector(
            onTap: () {
              print("Pressed Google Logo");
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: SvgPicture.asset(
                AppVectors.googleLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        ClipOval(
          child: GestureDetector(
            onTap: () {
              print("Pressed Apple Logo");
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: SvgPicture.asset(
                context.isDarkMode
                    ? AppVectors.appleLogoDark
                    : AppVectors.appleLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sigupText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Not A Member ?",
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: Text(
            "Register Now",
            style: TextStyle(color: Color(0xff288CE9), fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _recoveryPassword(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Recovery Password",
          style: TextStyle(
            color: context.isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
