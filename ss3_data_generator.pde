import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.FileReader;

Node[][] nodes;
final int nodeSize = 100;
final int boardSize = 700; 
int iter = 0;
String path; 

Checkbox clearBoardCheckBox;

void setup() {
  selectFolder("Select ss3_data_generator directory:", "folderSelected");
  size(800, 500);

  clearBoardCheckBox = new Checkbox(width-75, 50, "Clear board");

  createNodes();
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    exit();
  } else {
    path = selection.getAbsolutePath();
    println("User selected " + path);
    iter = readIter();
    println("Iter = " + iter);
  }
}

int readIter() {
  try {
    String temp_path = String.join("", path, "\\ss3_data\\iter.txt\\");
    FileReader iterFile = new FileReader(temp_path);
    char iterBuff[] = new char[8];
    iterFile.read(iterBuff);
    iterFile.close();
    return Integer.parseInt(String.valueOf(iterBuff).trim());
  }
  catch(FileNotFoundException e) {
    println("File not found! Creating new dir there...");
    String temp_dir_path = String.join("", path, "\\ss3_data\\");
    new File(temp_dir_path).mkdirs();
    return 0;
  }
  catch(IOException e) {
    println("Error while trying to open file");
    e.printStackTrace();
    return 0;
  }
}

void updateIter(int _iter) {
  try {
    String temp_path = String.join("", path, "\\ss3_data\\iter.txt\\");
    FileWriter output = new FileWriter(temp_path, false);
    output.write(String.valueOf(_iter));
    output.close();
  }  
  catch(IOException e) {
    println("Error while trying to open file");
    e.printStackTrace();
  }
}

void createNodes() {
  println("Creating new board...");

  // Initialize array with empty nodes
  nodes = new Node[boardSize/nodeSize][height/nodeSize];

  for (int i = 0; i < boardSize/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      nodes[i][j] = new Node(i, j);
    }
  }
}

void mousePressed() {
  // nodes board
  if (mouseX <= boardSize) { 
    nodes[mouseX/nodeSize][mouseY/nodeSize].clicked();
  } 
  // checkbox
  else if (mouseX >= clearBoardCheckBox.x 
    && mouseX <= clearBoardCheckBox.x+50
    && mouseY >= clearBoardCheckBox.y 
    && mouseY <= clearBoardCheckBox.y+50) {
    clearBoardCheckBox.clicked();
  } 
  // reset button
  else if (mouseX > 700 && mouseX <= width 
    && mouseY >= 250 && mouseY <= 300) {
    updateIter(iter=0);
  }
  // add button
  else if (mouseX > 700 && mouseY > 400) {
    generateData();
  }
}

void generateData() {
  println("GENERATING DATA...");
  try {
    String temp_path = String.join("", path, "\\ss3_data\\data.txt\\");
    FileWriter output = new FileWriter(temp_path, true);
    output.write("\ndupa_" + iter + " = [\n");
    for (int j = 0; j < height/nodeSize; j++) {
      output.write("\t");
      for (int i = 0; i < boardSize/nodeSize; i++) {
        output.write(nodes[i][j].isClicked() + "");
        if (i < (boardSize/nodeSize) - 1)
          output.write(",\t");
      }
      output.write(";\n");
    }
    output.write("];\n");

    println("Done!");
    output.close();
  }
  catch(IOException e) {
    println("Error while trying to open file");
    e.printStackTrace();
  }

  // Clear table if checkbox enabled
  if (clearBoardCheckBox.clicked)
    createNodes();

  updateIter(++iter);
}

void draw() {
  for (int i = 0; i < boardSize/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      nodes[i][j].show();
    }
  }

  clearBoardCheckBox.show();

  // Iter box
  fill(155, 155, 155);
  rect(700, 200, 100, 50);
  textSize(24);
  fill(0, 0, 0);
  text("No. " + iter, 715, 235);

  // reset iter box
  fill(185, 185, 185);
  rect(700, 250, 100, 50);
  textSize(24);
  fill(0, 0, 0);
  text("Reset", 715, 285);

  // add box
  fill(155, 155, 155);
  rect(700, 400, 100, 100);
  fill(0, 0, 0);
  text("ADD", 725, 460);
}
