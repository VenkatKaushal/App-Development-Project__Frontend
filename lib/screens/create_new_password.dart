import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
   const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPassword();
}

class _CreateNewPassword extends State<CreateNewPassword> {

  bool obt = true;
  bool obt2 =true;
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
                    child:  TextField(   
                        
                      style: const TextStyle(
                        color: Colors.black , 
                      ),
                      obscureText: obt,
                      decoration:  InputDecoration(
                        hintText:'Enter Your New Password ',
                        hintStyle: const TextStyle(
                          color:Colors.black
                        ),
                        prefixIcon:  const Icon(Icons.password_sharp),
                        prefixIconColor: Colors.black,
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            obt =! obt;
                          });
                        }, icon: const Icon(Icons.remove_red_eye)),
                        suffixIconColor: Colors.black,
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: border,
                        enabledBorder: border,
                        ),
                        
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),

                  Container(
                    padding: const  EdgeInsets.all(8.0),
                    child:  TextField(   
                        
                      style: const TextStyle(
                        color: Colors.black , 
                      ),
                      obscureText: obt2,
                      decoration:  InputDecoration(
                        hintText:'Confirm password ',
                        hintStyle: const TextStyle(
                          color:Colors.black
                        ),
                        prefixIcon:  const Icon(Icons.password_sharp),
                        prefixIconColor: Colors.black,
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            obt2 =! obt2;
                          });
                        }, icon: const Icon(Icons.remove_red_eye)),
                        suffixIconColor: Colors.black,
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: border,
                        enabledBorder: border,
                        ),
                        
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                    
                   Container(
                    padding: const EdgeInsets.all(8.0) ,
                     child: TextButton(
                      onPressed: () {
                        debugPrint('CreateNew password pressed');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFB0BEC5),
                        foregroundColor:  const Color.fromARGB(255, 11, 106, 14),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                       child: const  Text('Update Password'),
                       
                       ),
                   )
            
            
            
                ],
                ),
                 ),
          ), 
        );
    }
} 