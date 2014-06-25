//Memory game
//Teresa Paulino
//21-04-2012
//v.2.0

//arrays that will store images'coordinates information
int[] x = { 50, 200, 350, 500, 650, 800, 950, 125, 275, 425, 575, 725, 875, 50, 200, 350, 500, 650, 800, 950, 125, 275, 425, 575, 725, 875, -100};
int[] y = { 50, 50, 50, 50, 50, 50, 50, 200, 200, 200, 200, 200, 200, 350, 350, 350, 350, 350, 350, 350, 500, 500, 500, 500, 500, 500, -100};

//arrays used to shuffle images
int[] numbers1 = new int[13];
int[] numbers2 = new int[13];
int[] numbers = new int[27];    //arrays numbers and images have 27 spaces instead of 26 in case of a key different from a to z be pressed

//arrays used to store images
PImage[] images = new PImage[27]; 
PImage[] imageCorrect = new PImage[26]; 

//many variables used to make the process of the game work 
PImage firstImage; 
int keyNumber;
int pressed = 0;
int letterNumber;
int[] xpos = new int[26];
int[] ypos = new int[26];
int imagesFound = 0;
int xFirst;
int yFirst;
int keyNumber2 = 26;
int z=-height;

//using ddf.minim library in order to be possible to play sounds
import ddf.minim.*;
Minim minim;
AudioPlayer sound1;
AudioPlayer sound2;

void setup()
{
  //attribute sound files information to the variable sound1 and sound2
  minim = new Minim(this);
  sound1 = minim.loadFile("Music_Box.wav");
  sound2 = minim.loadFile("Flute_tone.wav");
  
  //set window size and load background image  
  size(1100, 650);
  background(loadImage("memoryGameTable.jpg"));
  noStroke();
  smooth();
  fill(0, 255, 255, 90);//fill color information to the rectangles that will be drawed
  
  //attribute values to arrays numbers1 and numbers2 (shuffled numbers between 0 and 12)
  for (int i = 0; i < 13; i++)
  {
    int j = int(random(0, i+1));//using another variable (j) to help creating an array randomized without repititions
    numbers1[i] = numbers1[j];
    numbers1[j] = i;
  }
  
  for (int h = 0; h < 13; h++)
  {
    int k = int(random(0, h+1));
    numbers2[h] = numbers2[k];
    numbers2[k] = h;
  }
  
  // attribute values to the array numbers from the 2 arrays before 
  for (int b = 0; b < 26; b++)
  {
    if (b<13)
    {
      numbers[b] = numbers1[b];
    }
    else
    {
     numbers[b] = numbers2[b-13]; 
    }
  }
  
  //fill the array images sorted with  images using the same order from the array numbers
  for (int c = 0; c < 26; c++ ) 
  {
    images[c] = loadImage( numbers[c] + ".jpg" ); 
  }
}

//start the drawing
void draw()
 {
   title(); //calling the function title described in the bottom of this sketch
   
   //the actions described bellow happen everytime a key is pressed or mouse clicked
   //using variable pressed to know how may images are open
   if (pressed > 1)
   {
    //if there are already two images open check if they are equal
    if (letterNumber == numbers[keyNumber] & letterNumber!=26)
     {
       //play the sound1 showing the success of two equal images found
       sound1.loop(0); 
   
       //attribute values to the arrays that will store information of the found equal images (coordinates and images)
       xpos[imagesFound] = xFirst;
       ypos[imagesFound] = yFirst;           //data information of the 1st opened image (x, y and image)
       imageCorrect[imagesFound] = firstImage;
       pressed = 0; //set the variable to 0 again to start opening two more images
       imagesFound ++; //increase the variable used to attribute values to the arrays that store the found equal images
       xpos[imagesFound] = x[keyNumber];
       ypos[imagesFound] = y[keyNumber];           //data information of the 2nd found image (x, y and image)
       imageCorrect[imagesFound] = images[keyNumber];
       
       //draw 2 rectangles over the 2 found images
       rect(xFirst, yFirst, 100, 100);
       rect(x[keyNumber], y[keyNumber], 100, 100);
       
       imagesFound ++;//increase again the variable imagesFound in order to be ready to receive the next coming values
       
       if (imagesFound==26) // if all the images were found, write a congratulations message and loads an image
       {
         sound1.close();
         sound2.loop(0);
         println("Congratulations! You won!");
         image(loadImage("winingBackground.png"), 0, 0);
       }
     }
     
     //if the images are not equal
     else
     {
       keyNumber2 = 26;//Set this variable again to 26 so it's different from any keyNumber variable and allow to repeat the letter
       background(loadImage("memoryGameTable.jpg"));//loads the background image again
       pressed = 0;//change the variable pressed to 0 in order to inform that is ready to start opening two more images
       
       //if there are already found equal images, load the found images and draw the rectangles over them again so the user can know at any moment the game progress
       if (imagesFound > 0)
       {
         for (int i=0; i<imagesFound; i++)
       {
        image(imageCorrect[i], xpos[i], ypos[i]);
        rect(xpos[i], ypos[i], 100, 100);       
       }
     }
   }
 }
 
 //if is still not 2 images loaded, just attribute values to the variables that keep the data of the 1st image and do nothing else
 else 
 {
   xFirst = x[keyNumber];
   yFirst = y[keyNumber];
   firstImage = images[keyNumber];
   letterNumber = numbers[keyNumber];//this variable is used to compare the images loaded to later know if they are equal or not
 }
} 

//function that works when a key is pressed
void keyPressed()
{
  if (keyPressed)//when a key is pressed attribute values to the variable keyNumber in order to correspond to the array images
  {      
    if (key=='a' || key=='A')
    {
      keyNumber=0;
    }
    else if (key=='b' || key=='B')
    {
      keyNumber=1;
    }   
    else if (key=='c' || key=='C')
    {
      keyNumber=2;
    }
    else if (key=='d' || key=='D')
    {
      keyNumber=3;
    }
    else if (key=='e' || key=='E')
    {
      keyNumber=4;
    }
    else if (key=='f' || key=='F')
    {
      keyNumber=5;
      }
    else if (key=='g' || key=='G')
    {
      keyNumber=6;
    }
    else if (key=='h' || key=='H')
    {
      keyNumber=7;
    }
    else if (key=='i' || key=='I')
    {
      keyNumber=8;
    }
    else if (key=='j' || key=='J')
    {
      keyNumber=9;
    }
    else if (key=='k' || key=='K')
    {
      keyNumber=10;
    }
    else if (key=='l' || key=='L')
    {
      keyNumber=11;
    }
    else if (key=='m' || key=='M')
    {
      keyNumber=12;
    }
    else if (key=='n' || key=='N')
    {
      keyNumber=13;
    }
    else if (key=='o' || key=='O')
    {
      keyNumber=14;
    }
    else if (key=='p' || key=='P')
    {
      keyNumber=15;
    }
    else if (key=='q' || key=='Q')
    {
      keyNumber=16;
    }
    else if (key=='r' || key=='R')
    {
      keyNumber=17;
    }
    else if (key=='s' || key=='S')
    {
      keyNumber=18;
    }
    else if (key=='t' || key=='T')
    {
      keyNumber=19;
    }
    else if (key=='u' || key=='U')
    {
      keyNumber=20;
    }
    else if (key=='v' || key=='V')
    {
      keyNumber=21;
    }
    else if (key=='w' || key=='W')
    {
      keyNumber=22;
    }
    else if (key=='x' || key=='X')
    {
      keyNumber=23;
    }
    else if (key=='y' || key=='Y')
    {
      keyNumber=24;
    }
    else if (key=='z' || key=='Z')
    {
      keyNumber=25;
    } 
    else 
    {
      keyNumber = 26;
    }
    if (keyNumber==26)//if is not a letter between a or z write/display a message
    {
      image(loadImage("chooseAlphabet.png"), 250, 470);
      println("Please choose a letter of the alphabet between A and Z");
     
    }
    else if (keyNumber==keyNumber2)//if the same letter was pressed again, write/display a message
    {
      println("Please choose a different letter");
      image(loadImage("chooseDifferent.png"), 380, 320);
    }
    else
    {
      keyNumber2 = keyNumber;
      //load the correspondent image and increase the variable pressed 
      image(images[keyNumber], x[keyNumber], y[keyNumber]);
      pressed++;
    }
  }
} 

//function that will able use the mouse and click to open the images according to mouse coordinates
//and then uses the same process as keyPressed with the same variables
void mousePressed()
{
  if (mousePressed == true)
  {
    if(mouseY>50 & mouseY<150)
    {
     if(mouseX>50 & mouseX <150)
     {
      keyNumber=0; 
     }
     else if(mouseX>200 & mouseX <300)
     {
      keyNumber=1; 
     }
     else if(mouseX>350 & mouseX <450)
     {
      keyNumber=2; 
     }
     else if(mouseX>500 & mouseX <600)
     {
      keyNumber=3; 
     }
      else if(mouseX>650 & mouseX <750)
     {
      keyNumber=4; 
     }
     else if(mouseX>800 & mouseX <900)
     {
      keyNumber=5; 
     }
     else if(mouseX>950 & mouseX <1050)
     {
      keyNumber=6; 
     }
    }
    
    if(mouseY>200 & mouseY<300)
    {
     if(mouseX>125 & mouseX <225)
     {
      keyNumber=7; 
     }
     else if(mouseX>275 & mouseX <375)
     {
      keyNumber=8; 
     }
     else if(mouseX>425 & mouseX <525)
     {
      keyNumber=9; 
     }
     else if(mouseX>575 & mouseX <675)
     {
      keyNumber=10; 
     }
      else if(mouseX>725 & mouseX <825)
     {
      keyNumber=11; 
     }
     else if(mouseX>875 & mouseX <975)
     {
      keyNumber=12; 
     }
    }
    
    if(mouseY>350 & mouseY<450)
    {
     if(mouseX>50 & mouseX <150)
     {
      keyNumber=13; 
     }
     else if(mouseX>200 & mouseX <300)
     {
      keyNumber=14; 
     }
     else if(mouseX>350 & mouseX <450)
     {
      keyNumber=15; 
     }
     else if(mouseX>500 & mouseX <600)
     {
      keyNumber=16; 
     }
      else if(mouseX>650 & mouseX <750)
     {
      keyNumber=17; 
     }
     else if(mouseX>800 & mouseX <900)
     {
      keyNumber=18; 
     }
     else if(mouseX>950 & mouseX <1050)
     {
      keyNumber=19; 
     }
    }
    
    if(mouseY>500 & mouseY<600)
    {
     if(mouseX>125 & mouseX <225)
     {
      keyNumber=20; 
     }
     else if(mouseX>275 & mouseX <375)
     {
      keyNumber=21; 
     }
     else if(mouseX>425 & mouseX <525)
     {
      keyNumber=22; 
     }
     else if(mouseX>575 & mouseX <675)
     {
      keyNumber=23; 
     }
      else if(mouseX>725 & mouseX <825)
     {
      keyNumber=24; 
     }
     else if(mouseX>875 & mouseX <975)
     {
      keyNumber=25; 
     }
    }

    if (keyNumber==keyNumber2)
    {
      println("Please choose a different letter");
      image(loadImage("chooseDifferent.png"), 380, 320);
    }
    else
    {
    keyNumber2 = keyNumber;
    image(images[keyNumber], x[keyNumber], y[keyNumber]);
    pressed++;
  }
}}

//function that will draw a sliding title through the window game
void title()
{
  if ( z<height+100 )
  {
   frameRate(30);
   background(loadImage("memoryGameTable.jpg"));
   image(loadImage("memoryGameTitle.png"), 160, z);
   z+=70;
 }
}
