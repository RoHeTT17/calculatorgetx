import 'package:calculadora/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_result.dart';
import 'line_separator.dart';
import 'sub_result.dart';


class MathResult extends StatelessWidget {
   
    MathResult({Key? key}) : super(key: key);

    //Obtener la instancia del usuarioController. Aquí es find
    final calculatorCtrl = Get.find<CalculatorController>();


  //El Obx pide un builder y todos los builders deben regresar un widget. Es lo que nos permite
  //redibujar. Cada que algo cambie será el que se redibuje.
  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Column(
                              children: [
                                          SubResult( text: '${calculatorCtrl.firstNumber}' ),
                                          SubResult( text: '${calculatorCtrl.operation}' ),
                                          SubResult( text: '${calculatorCtrl.secondNumber}' ),
                                          LineSeparator(),
                                          MainResultText( text: '${calculatorCtrl.mathResult}' ),
                                        ],
                            )
    );
  }
}