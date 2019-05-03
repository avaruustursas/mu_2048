// Yet another 2048 clone
// avaruustursas 24.04.2019

// 02.05.2019
// BUG:
// The game ends requires the player to press keys to update the stalemate game state

IntList state_data;
Boolean GAME_ON = true;

void draw_board() {
   square(16,16,120);
  square(16+120,16,120);
  square(16+2*120,16,120);
  square(16+3*120,16,120);
  
  square(16,16+120,120);
  square(16+120,16+120,120);
  square(16+2*120,16+120,120);
  square(16+3*120,16+120,120);
  
  square(16,16+2*120,120);
  square(16+120,16+2*120,120);
  square(16+2*120,16+2*120,120);
  square(16+3*120,16+2*120,120);
  
  square(16,16+3*120,120);
  square(16+120,16+3*120,120);
  square(16+2*120,16+3*120,120);
  square(16+3*120,16+3*120,120);
}

Boolean game_end(IntList state) {
  // test the game data without updating
  ArrayList<IntList> dummy_states = new ArrayList<IntList>();
  dummy_states.add(set_game_from_rows(update_game_rows_left(get_game_rows(state))));
  dummy_states.add(set_game_from_rows(update_game_rows_left(get_game_rows(state))));
  dummy_states.add(set_game_from_columns(update_game_columns_up(get_game_columns(state))));
  dummy_states.add(set_game_from_columns(update_game_columns_down(get_game_columns(state))));
  for(IntList d : dummy_states) {
    if(d.hasValue(0))
      return false;
  }
  return true;
}

IntList add_new_tile(IntList state) {
  // find random empty tile
  // get random ind, add random 2 or 4 if it is empty
  int rand_ind = int(random(0,state.size()));
  while(state.get(rand_ind) != 0) {
    rand_ind = int(random(0,state.size()));
  }
  int rand_value = int(random(0,10));
  if(state.get(rand_ind) == 0) {
    if(rand_value <= 5)
      state.set(rand_ind,2);
    else state.set(rand_ind,4);
  }
  return state;
}

ArrayList get_game_rows(IntList state) {
  ArrayList<IntList> rows = new ArrayList<IntList>();
  IntList row1 = new IntList();
  IntList row2 = new IntList();
  IntList row3 = new IntList();
  IntList row4 = new IntList();
  rows.add(row1);
  rows.add(row2);
  rows.add(row3);
  rows.add(row4);
  for(int i=0;i<state.size();i++) {
    if(i/4 == 0)
      rows.get(0).append(state.get(i));
    else if(i/4 == 1)
      rows.get(1).append(state.get(i));
    else if(i/4 == 2)
      rows.get(2).append(state.get(i));
    else rows.get(3).append(state.get(i));
  }
  return rows;
}

ArrayList get_game_columns(IntList state) {
  ArrayList<IntList> cols = new ArrayList<IntList>();
  IntList col1 = new IntList();
  IntList col2 = new IntList();
  IntList col3 = new IntList();
  IntList col4 = new IntList();
  cols.add(col1);
  cols.add(col2);
  cols.add(col3);
  cols.add(col4);
  for(int i=0;i<state.size();i++) {
    if(i%4 == 0)
      cols.get(0).append(state.get(i));
    else if(i%4 == 1)
      cols.get(1).append(state.get(i));
    else if(i%4 == 2)
      cols.get(2).append(state.get(i));
    else cols.get(3).append(state.get(i));
  }
  return cols;
}

ArrayList update_game_columns_up(ArrayList<IntList> state) {
  ArrayList<IntList> new_state = new ArrayList<IntList>();
  IntList stack = new IntList();
  for(IntList col : state) {
    // first quick and dirty shift to up
    for(int i : col) {
      if(i == 0)
        continue;
      else stack.append(i);
    }
    // combine
    int size = stack.size();
    for(int i=0;i<size;i++) {
      if(size != 0 && size > i+1 && stack.get(i) == stack.get(i+1)) {
        stack.set(i,2*stack.get(i));
        stack.remove(i+1);
        size--;
      }
    }
    // set size to 4
    while(stack.size() < 4) {
      stack.append(0);
    }
    new_state.add(stack);
    //stack.clear(); // this fails it keeps the ref to the cleared obj in the arraylist
    stack = new IntList();
  }
  
  return new_state;
}

ArrayList update_game_columns_down(ArrayList<IntList> state) {
  ArrayList<IntList> new_state = new ArrayList<IntList>();
  IntList stack = new IntList();
  for(IntList col : state) {
    // first quick and dirty shift to down
    col.reverse();
    for(int i : col) {
      if(i == 0)
        continue;
      else stack.append(i);
    }
    // combine
    int size = stack.size();
    for(int i=0;i<size;i++) {
      if(size != 0 && size > i+1 && stack.get(i) == stack.get(i+1)) {
        stack.set(i,2*stack.get(i));
        stack.remove(i+1);
        size--;
      }
    }
    // set size to 4
    while(stack.size() < 4) {
      stack.append(0);
    }
    stack.reverse();
    new_state.add(stack);
    //stack.clear(); // this fails it keeps the ref to the cleared obj in the arraylist
    stack = new IntList();
  }
  
  return new_state;
}

ArrayList update_game_rows_left(ArrayList<IntList> state) {
  ArrayList<IntList> new_state = new ArrayList<IntList>();
  IntList stack = new IntList();
  for(IntList col : state) {
    // first quick and dirty shift to left
    for(int i : col) {
      if(i == 0)
        continue;
      else stack.append(i);
    }
    // combine
    int size = stack.size();
    for(int i=0;i<size;i++) {
      if(size != 0 && size > i+1 && stack.get(i) == stack.get(i+1)) {
        stack.set(i,2*stack.get(i));
        stack.remove(i+1);
        size--;
      }
    }
    // set size to 4
    while(stack.size() < 4) {
      stack.append(0);
    }
    new_state.add(stack);
    //stack.clear(); // this fails it keeps the ref to the cleared obj in the arraylist
    stack = new IntList();
  }
  
  return new_state;
}

ArrayList update_game_rows_right(ArrayList<IntList> state) {
  ArrayList<IntList> new_state = new ArrayList<IntList>();
  IntList stack = new IntList();
  for(IntList row : state) {
    // first quick and dirty shift to right
    row.reverse();
    for(int i : row) {
      if(i == 0)
        continue;
      else stack.append(i);
    }
    // combine
    int size = stack.size();
    for(int i=0;i<size;i++) {
      if(size != 0 && size > i+1 && stack.get(i) == stack.get(i+1)) {
        stack.set(i,2*stack.get(i));
        stack.remove(i+1);
        size--;
      }
    }
    // set size to 4
    while(stack.size() < 4) {
      stack.append(0);
    }
    stack.reverse();
    new_state.add(stack);
    //stack.clear(); // this fails it keeps the ref to the cleared obj in the arraylist
    stack = new IntList();
  }
  
  return new_state;
}

IntList set_game_from_rows(ArrayList<IntList> rows) {
  IntList new_state = new IntList();
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      new_state.append(rows.get(i).get(j));
    }
  }
  return new_state;
}

IntList set_game_from_columns(ArrayList<IntList> cols) {
  IntList new_state = new IntList();
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      new_state.append(cols.get(j).get(i));
    }
  }
  return new_state;
}


Boolean state_data_changed(IntList initial_state, IntList updated_state) {
  for(int i=0;i<initial_state.size();i++) {
    if(initial_state.get(i) != updated_state.get(i))
      return true;
  }
  return false;
}

IntList get_screen_coords_from_index(int ind) {
  // return the board coordinates of a tile position by given index of tile
  // i.e. (0,0) = (16,16); (0,1) = (16+120,16);...
  int x = ind%4*120+16;
  int y = ind/4*120+16;
  return new IntList(x,y);
}

void draw_tile(int ind, int n) {
  // draws tile with value n to board coords (x,y)
  IntList coords = get_screen_coords_from_index(ind);
  fill(230,191,60);
  rect(float(coords.get(0)),float(coords.get(1)),120.0,120.0,13.0);
  textSize(40);
  fill(255,255,255);
  if (n < 64) {
    text(n,float(coords.get(0))+50,float(coords.get(1))+70);
  }
  else if (n < 1024) {
    text(n,float(coords.get(0))+30,float(coords.get(1))+70);
  }
  else {
    text(n,float(coords.get(0))+10,float(coords.get(1))+70);
  }
}

void draw_game_over() {
  fill(111,191,60);
  rect(113,113,320.0,220.0,13.0);
  textSize(40);
  fill(255,255,255);
  text("GAME OVER",150,160);
}

void setup() {
  //size(1024,768);
  size(512,512);
  // 512/4 = (256+256)/4 = (128+128+128+128)/4 = 128
  //  -> tile width = 120
  // 512 - 4*120 = 512-480 = 32 -> 16 margins for now
  
  // the state of the game is stored in 4x4 = 16 dimensional array
  // 0 = empty
  // 2,4,16,32,64,128,512,1024,2048,... gives the value of tile
  state_data = new IntList(
          2,2,0,0,
          0,2,0,0,
          0,4,8,0,
          0,0,0,0);
  //print(state_data);
}

void draw() {
  //for (int i : state_data) {
  if(GAME_ON) {
    draw_board();
    //draw_tile(1,1);
    //draw_tile(5,512);
    //draw_tile(12,1024);
    int i = 0;
    for (int t : state_data) {
      if (t != 0) {
        draw_tile(i,t);
      }
      i++;
    }
  }
  else draw_game_over();
}

void keyPressed() {
  if(key == ESC) exit();
  {
     IntList updated_state_data = new IntList();
     if (key == CODED) {
       if (keyCode == UP) {
         updated_state_data = set_game_from_columns(update_game_columns_up(get_game_columns(state_data)));
       }
       else if (keyCode == RIGHT) {
         updated_state_data = set_game_from_rows(update_game_rows_right(get_game_rows(state_data)));
       }
       else if (keyCode == DOWN) {
         updated_state_data = set_game_from_columns(update_game_columns_down(get_game_columns(state_data)));
       }
       else if (keyCode == LEFT) {
         updated_state_data = set_game_from_rows(update_game_rows_left(get_game_rows(state_data)));
       }
       else {
       }
     }
     if(game_end(state_data)) {
       println("game ends, full");
       GAME_ON = false;
     }
     else {
       if (state_data_changed(state_data,updated_state_data))
         state_data = add_new_tile(updated_state_data);
     }
  }
}
