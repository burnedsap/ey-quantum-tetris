int currPieceType = 0;
int currPieceX = mapWidth / 2;
int currPieceY = -1;
int rotationState = 0;


// Draw current falling tetronimo
void drawFallingPiece()
{
  if (initialPause) return;

  pushMatrix();
  translate(resX/2 - ((tileWidth * mapWidth) / 2), 68);
  translate(tileWidth / 2, tileHeight / 2);
  translate(tileWidth * currPieceX, tileHeight * currPieceY);

  for (int y = 0; y < YVal; y++)
  {
    for (int x = 0; x < XVal; x++)
    {
      if (tetrominoes[currPieceType][colChecker].charAt(rotatef(x, y, rotationState)) == '1')
      {
        if (noiseChecker(tetrominoes[currPieceType][colChecker])) {
          boxShape.setFill(blockColour);
        } else {
          boxShape.setFill(noiseBlockColour);
        }
        shape(boxShape);
      }
      translate(tileWidth, 0);
    }
    translate(0, tileHeight);
    translate(-(tileWidth * 4), 0);
  }
  popMatrix();
}

// this algo is fucked needs to change
void getNewPiece()
{
  //println(colChecker+" : "+rowChecker);
  if (colChecker<colNumber) {
    if (rowChecker < tetrominoes.length) {
      rowChecker++;
    }
    if (rowChecker==tetrominoes.length) {
      rowChecker = 0;
      colChecker++;
    }
  } else if (colChecker<colNumber && rowChecker==tetrominoes.length) {
    colChecker = 0;
  }

  currPieceType = rowChecker;
  rotationState = 0;
  currPieceX = 0;
  currPieceX = (int)map(random(mapWidth), 0, mapWidth, 0, mapWidth-4); //random horizontal distribution
  //currPieceX = mapWidth / 2 - 2;

  if (currPieceType == 0 || currPieceType == 5 || currPieceType == 6)
  {
    // Makes it a little bit more fair for long pieces that would usually spawn in contact with the top of the playfield
    currPieceY = -5;
  } else
  {
    currPieceY = -4;
  }
  pushDownTimer = millis();
}


boolean noiseChecker(String input) { //true if one of 7, else false
  String var1 = "0000001000100110";
  String var2 = "0000001001100100";
  String var3 = "0000010001000110";
  String var4 = "0010001000100010";
  String var5 = "0010011000100000";
  String var6 = "0100011000100000";               
  String var7 = "0110011000000000";

  if (input.equals(var1) || input.equals(var2) || input.equals(var3) || input.equals(var4) || input.equals(var5) || input.equals(var6) || input.equals(var7))
  {
    return true;
  } else {
    return false;
  }
}