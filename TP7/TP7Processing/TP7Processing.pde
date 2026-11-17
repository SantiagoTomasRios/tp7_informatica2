import processing.serial.*;
Serial puerto;
String comando = "";

void setup(){
size(600,600);
printArray(Serial.list());
if(Serial.list().length>0){
String nPuerto = Serial.list()[0];
puerto = new Serial(this, nPuerto, 115200);
}
}

boolean boton1 = false;
boolean boton2 = false;
boolean led1 = false;
boolean led2= false;
boolean activarInterfaz = true;

void draw(){
background(0,0,0);
textAlign(CENTER);
rectMode(CENTER);
textSize(28);
dibujarPanel(width*0.5, height*0.5, width*0.9, height*0.9, "TP7 Informatica 2 entorno gráfico");
textSize(13);
if(!mousePressed && activarInterfaz){
 boton1=false;
 boton2=false;
}
dibujarPanel(width*0.5, height*0.35, width*0.75, height*0.33, "Entradas");
dibujarPanel(width*0.5, height*0.75, width*0.75, height*0.33, "Salidas");
dibujarBoton(width*0.33, height*0.35, width*0.15, "Boton 1", boton1);
dibujarBoton(width*0.66, height*0.35, width*0.15, "Boton 2", boton2);
dibujarBoton(width*0.33, height*0.75, width*0.15, "LED1", led1);
dibujarBoton(width*0.66, height*0.75, width*0.15, "LED2", led2);

if(puerto!=null){
if(puerto.available()>0){
 comando = puerto.readStringUntil('\n');
 if(comando != null){  
  print(comando);
  comando = trim(comando);
  if(comando.equals("Boton 1 pulsado")){
      activarInterfaz=false;
      boton1  = true; 
      led1=!led1;
      if (led1) {
      puerto.write("1"); 
      } else {
        puerto.write("0"); 
      }
    }else if(comando.equals("Boton 1 no pulsado")){
      activarInterfaz=true;
       boton1  = false;
     }else if(comando.equals("Boton 2 pulsado")){
       activarInterfaz=false;
        boton2 = true;
        led2=!led2;
        if (led2) {
        puerto.write("3"); 
      } else {
        puerto.write("2"); 
      }
     }else if(comando.equals("Boton 2 no pulsado")){
       activarInterfaz=true;
       boton2 = false;
     }
   }
  }
}
}

void dibujarPanel(float x, float y, float ancho, float alto, String informacion){
  stroke(255,255,255);
  fill(0,0,0);
  rect(x, y, ancho, alto, 20);
  fill(255,255,255);
  textAlign(CENTER);
  text(informacion, x,  y - alto *0.4);
}

void dibujarBoton(float x, float y, float diametro, String informacion, boolean estado){
 stroke(255,255,255);
 if(!estado){
 fill(0,0,0);
 circle(x+4, y+4, diametro);
 circle(x, y, diametro);
 textAlign(CENTER);
 fill(255,255,255);
 textSize(13);
 text(informacion, x, y);
 }else{
 fill(255,255,255);
 circle(x+4, y+4, diametro);
 textAlign(CENTER);
 fill(0,0,0);
 textSize(13);
 text(informacion, x+4, y+4);
 }
 fill(255,255,255);
}

void mousePressed(){
  if(dist(width*0.33, height*0.35, mouseX, mouseY)<width*0.075){
    led1 = !led1;
    boton1=true;
    if(puerto != null){
      if (led1) {
        puerto.write("1"); 
      } else {
        puerto.write("0"); 
      }
    }
  }
    if(dist(width*0.66, height*0.35, mouseX, mouseY)<width*0.075){
    led2 = !led2;
    boton2=true;
    if(puerto != null){
      if (led2) {
        puerto.write("3"); 
      } else {
        puerto.write("2"); 
      }
    }
   }
}
