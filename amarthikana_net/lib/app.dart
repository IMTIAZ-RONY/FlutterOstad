
import 'package:amarthikana_net/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AmarThikanaApp extends StatelessWidget {
  const AmarThikanaApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"AmarThikana" ,
      theme:ThemeData(
        brightness:Brightness.light ,

        primarySwatch:Colors.green ,
        textTheme:const TextTheme(
          titleLarge: TextStyle(
              color: Colors.black,
               fontSize: 24,
               fontWeight: FontWeight.w600,
          letterSpacing:0.6 ),

        ) ,
        inputDecorationTheme:const InputDecorationTheme(
            filled:true,
            fillColor:Colors.white,
            contentPadding:EdgeInsets.symmetric(horizontal:24,vertical: 14 ),
            border:OutlineInputBorder(
              borderSide:BorderSide.none,
            )
        ),
        elevatedButtonTheme:ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical:10 ),
              elevation: 4,
              shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0), )),

      ) ,),
      darkTheme:ThemeData(
        brightness:Brightness.dark,

        primarySwatch:Colors.blue ,
        textTheme:const TextTheme(
          titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing:0.6 ),

        ) ,
        inputDecorationTheme:const InputDecorationTheme(
            filled:true,
            fillColor:Colors.white,
            contentPadding:EdgeInsets.symmetric(horizontal:24,vertical: 14 ),
            border:OutlineInputBorder(
              borderSide:BorderSide.none,
            )
        ),
        elevatedButtonTheme:ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical:10 ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), )),

        ) ,
      ) ,
      themeMode:ThemeMode.light ,
      home:SplashScreen() ,
    );

  }
}