

import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_BOMBS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    
    setBombs();
}
public void setBombs()
{
    //your code
    while(bombs.size() < NUM_BOMBS)
    {
        int r = (int)(Math.random()*20);
        int c = (int)(Math.random()*20);
        if(!bombs.contains(buttons[r][c])){
            bombs.add(buttons[r][c]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int sum = 0;
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].isClicked() == false)
                sum++;
        }
    }
    if(sum == NUM_BOMBS)
        return true;
    return false;
}
public void displayLosingMessage()
{
    //your code here
    buttons[9][7].setLabel("U");
    buttons[9][8].setLabel(" ");
    buttons[9][9].setLabel("L");
    buttons[9][10].setLabel("O");
    buttons[9][11].setLabel("S");
    buttons[9][12].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here
    buttons[9][7].setLabel("W");
    buttons[9][8].setLabel("I");
    buttons[9][9].setLabel("N");
    buttons[9][10].setLabel("N");
    buttons[9][11].setLabel("E");
    buttons[9][12].setLabel("R");
    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
            clicked = true;
        if(mouseButton == RIGHT){
            if(isMarked() == true){
                marked = false;
                clicked = false;
            }
            else
                marked = true;
        }
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c) > 0)
            setLabel(""+countBombs(r,c));
        else{
                if(isValid(r,c-1) && buttons[r][c-1].isClicked()  == false){
                    buttons[r][c-1].mousePressed();
                }
                if(isValid(r,c+1) && buttons[r][c+1].isClicked()  == false){
                    buttons[r][c+1].mousePressed();
                }
                if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked()  == false){
                    buttons[r-1][c-1].mousePressed();
                }
                if(isValid(r-1,c) && buttons[r-1][c].isClicked()  == false){
                    buttons[r-1][c].mousePressed();
                }
                if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked()  == false){
                    buttons[r-1][c+1].mousePressed();
                }
                if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()  == false){
                    buttons[r+1][c-1].mousePressed();
                }
                if(isValid(r+1,c) && buttons[r+1][c].isClicked()  == false){
                    buttons[r+1][c].mousePressed();
                }
                if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked()  == false){
                    buttons[r+1][c+1].mousePressed();

    }
        }
        //your code here
        isWon();
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(150,180,180);
        else 
            fill(60,110,120);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if(isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if(isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        return numBombs;

    }
}

///

//