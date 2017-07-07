// 0:dead, 1:alive
int N = 30;  // ゲームの盤 32*32
int [][] pos = new int[N][N];  // ゲーム盤
int w;  // 正方形の比率
boolean play = false;  // プレイ状況

void setup() {
  size(500, 500);
  background(0, 0, 0);
  w = width/N;

  // 盤の初期化 
  init_board();
}

void draw() {
  if (play)
    next_step(pos);  // 次の盤面を決定する
  else
    edit_board();  // 盤面の編集をする

  draw_board(pos, w);
}

// 盤面全体を＂死＂で初期化する
void init_board() {
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      pos[i][j] = 0;
    }
  }
}

//盤の編集
void edit_board() {
  if(mousePressed){
    int row = mouseY;
    int col= mouseX;
    row = row/w;
    col = col/w;
    pos[row][col] = 1;
    draw_board(pos, w);
  }
}

// 盤を描画する関数
void draw_board(int [][] pos, int w) {
  for (int row=0; row<N; row++) {
    for (int col=0; col<N; col++) {
      if (pos[row][col] == 1) {
        fill(255, 255, 0); // "生"の黃色
        rect(col*w, row*w, w, w);
      } else {
        fill(0); // "死"の黒色
        rect(col*w, row*w, w, w);
      }
    }
  }
}

// 各面の次の生死を決定する
void next_step(int [][] pos) {
  int [][] pos_tmp = new int[N][N];
  int around = 0;
  int row_tmp, col_tmp;

  for (int row=0; row<N; row++) {
    for (int col=0; col<N; col++) {
      pos_tmp[row][col] = pos[row][col];
    }
  }
  for (int row=0; row<N; row++) {
    for (int col=0; col<N; col++) {
      around = 0;
      for (int i=-1; i<=1; i++) {
        row_tmp = row;
        if (row_tmp+i < 0)
          row_tmp = N;
        if (row_tmp+i == N)
          row_tmp = -1;
        row_tmp = row_tmp + i % N;
        for (int j=-1; j<=1; j++) {
          col_tmp = col;
          if (col_tmp+j < 0)
            col_tmp = N;
          if (col_tmp+j == N)
            col_tmp = -1;
          col_tmp = col_tmp + j % N;

          if (!(i==0 && j==0))
            around += pos_tmp[row_tmp][col_tmp];
        }
      }

      if (around == 2) {  // S=2, 現在の状態を維持する
        pos[row][col] = pos_tmp[row][col];
      } else if (around == 3) {  // S=3, 自分が「生」になる
        pos[row][col] = 1;
      } else {  // S=それ以外, 自分は「死」になる
        pos[row][col] = 0;
      }
    }
  }
}

void keyPressed() {
  if (play && key == ' ') {
    play = false;
    println("Now editing");
  }
  else if (!play && key == ' ') {
    play = true;
    println("Now playing.");
  }
  else if (key == 'q'){
    play = false;
    init_board();
    println("Now editing");
  }
}