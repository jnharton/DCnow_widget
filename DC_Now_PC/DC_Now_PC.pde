import ddf.minim.*;
import java.util.*;

//Minim minim;

//General
int tSize = 15;
int tSpace = 0;
int updateTime = 60;
int border = 10;

//Fonts
PFont lib11;
PFont lib15;

//Colors
//https://coolors.co/272932-adbac6-60656f-d5a021-226ce0
color dark = #272932;
color green = #226CE0;
color light = #ADBAC6;
color gray = #B7B7B7;
color gameColor = #D5A021;
color white = #EBEBEB;

int lastPlayerCount = 0;
JSONArray activePlayer;
JSONArray player;
boolean resume = false;

int displayDensity = 1;

PGraphics display;

void setup()
{
  size(300, 400);
  //fullScreen();
  surface.setTitle("DC_Now");
  noSmooth();
  noStroke();
  lib15 = loadFont("font15.vlw");
  //textFont(lib15);
  tSize = int(tSize * displayDensity);

  //ANDROID////////////////////////////
  //gesture = new KetaiGesture(this);



  //sound stuff
  /*
  minim = new Minim(this);
   connect = minim.loadFile("S2_35.wav");
   connect.setVolume(0.25);
   disconnect = minim.loadFile("S2_23.wav");
   disconnect.setVolume(0.25);
   */
  //get first data
  activePlayer = new JSONArray();
  getOnlinePlayers();
  
  display = createGraphics(300, 400);
}

void draw()
{
  background(dark);
  updateTime();

  if (resume == true)
    getOnlinePlayers();

  if (millis() % (updateTime * 1000) < 50)
  {
    resume = true;
  }

  displayUpdate();
  //displayPlayers();
  
  renderDisplay();
  image(display, 0, 0);
  
  displayTitle(); 
  delay(10);
}


void getOnlinePlayers()
{
  int cPlayer = 0;

  JSONObject p;
  JSONObject data;

  int totalUser;

  String userName;
  boolean online;
  String current_game;

  StringList gameList = new StringList();

  //disconnect.rewind();
  //connect.rewind();
  println("Refreshing players");

  data = loadJSONObject("http://dreamcast.online/now/api/users.json");
  totalUser = data.getInt("total_count");
  player = data.getJSONArray("users");

  for (int i = 0; i < totalUser; i++)
  {
    p = player.getJSONObject(i);

    userName = p.getString("username");
    online = p.getBoolean("online");
    current_game = p.getString("current_game");

    if ( online ) {
      if ( !checkPlayer( userName ) ) {
        println("Adding : " + userName);
        //connect.play();
        addPlayer( p );
      }
      else {
        if ( !gameList.hasValue(current_game) ) gameList.append(current_game);
      }
    }
    else {
      if ( checkPlayer( userName ) ) {
        print("Removing : " + userName);
        //disconnect.play();
        removePlayer( userName );
      }
    }
  }

  resume = false;
  delay(10);
}

void renderDisplay() {
  display.beginDraw();
  
  /*************************/
  /** display players     **/
  /*************************/
  
  int line = 3;
  
  display.stroke(30);
  display.strokeWeight(5);
  display.strokeCap(SQUARE);
  
  if (activePlayer.size() > 0)
  {
    String userName;
    String current_game;
    
    for (int i = 0; i < activePlayer.size(); i++)
    {
      ////////////LINE///////////
      PVector start = new PVector(border * displayDensity, line * tSize);
      display.line(start.x, start.y, width - border, start.y);
      
      ////////////PLAYER/////////
      JSONObject p = activePlayer.getJSONObject(i);
      
      userName = p.getString("username");
      current_game = p.getString("current_game");
      
      /* player name */
      display.textSize(tSize);
      display.textAlign(LEFT);
      display.fill(green);
      
      //display.ellipse(13 * displayDensity, 37 * displayDensity + (line * (tSize + tSpace)), 5 * displayDensity, 5 * displayDensity);
      display.text(userName, border * displayDensity, line * tSize);
      //display.line++;
      
      /* game */
      display.textSize(tSize*0.75);
      display.textAlign(RIGHT);
      display.fill(gameColor);
      
      display.text(current_game, (width-border) * displayDensity, line * tSize);
      
      line++;
    }
  }
  
  display.noStroke();
  
  /*************************/
  /** display ?           **/
  /*************************/
  
  display.endDraw();
}

void displayPlayers()
{
  int line = 3;
  
  stroke(30);
  strokeWeight(5);
  strokeCap(SQUARE);
  
  if (activePlayer.size() > 0)
  {
    String userName;
    String current_game;
    
    for (int i = 0; i < activePlayer.size(); i++)
    {
      ////////////LINE///////////
      PVector start = new PVector(border * displayDensity, line * tSize);
      line(start.x, start.y, width - border, start.y);
      
      ////////////PLAYER/////////
      JSONObject p = activePlayer.getJSONObject(i);
      
      userName = p.getString("username");
      current_game = p.getString("current_game");
      
      /* player name */
      textSize(tSize);
      textAlign(LEFT);
      fill(green);
      
      //ellipse(13 * displayDensity, 37 * displayDensity + (line * (tSize + tSpace)), 5 * displayDensity, 5 * displayDensity);
      text(userName, border * displayDensity, line * tSize);
      //line++;
      
      /* game */
      textSize(tSize*0.75);
      textAlign(RIGHT);
      fill(gameColor);
      
      text(current_game, (width-border) * displayDensity, line * tSize);
      
      line++;
    }
  }
  
  noStroke();
}