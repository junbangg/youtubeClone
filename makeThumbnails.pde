import processing.video.*; // load library
Movie myMovie; // Declare Movie type variable
int x = 0;
void setup() {
  size(640,480,P3D); // what is your movie size? change it as you want.
  myMovie = new Movie(this, "Messi_2.mp4"); 
   // Create & Assign from now on myMovie is “my video file”
  myMovie.play(); // play the video 
}

void draw() {
  image(myMovie, 0, 0); // same as PImage
  myMovie.read(); // read the next frame
  
  //if (x < 100) {
  //  line(x, 0, x, 100);
  //  x = x + 1;
  //} else {
  //  noLoop();
  //}
  // Saves each frame as line-000001.png, line-000002.png, etc.
  saveFrame("/Users/bang/Desktop/test/messi-"+x+".png");
  x+=1;
}
