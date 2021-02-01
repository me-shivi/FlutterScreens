import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginForm extends RouterWidget {
  @override
  _LoginFormState createState() => _LoginFormState();

  @override
  RouterData initRouter(Map<String, dynamic> data) {
    return null;
  }
}

class _LoginFormState extends RouterState<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool forgotPassword = false;

  Widget loginTextField({
    String label,
    TextEditingController controller,
    bool obscureText: false,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: (x) {
        tryLogin();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        labelStyle: StyledText().h6.blue.style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UC.init(context);
    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(children: [
        Box(
          theme: BoxTheme().frame,
          child: new Form(
            key: _formKey,
            child: IgnorePointer(
                ignoring: isLoading,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 700),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.asset("assets/images/uCertify_Logo.png"),
                        ),
                        ...(!forgotPassword
                            ? [
                                Box(
                                  theme: BoxTheme().frame,
                                  child: loginTextField(
                                    label: 'Email address',
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                  ),
                                ),
                                Box(
                                  theme: BoxTheme().frame,
                                  child: loginTextField(
                                    label: 'Password',
                                    controller: passwordController,
                                    obscureText: true,
                                    validator: (value) => value.length == 0
                                        ? "Enter a valid password"
                                        : null,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    textColor: Colors.white,
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.all(10),
                                    elevation: 0,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .fontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {},
                                  textColor: Colors.red,
                                  child: Text(
                                    "Forget Password",
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .fontSize,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black38,
                                  height: 40,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  child: RaisedButton.icon(
                                    onPressed: () {
                                      socialLogin();
                                    },
                                    textColor: Colors.white,
                                    color: Colors.redAccent,
                                    padding: EdgeInsets.all(10),
                                    elevation: 0,
                                    icon: Icon(
                                      UCIcons.icomoon_google,
                                      size: 24,
                                    ),
                                    label: Text(
                                      "Sign in with Google",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .fontSize,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DevConfig.isIOS
                                      ? SignInWithAppleButton(
                                          onPressed: () {
                                            socialLogin(true);
                                          },
                                          height: 50,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        )
                                      : nullWidget,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    UC.pushScene(UCRoutes.SIGNUP);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Don't have an account?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        children: [
                                          TextSpan(
                                            text: " Sign Up",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                ),
                              ]
                            : forgotPasswordBox()),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),),
          ),
        ),
    );
  }
}
