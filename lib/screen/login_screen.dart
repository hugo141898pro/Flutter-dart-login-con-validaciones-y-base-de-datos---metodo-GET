import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_seccion/providers/usuraios_provider.dart';
import 'package:provider/provider.dart';


class login_screen extends StatelessWidget {
  const login_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 223, 53, 41),
                  Color.fromARGB(255, 221, 76, 66),
                ]), 
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: size.width * 0.42,
                    child: bloque(),
                  ),
                ],
              ),
            ),
            login(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView login(BuildContext context) {
    final usuariosProvider = Provider.of<Usuarios_Provider>(context);
    final txtEmail = TextEditingController();
    final txtPassword = TextEditingController();
    return SingleChildScrollView(
      child: Column(
              children: [
                SizedBox(height: 255,),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 30,
                        offset: Offset(0, 5)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text('Login', style: GoogleFonts.caveat(
                        textStyle: Theme.of(context).textTheme.headline3,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )),
                      SizedBox(height: 20),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                          TextFormField(
                            controller: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Gmail',
                              hintText: 'example@gmail.com',
                              prefixIcon: Icon(Icons.email_rounded),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 0, 0)
                                ),
                              )
                            ),
                            validator: (value) {
                              String pattern = 
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              return regex.hasMatch(value ?? '') ? null : 'ingresa un gmail valido';
                            },
                          ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: txtPassword,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '******',
                            prefixIcon: Icon(Icons.lock_clock_rounded),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 6) ? null : 'el dato debe ser mayor a 6';
                          },
                        ),                          
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        disabledTextColor: Colors.grey,
                        color: Color.fromARGB(255, 124, 22, 15),
                        child: Container(
                          child: Text('Enviar', style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(color: Colors.white),
                          )),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                        ),
                        onPressed: () {
                          var usuarios = usuariosProvider.usuarios; 
                          if(usuarios.where((element) => element.email == txtEmail.text).length > 0 
                          &&
                          usuarios.where((element) => element.username == txtPassword.text).length > 0
                          ){
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return(
                                  AlertDialog(
                                    title: Text('Error al iniciar sección'),
                                    content: Text('Tus credenciales son incorrecta'),
                                    actions: [
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )
                                );
                              }
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  SafeArea bloque() {
    return SafeArea(
      child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(129, 124, 22, 15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: Icon(Icons.person_pin, color: Colors.white, size: 70,),
                      ),
                    ),
    );
  }
}