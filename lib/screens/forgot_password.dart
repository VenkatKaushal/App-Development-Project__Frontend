import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
   const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
    @override
    Widget build(BuildContext context){

       const   border =  OutlineInputBorder(
        borderRadius:  BorderRadius.all(Radius.circular(10)),
        borderSide:   BorderSide(
          width: 2.0,
          style: BorderStyle.solid,
        ),
      );

      return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFB0BEC5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            debugPrint('Back is pressed');
          },
          color: const Color.fromARGB(255, 11, 106, 14),
        ),
        title: const Text(
          'NutriGuide',
          style: TextStyle(
            color: Color.fromARGB(255, 11, 106, 14),
          ),
        ),
          centerTitle: true,
        ),


          body : SingleChildScrollView(
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  Text(result.toString(),
                  // style: const  TextStyle(
                  //     fontSize: 35,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  // ),
                  //  ),
            
            
                  Image.asset("assets/forgot_password.png"),
            
                  Container(
                    padding: const  EdgeInsets.all(8.0),
                    child: const  TextField(     
                      style:  TextStyle(
                        color: Colors.black , 
                      ),
                      decoration:  InputDecoration(
                        hintText:'Enter your UserId',
                        hintStyle:  TextStyle(
                          color:Colors.black
                        ),
                        prefixIcon:  Icon(Icons.mail),
                        prefixIconColor: Colors.black,
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: border,
                        enabledBorder: border,
                        ),
                        
                      keyboardType: TextInputType.text,
                    ),
                  ),
            
                   Container(
                    padding: const EdgeInsets.all(8.0) ,
                     child: TextButton(
                      onPressed: () {
                        
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:Colors.purple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                       child: const  Text('Click here to Forgot'),
                       
                       ),
                   )
            
            
            
                ],
                ),
                 ),
          ), 
        );
    }
} 