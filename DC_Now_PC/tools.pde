// return true if the player is active
boolean checkPlayer(String playerName)
{
  JSONObject p;
  
  boolean result = false;
  
  for (int i = 0; i < activePlayer.size(); i++)
  {
    p = activePlayer.getJSONObject(i);
    
    //println("Checking "+ playerName +" with "+ p.getString("username"));
    if (p.getString("username").equals(playerName))
    {
      result = true;
    }
    
    if( result ) break;
  }
  
  //if( result ) println("FOUND A MATCH!");
  //else         println("Found no match");
  
  return result;
}

//
void addPlayer(JSONObject player) {
  activePlayer.append(player);
}

// return true if the player is active
void removePlayer(String playerName)
{
  JSONObject p;
  
  for (int i = 0; i < activePlayer.size(); i++)
  {
    p = activePlayer.getJSONObject(i);
    
    if (p.getString("username").equals(playerName))
    {
      activePlayer.remove(i);
    }
  }
}

float rTime;

void updateTime()
{
  float h = 20 * displayDensity;
  int nTime = (millis() / 1000) % updateTime;

  fill(white);
  rect(0, height-h, width, h);
  
  //textFont(lib11);
  textSize(tSize*0.75);
  textAlign(CENTER, CENTER);
  fill(green);
  
  text("Next update in "+ (updateTime - nTime) +" seconds.", width/2, height - h/2);
}

void displayUpdate() {
  if(resume == true) rTime = 255;
  
  if(rTime > 0) rTime -= 3;
  
  textSize(tSize*0.75);
  textAlign(RIGHT);
  fill(200, rTime);
  //stroke(30);
  //line(0, h*3, width, h*3);
  
  text("data updated", width - border * displayDensity, (border * 2) * displayDensity); 
  
}

void displayTitle()
{
  textSize(tSize*0.75);
  textAlign(LEFT);
  fill(white);
  
  text( activePlayer.size() +" DreamPi Online", border * displayDensity, (border * 2) * displayDensity);
  
  textSize(tSize*0.75);
  textAlign(CENTER);
  fill(gray);
  
  //text("data by dreamcast.online/now/", width/2, height - 30 * displayDensity);
  //text("app by magnes-dc.tumblr.com", width/2, height - 40 * displayDensity);
}

/*
void onFlick( float x, float y, float px, float py, float v)
{
  if (py < y - 30)
    resume = true;
}

public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}
*/