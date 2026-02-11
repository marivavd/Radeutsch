import 'package:deutscht/domain/use_case_sign_in.dart';
import 'package:deutscht/presentation/pages/main_page.dart';
import 'package:deutscht/presentation/pages/sign_up_page.dart';
import 'package:deutscht/presentation/utils/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool isValid = false;
  bool isObscurePass = false;
  SignInUseCase useCase = SignInUseCase();



  void onChange(_){
    setState(() {
      isValid = email.text.isNotEmpty && password.text.isNotEmpty;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 78,),
              Text(
                "Welcome back",
                style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(height: 40,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                      'Email'
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    height: 44,
                    child: TextField(
                        controller: email,
                        onChanged: onChange,
                        style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 14, height: 16/14, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: "username@mail.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.blue),),
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        )
                    ),

                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                      'Password'
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    height: 44,
                    child: TextField(
                        controller: password,
                        onChanged: onChange,
                        obscureText: (!isObscurePass)?true:false,
                        obscuringCharacter: '*',
                        style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 14, height: 16/14, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            hintText: "********",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.blue),),
                            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            suffixIconConstraints: const BoxConstraints(minWidth: 34),
                            suffixIcon:
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isObscurePass = !isObscurePass;
                                });
                              },
                              child: SvgPicture.asset(
                                (!isObscurePass)
                                    ? "assets/eye.svg"
                                    : 'assets/eye-slash.svg',
                                color: Colors.grey,
                                //colorFilter: ColorFilter.mode(colors.x141414, BlendMode.color)
                              ),
                            )

                        )
                    ),

                  ),
                ],
              ),
              SizedBox(height: 100,),
              Align(
                alignment: AlignmentGeometry.center,
                child: SizedBox(
                  height: 46,
                  width: double.infinity,
                  child: FilledButton(

                      onPressed: (isValid)?()async{
                        showLoading(context);
                        useCase.pressButtonSignIn
                          (
                            email.text,
                            password.text,
                                (_){
                              hideLoading(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())).then((value) => setState(() {}));
                            },
                                (String e)async{
                              hideLoading(context);
                              showError(context, e);

                            });

                      }:null,
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),
                      child: Text(
                          "Sign In"
                      )),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Do you have not an account yet? '
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())).then((value) => setState(() {

                      }));

                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xFF0560FA)),
                    ),
                  )


                ],
              ),
              SizedBox(height: 34,),

            ],
          ),

        ),
      ),
    );
  }
}
