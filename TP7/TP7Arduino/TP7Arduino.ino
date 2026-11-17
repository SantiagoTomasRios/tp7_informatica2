const int boton1Pin = 0; 
const int led1Pin = 2;
const int boton2Pin = 5; 
const int led2Pin = 4;
int estadoAnterior1 = HIGH;
int estadoAnterior2 = HIGH;

void setup() {
  Serial.begin(115200);
  pinMode(boton1Pin, INPUT_PULLUP);
  pinMode(boton2Pin, INPUT_PULLUP);
  pinMode(led1Pin, OUTPUT);
  pinMode(led2Pin, OUTPUT);
  digitalWrite(led1Pin, LOW);
  digitalWrite(led2Pin, LOW);
  delay(1000);
  Serial.println("\nEsp listo: ");
}

void loop() {
  int estadoActual1 = digitalRead(boton1Pin);
  if (estadoAnterior1 != estadoActual1){
    if(estadoActual1 == LOW){
      Serial.println("Boton 1 pulsado");
    } else{
      Serial.println("Boton 1 no pulsado");
      Serial.println("LED 1 apagado");
    }
    delay(50);
    estadoAnterior1 = estadoActual1; 
  }
   int estadoActual2 = digitalRead(boton2Pin);
 if (estadoAnterior2 != estadoActual2){
    if(estadoActual2 == LOW){
      Serial.println("Boton 2 pulsado");
    } else{
     Serial.println("Boton 2 no pulsado");
     Serial.println("LED 2 apagado");
    }
    delay(50);
    estadoAnterior2 = estadoActual2; 
  }
 

  if(Serial.available()>0){
    char comando = Serial.read();
    if(comando == '\n' || comando == '\r') return;
    if(comando == '1'){
      digitalWrite(led1Pin, HIGH);
      Serial.println("LED 1 encendido");
    }else if(comando == '0'){
      digitalWrite(led1Pin, LOW);
      Serial.println("LED 1 apagado");
    } else if(comando == '3'){
      digitalWrite(led2Pin, HIGH);
      Serial.println("LED 2 encendido");
    }else if(comando == '2'){
      digitalWrite(led2Pin, LOW);
      Serial.println("LED 2 apagado");
    } 
  }
}
