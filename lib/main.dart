
import 'package:colors_balls/theme/letter.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(220, 153, 73,1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Premios araiza'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numeroAleatorio = 0;
  int _counter = 0;
  int nTimes = 5;
  String linkButton = 'assets/images/button_balls-on.png';
  String linkBall = 'assets/images/button_balls-on.png';

  void changeImageDown(any) {
    setState(() {
      linkButton = 'assets/images/button_balls-off.png';
    });
  }

  void changeImageTop(any) {
    _counter++;
    numeroAleatorio = Random().nextInt(3) + 1;
    bool whiteBall = false; 

    if (nTimes == 0) {
      switch (numeroAleatorio) {
          case 1:
            linkBall = 'assets/balls/green_ball.svg';
            break;
          case 2:
            linkBall = 'assets/balls/blue_ball.svg';
            break;
          case 3:
            linkBall = 'assets/balls/red_ball.svg';
            break;
          default:
        }
    } else {
      if(0 == _counter % nTimes){
        whiteBall = true;
      }else{
        switch (numeroAleatorio) {
          case 1:
            linkBall = 'assets/balls/green_ball.svg';
            break;
          case 2:
            linkBall = 'assets/balls/blue_ball.svg';
            break;
          case 3:
            linkBall = 'assets/balls/red_ball.svg';
            break;
          default:
        }
      }
    }
    setState(() { });
    showDialog(
    context: context, // Accede al contexto del widget actual
    builder: (BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
      return AlertDialog(
        title:  Text('¡Felicidades!', textAlign: TextAlign.center, style: getTextStyleTitle(context,Colors.black),),
        content:  
        SizedBox(
          height: height < 960 && width <900  ?
                  //para celulares
                  MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .4 : .6):
                  //para tablets
                  MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .6 : .6),
                width: height < 960 && width <900  ?
                  //para celulares
                  MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .6 : 6):
                  //para tablets
                  MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .8 : .6),
          child: SvgPicture.asset(
                whiteBall ? 'assets/balls/white_ball.svg' : linkBall,
                height: height < 960 && width <900  ?
                  //para celulares
                  MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .2 : .4):
                  //para tablets
                  MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .4 : .4),
                width: height < 960 && width <900  ?
                  //para celulares
                  MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .4 : .4):
                  //para tablets
                  MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .6 : .4),
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: Text('Cerrar', style: getTextStyleButtonField(context)),
          ),
        ],
      );
    });
    setState(() {
      linkButton = 'assets/images/button_balls-on.png';
    });
  }

  void changeImageTopFalse(any) {
    setState(() {
      linkButton = 'assets/images/button_balls-on.png';
    });
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: 
        Row(
            children: [
              SvgPicture.asset('assets/images/logo.svg',height: (height * (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
              (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.1)
              : 
              (MediaQuery.of(context).orientation == Orientation.portrait ? .04: .06))

              )),
              const SizedBox(width: 8),  // Espacio entre el logo y el título
              Text('Premios Araiza', style: getTextStyleTitleHome(context, Colors.white).copyWith()),  // Título de la aplicación
            ],
          ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(onPressed: (){
            showDialog(
            context: context, // Accede al contexto del widget actual
            builder: (BuildContext context) {
              return AlertDialog(
                title:  Text('Ajustes', style: getTextStyleTitle(context,Colors.black),),
                content:  SizedBox(
                  height: 
                  MediaQuery.of(context).orientation == Orientation.portrait ?
                  MediaQuery.of(context).size.height * .15 :
                  MediaQuery.of(context).size.height * .2,
                  child: Column(
                    children: [
                      Text('La pelota blanca sale cada : $nTimes turno(s)', style:getTextStyleText(context,null,null)),
                      TextFormField(
                        textAlign: TextAlign.center,
                        style:getTextStyleText(context,null,null),
                        initialValue: nTimes.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (isNumeric(value)) {
                            nTimes = int.parse(value);
                          }
                        },
                        validator: (value) {
                          if (isNumeric(value) ==false ) {
                            return "Solo números";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cerrar', style: getTextStyleButtonField(context)))
                ],
              );
            });
          }, icon: Icon(Icons.settings, size: height < 960 && width < 900  ?
        //para celulares
          MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08 : .05):
        //para tablets
        MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08 : .05),)),
        ],
        toolbarHeight: 
         height < 960 && width <900  ?
        //para celulares
          MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .15 : .07):
        //para tablets
        MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .1 : .07),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: changeImageDown,
              onTapUp: changeImageTop,
              // onLongPressEnd: changeImageTopFalse,
              child: Image.asset(
                linkButton,
                height: 
                 height < 960 && width <900  ?
                //para celulares
                  MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .2 : .4):
                //para tablets
                MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .2 : .35),
              ),
            )
          ],
        ),
      ),
      
    );
  }

  bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
  }
}
