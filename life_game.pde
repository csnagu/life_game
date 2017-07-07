// 0:dead, 1:alive
// ゲームの盤 32*32
int N = 40;
int [][] pos = new int[N][N];
int w;  // 正方形の比率

void setup(){
  frameRate(150);
  size(500, 500);
  background(0, 0, 0);
  // 盤の初期化と第０世代の生成
  for(int i=0; i<N; i++){
    for(int j=0; j<N; j++){
      pos[i][j] = (int)random(2);
    }
  }
  
  // 盤の描画
  w = width/N;
  draw_board(pos, w);
  /* something */
  //noLoop();
  
}

void draw(){
  // 次の盤面を決める
  next_step(pos);
  //println();
  //println();
  //for(int i=0; i<N; i++){
  //  for(int j=0; j<N; j++){
  //    print(pos[i][j]);
  //  }
  //  println();
  //}

  draw_board(pos, w);
  println(frameCount);
}
 
// 盤を描画する関数
void draw_board(int [][] pos, int w){
  for(int row=0; row<N; row++){
    for(int col=0; col<N; col++){
      //print(pos[row][col]);
      if(pos[row][col] == 1){
        fill(255, 255, 0); // "生"の白色
        rect(col*w, row*w, w, w);
      }else {
        fill(0); // "生"の白色
        rect(col*w, row*w, w, w);
      }
    }
    //println();
  }
}

// 各面の次の生死を決定する
void next_step(int [][] pos){
  int [][] pos_tmp = new int[N][N];
  int around = 0;
  int row_tmp, col_tmp;

  for(int row=0; row<N; row++){
    for(int col=0; col<N; col++){
      pos_tmp[row][col] = pos[row][col];
    }
  }
  for(int row=0; row<N; row++){
    for(int col=0; col<N; col++){
      around = 0;
      for(int i=-1; i<=1; i++){
        row_tmp = row;
        if(row_tmp+i < 0)
          row_tmp = N;
        if(row_tmp+i == N)
          row_tmp = -1;
        row_tmp = row_tmp + i % N;
        for(int j=-1; j<=1; j++){
          col_tmp = col;
          if(col_tmp+j < 0)
            col_tmp = N;
          if(col_tmp+j == N)
            col_tmp = -1;
          col_tmp = col_tmp + j % N;

          //println("(" + row + ", " + col + ") -> " + "(" + row_tmp + ", " + col_tmp + ")");
          
          if(!(i==0 && j==0))
            around += pos_tmp[row_tmp][col_tmp];
        }
      }
      //print("(" + row + ", " + col + "): " + around);
      //println();

      if(around == 2){  // S=2, 現在の状態を維持する
        pos[row][col] = pos_tmp[row][col];
      }
      else if(around == 3){  // S=3, 自分が「生」になる
        pos[row][col] = 1;
      }
      else{  // S=それ以外, 自分は「死」になる
        pos[row][col] = 0;
      }
    }
  }
}