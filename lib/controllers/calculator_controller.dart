
//Ya incluye todo lo que necesita el GetX
import 'package:get/get.dart';


//Extender de GetxController
class CalculatorController extends GetxController{

 /*
    Como extendemos de GetxController ahora tenemos ciclos de vida (cambios en las
    propiedades o variables). Los principal es que ahora podemos cambiar a observables
    nuestras propiedades. Los observables son parecidos a los stream.

    Debemos agregar el .obs (después del valor con el que las estamos inicializando) a las propiedades
    nuestra clase para indicar que ahora son observables, esto con el fin de poder redibujarlos.

    Normalmente para estos casos si se usa el var por simplicidad.

  */
  var firstNumber  = '10'.obs;
  var secondNumber = '20'.obs;
  var mathResult   = '30'.obs; //Es el número que la persona esta escribiendo
  var operation    = '+' .obs;

  void  resetAll(){

    /*Hay varias formas de actualizar el valor de la propiedad
    firstNumber = '0'.obs; //Crea un nuevo observable
    firstNumber.update((val) { });
    */

    firstNumber.value  = '0'; 
    secondNumber.value = '0'; 
    mathResult.value   = '0'; 
    operation.value    = '+'; 

  }

  changeNegativePositive(){

    //Si bien podriamos usarl .value.starsWith, GetX sabe que al final retorna un String
    //por ello podemos ahorranos el .value 
    if(mathResult.startsWith('-')){
        //Si empieza con - solo hay que removerlo
        mathResult.value = mathResult.value.replaceFirst('-', '');
    }else{
      //Agregar el -
      mathResult.value = '-' + mathResult.value;
    }

  }

  addNumber (String number){

    //Si el valor que tenia era 0, cambiar al número que se esta ingresando
    if(mathResult.value == '0')
       return mathResult.value = number;
    
    //Números negativos
    if(mathResult.value == '-0'){
        return mathResult.value = '-' + number;
    }

    //Si no es 0, entonces si concatenar los números
    mathResult.value = mathResult.value + number;

  }

  addDecimalPoint(){
    //Validar si ya tiene un punto
    if(mathResult.contains('.')) return;


    if(mathResult.startsWith('0')){
      mathResult.value = '0.';
    }else{
       mathResult.value = mathResult.value + ".";
    }

  }

  selectOperation (String newOperation){

    //Guardar la operación
    operation.value = newOperation;
    //Guardar el número
    firstNumber.value = mathResult.value;

    //Regresar a 0 para que se escriba el nuevo úmero
    mathResult.value = '0';

  }

  deleteLastEntry(){
    if(mathResult.value.replaceAll('-', '').length>1){
       //si es mas de 1 digito se quita uno
        mathResult.value = mathResult.value.substring(0,mathResult.value.length-1);
    }else{
      //Si solo hay un digito, se pone 0
      mathResult.value = '0';

    }
  }

  calculateResult(){

    //Tomar los String y cambiarlos a double
    double num1 = double.parse(firstNumber.value);
    //Es mathResult porque es el que el usuario esta escribiendo actualmente
    double num2 = double.parse(mathResult.value);

    //Agregar el segundo valor en pantalla ( para mantenerlo)
    secondNumber.value = mathResult.value;

    switch(operation.value){
      case '+':
            mathResult.value = '${num1 + num2}';
         break;
      case '-':
            mathResult.value = '${num1 - num2}';
         break;
      case 'X':
            mathResult.value = '${num1 * num2}';
         break;
      case '/':
            mathResult.value = '${num1 / num2}';
         break;
       default:
         return;                              
    }

    if(mathResult.value.endsWith('.0')){
      mathResult.value = mathResult.value.substring(0, mathResult.value.length-2);
    };


  }

}