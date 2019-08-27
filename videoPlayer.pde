import processing.video.*;

Movie myMovie;
PImage[] thumbNails;

int tracker = 200;
float dragRate = 2.1768707483;  //***************
float jumpRate;
int mouseX_value;
int th_count;
//SWITCHES
boolean pausePressed = false;
boolean overBar = false;
boolean isDragging = false;

void setup() {
  size(640, 480, P3D);
  myMovie = new Movie(this, "Messi.mp4");
  //lines = loadStrings("subs.txt");
  thumbNails = new PImage[839];
  for (int i = 0; i < 839; i++) {
    String filename = "messi-" + i + ".png"; 
    thumbNails[i] = loadImage(filename);
    System.out.println(i);
  }
  myMovie.loop();
  //jumpRate = myMovie.duration() / 58.8;
}

void movieEvent(Movie m) {
  m.read();
}

void mouseMoved() {
  tracker = 200;
}

void mouseReleased() {
  if (isDragging)
    myMovie.jump(mouseX * 0.459375);  //***************//***************
  isDragging = false;  
  if (pausePressed) 
    myMovie.pause();
  else myMovie.play();
}
void mouseDragged() {  
  tracker = 200;  
  if (overBar) {
    isDragging = true;
  } 
  if (isDragging) 
    myMovie.pause();
  else myMovie.play();
}
void mousePressed() {  
  tracker = 200;  
  if (!isDragging && overBar) {
    myMovie.jump(mouseX * 0.459375);  //***************//***************
  }
  if ((mouseY < (height - height/10) - 5) || (mouseX > 10 && mouseX < 25 && mouseY < height - 10 && mouseY > (height - 10) - (height / 25))) {
    pausePressed = !pausePressed;
  }
}

void keyPressed() {
  switch(keyCode) {

  case 32: //SpaceBar
    tracker = 200;
    pausePressed = !pausePressed;
    break;
  //case RIGHT:
  //  tracker = 200;
  //  myMovie.jump(myMovie.time() + jumpRate);
  //  break;

  //case LEFT:
  //  tracker = 200;
  //  myMovie.jump(myMovie.time() - jumpRate);
  //  break;
  }

  if (pausePressed) {
    myMovie.pause();
  } else {
    myMovie.play();
  }
}
//TIMERATE * DURATION = X 

void draw() {  
  mouseX_value = mouseX;
  th_count = (int)(mouseX * 1.3109375); //1124 / 1280 
  if (th_count > 839) 
    th_count = 839;
  else if (th_count < 0) 
    th_count = 0;
  if (thumbNails[th_count] != null)
    if (mouseX_value > 583) mouseX_value = 583; //screenwidth - imagewidth/2  //***************//***************
  if (mouseX_value < 57) 
    mouseX_value = 57; //screenwidth - imagewidth/2   //***************//***************
  if (!isDragging) {
    image(myMovie, 0, 0);
  } else {
    image(thumbNails[th_count], 0, 0, width, height - height/10);
  }
  if (tracker > 0) {
    stroke(210);
    strokeWeight(3);
    line(0, height - height/10, width, height - height/10);
    stroke(255, 0, 0);
    if (!isDragging) {
      line(0, height - height/10, myMovie.time() * dragRate, height - height/10);
    } else {
      line(0, height - height/10, mouseX, height - height/10);
    }
    if (mouseY < (height - height/10) + 5 && mouseY > height - height/10 - 5)
    {
      if (!isDragging) {
        fill(255, 0, 0);
        ellipse(myMovie.time() * dragRate, height - height/10, 10, 10);
      } 
      //This is the part causing the problem
      else ellipse(mouseX, height - height/10, 10, 10);  
      image(thumbNails[th_count], mouseX_value, (height - height/10)-thumbNails[th_count].height/10, thumbNails[th_count].width/10, thumbNails[th_count].height/10);

      overBar = true;
    } else {
      overBar = false;
    }
    if (pausePressed) 
    { 
      fill(255);
      noStroke();
      triangle(10, height - 10, 10, (height - 10) - (height / 25), 22, (height - 10) - (height / 50)); // Triangle
    } else
    {
      fill(255);
      noStroke();
      rectMode(CORNER);
      rect(10, (height - 10) - (height / 25), 5, 15);
      rect(18, (height - 10) - (height / 25), 5, 15);
    }
  }
  tracker --;
}
