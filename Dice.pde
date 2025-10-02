Die[] dice;
int money = 100; // Starting money

void setup()
{
  size(600, 200);
  textAlign(CENTER,CENTER);
  noLoop();
  dice = new Die[5]; // Create array of 5 dice
  for(int i = 0; i < dice.length; i++){
    dice[i] = new Die(75 + i * 100, 100); // Space dice 100 pixels apart
  }
}
void draw()
{
  background(220);
  for(int i = 0; i < dice.length; i++){
    dice[i].roll();
    dice[i].show();
  }
  
  // Check for matches and add money
  String result = checkMatches();
  int payout = calculatePayout(result);
  money += payout;
  
  // Display result
  fill(0);
  textSize(24);
  text(result, width/2, 30);
  
  // Display money counter
  textAlign(RIGHT, TOP);
  textSize(18);
  text("Money: $" + money, width - 10, 10);
  
  // Display payout if any
  if(payout > 0){
    fill(0, 150, 0); // Green color for winnings
    textAlign(CENTER, CENTER);
    textSize(16);
    text("+" + payout, width/2, 55);
  }
  if(payout < 0){
    fill(150,0 , 0); // Red color for winnings
    textAlign(CENTER, CENTER);
    textSize(16);
    text("" + payout, width/2, 55);
  }
  
  textAlign(CENTER,CENTER); // Reset text alignment
}
void mousePressed()
{
  money -= 30;
  redraw();
}

String checkMatches()
{
  // Count occurrences of each value (1-6)
  int[] counts = new int[7]; // Index 0 unused, indices 1-6 for dice values
  
  for(int i = 0; i < dice.length; i++){
    counts[dice[i].value]++;
  }
  
  // Count how many pairs, triples, etc. we have
  int pairs = 0;
  int triples = 0;
  int quadruples = 0;
  int flushes = 0;
  
  for(int i = 1; i <= 6; i++){
    if(counts[i] == 2) pairs++;
    else if(counts[i] == 3) triples++;
    else if(counts[i] == 4) quadruples++;
    else if(counts[i] == 5) flushes++;
  }
  
  // Check for straight (1,2,3,4,5)
  boolean isStraight = true;
  for(int i = 1; i <= 5; i++){
    if(counts[i] != 1){
      isStraight = false;
      break;
    }
  }
  
  // Return appropriate result based on combinations
  if(flushes == 1){
    return "FLUSH!";
  }
  else if(quadruples == 1){
    return "QUADRUPLE!";
  }
  else if(triples == 1 && pairs == 1){
    return "FULL HOUSE!";
  }
  else if(isStraight){
    return "STRAIGHT!";
  }
  else if(triples == 1){
    return "TRIPLE!";
  }
  else if(pairs == 2){
    return "TWO PAIRS!";
  }
  else if(pairs == 1){
    return "PAIR!";
  }
  else{
    return "NO MATCH";
  }
}

int calculatePayout(String result)
{
  if(result.equals("FLUSH!")){
    return 1000;
  }
  else if(result.equals("QUADRUPLE!")){
    return 500;
  }
  else if(result.equals("FULL HOUSE!")){
    return 300;
  }
  else if(result.equals("STRAIGHT!")){
    return 250;
  }
  else if(result.equals("TRIPLE!")){
    return 100;
  }
  else if(result.equals("TWO PAIRS!")){
    return 50;
  }
  else if(result.equals("PAIR!")){
    return 0;
  }
  else{
    return -400; // No payout for no match
  }
}

class Die
{
  //member variables
  int value;
  int myX, myY;
  
  //constructor
  Die(int x, int y)
  {
    value = 1;
    myX = x;
    myY = y;
  }
  
  void roll()
  {
    value = (int)(Math.random() * 6) + 1; // Random number 1-6
  }
  
  void show()
  {
    // Draw die background
    stroke(0);
    fill(255);
    rect(myX - 30, myY - 30, 60, 60, 8); // Rounded rectangle
    
    // Draw dots based on value
    fill(0);
    int dotSize = 8;
    
    if(value == 1){
      ellipse(myX, myY, dotSize, dotSize);
    }
    else if(value == 2){
      ellipse(myX - 15, myY - 15, dotSize, dotSize);
      ellipse(myX + 15, myY + 15, dotSize, dotSize);
    }
    else if(value == 3){
      ellipse(myX - 15, myY - 15, dotSize, dotSize);
      ellipse(myX, myY, dotSize, dotSize);
      ellipse(myX + 15, myY + 15, dotSize, dotSize);
    }
    else if(value == 4){
      ellipse(myX - 15, myY - 15, dotSize, dotSize);
      ellipse(myX + 15, myY - 15, dotSize, dotSize);
      ellipse(myX - 15, myY + 15, dotSize, dotSize);
      ellipse(myX + 15, myY + 15, dotSize, dotSize);
    }
    else if(value == 5){
      ellipse(myX - 15, myY - 15, dotSize, dotSize);
      ellipse(myX + 15, myY - 15, dotSize, dotSize);
      ellipse(myX, myY, dotSize, dotSize);
      ellipse(myX - 15, myY + 15, dotSize, dotSize);
      ellipse(myX + 15, myY + 15, dotSize, dotSize);
    }
    else if(value == 6){
      ellipse(myX - 15, myY - 15, dotSize, dotSize);
      ellipse(myX + 15, myY - 15, dotSize, dotSize);
      ellipse(myX - 15, myY, dotSize, dotSize);
      ellipse(myX + 15, myY, dotSize, dotSize);
      ellipse(myX - 15, myY + 15, dotSize, dotSize);
      ellipse(myX + 15, myY + 15, dotSize, dotSize);
    }
  }
}
