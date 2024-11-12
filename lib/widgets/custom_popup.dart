
import 'package:flutter/material.dart';

Future<void> showCustomPopup({
  required BuildContext context,
  required String titleText,
  required String text,
  required String buttonConfirmText,
  required String buttonCancelText,
})async{
  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          width: 350,
          height: 170,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,20,12, 12),
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      titleText,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFA726),
                              Color(0xFFFFD466), 
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed:  (){},
                          child: Text(
                            buttonConfirmText,
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 175, 175, 175), width: 1),
                          color: const Color.fromARGB(255, 230, 230, 230),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed:  (){ Navigator.pop(context);},
                          child: Text(
                            buttonCancelText,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              ),
            ),
          ),
        ),
      );
    }
  );
} 