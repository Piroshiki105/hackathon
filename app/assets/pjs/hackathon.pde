Block selectedBlock;    //マウスでドラッグしているブロック

final ArrayList<Block> blockList  = new ArrayList<Block>();
final Block[] parretBlocks = new Block[5];

final color RED = color(255, 0, 0);
final color BLUE = color(0, 255, 0);
final color GREEN = color(0, 0, 255);
final color YELLOW = color(255, 255, 0);
final color GRAY = color(200, 200, 200);

//プログラム開始時に一度だけ実行される関数
void setup(){
    size(800,450);
    parretBlocks[0] = new Block("forward", 100, 100, RED, true, false);
    parretBlocks[1] = new Block("turnRight", 100, 150, BLUE, true, false);
    parretBlocks[2] = new Block("turnLeft", 100, 200, GREEN, true, false);
    parretBlocks[3] = new Block("for", 100, 250, YELLOW, true, false);
    
    parretBlocks[4] = new Block("clear", 100, 350, GRAY, false, false);
}

//setup()の後、毎秒６０回呼ばれる関数
void draw(){
    //背景を真っ白に塗りつぶす
    background(255);
    for(Block block : parretBlocks) {
    block.display();
    }
    
    for(Block block : blockList){
        block.display();
    }
}

//マウスが押されたときに呼ばれる関数
void mousePressed(){    
    //ここで逆順に走査しているのはリストの後ろ側にあるブロックの方が
    //画面上では手前にあるブロックであるため
    for(int i = blockList.size()-1; i >= 0; i--){
        Block block = blockList.get(i);
        //マウスがそのブロック内にあれば
        if(block.isPressed()) {
            selectedBlock = block;
            return;
        }
    }
    
    for(Block block : parretBlocks) {
    if(block.isPressed()) {
        if(block.isClonable()) {
        // コピー可能ブロックはコピーしてリスト追加
        Block newBlock = block.clone();
        blockList.add(newBlock);
        selectedBlock = newBlock;
        } else if("clear".equals(block.name)) {
        // クリアボタンはリストをクリア
        blockList.clear();
        }
    }
    }
}

//マウスをドラッグしている間呼ばれる関数
void mouseDragged(){
    if(selectedBlock != null){
    //移動量はカーソルが前フレームから移動した量
    selectedBlock.move(mouseX - pmouseX, mouseY - pmouseY);
    }
}

//マウスが離されたとき呼ばれる関数
void mouseReleased(){
    if(selectedBlock != null){
        for(Block block : blockList){
            if(selectedBlock != block &&  block.canConnect(selectedBlock)){
                block.connectPostBlock(selectedBlock);  //ブロックの接続
            }
        }

        if(selectedBlock.preBlock != null){ //選択しているブロックの上でほかのぶとっくとつながっていて
            if(!selectedBlock.preBlock.canConnect(selectedBlock)){  //それがつながる位置にいなければ
                selectedBlock.disconnectPreBlock(); //ブロックのつながりを解除
            }
        }
        selectedBlock = null;   //ドラッグ終了のため選択されたブロックは必ずnullに
    }
}

String getBlocksInfo() {
    ArrayList<Block> resultList = new ArrayList<Block>();
    for(Block block : blockList) {
        // 先頭のブロックのみ扱う
        if(block.preBlock == null) {
            // 終端にたどり着くまでループ
            ArrayList<Block> tmpList = new ArrayList<Block>();
            Block currentBlock = block;
            do {
                // for文だけ特殊
                if(currentBlock.equals(parretBlocks[3])) {
                    tmpList.add(new Block("startFor"));
                    // TODO ひとまず1つだけ対応させる　次のブロックがないと落ちる
                    currentBlock = currentBlock.postBlock;
                    tmpList.add(currentBlock);
                    tmpList.add(new Block("endFor"));
                } else {
                    tmpList.add(currentBlock);
                }
                currentBlock = currentBlock.postBlock;
            } while(currentBlock != null);
            
            // 最長のものを採用する
            if(resultList.size() < tmpList.size()) {
                resultList = tmpList;
            }
        }
    }

    // ついでに最長の接続以外を消しちゃう TODO forブロックが消える 上手く実装すればここに手を入れる必要はなさそうだが
    blockList.clear();
    blockList.addAll(resultList);

    // 結果リストから文字列生成
    String s = "";
    for(Block block : resultList) {
        if(s.length() > 0) {
        s += ",";
        }
        s += block.name;
    }

    return s;
}

class Block {
    final String name;
    int x, y, w, h;
    static final int DEFAULT_W = 120;
    static final int DEFAULT_H = 30;
    Block preBlock;
    Block postBlock;
    final color rgb;
    final boolean clonable;
    final boolean canHasChildren;
    
    Block(String name){
        this.name = name;
    }

    Block(String name, int x, int y, color rgb, boolean clonable, boolean canHasChildren){
        this(name, x, y, DEFAULT_W, DEFAULT_H, rgb, clonable, canHasChildren);
    }
    
    Block(String name, int x, int y, int w, int h, color rgb, boolean clonable, boolean canHasChildren){
        this.name = name;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;    //現状は決め打ちで
        this.rgb = rgb;
        this.clonable = clonable;
        this.canHasChildren = canHasChildren;
    }
    
    Block clone() {
    return new Block(name, x, y, rgb, clonable, canHasChildren);
    }

    //描画部をここに記述
    void display(){
        fill(rgb);
        rect(x, y, w, h);    //最後の引数は矩形の角の曲がり具合

        fill(0);    //文字色を黒色に
        textAlign(CENTER, CENTER);  //テキストの描画位置をx,yともに真ん中に
        strokeWeight(3);
        stroke(0);
        textSize(20);
        text(name, x + w / 2, y + h / 3);
    }

    void move(int addX, int addY){
        x += addX;
        y += addY;
        //次のブロックが存在していればそれも合わせて移動させる
        if(postBlock != null) postBlock.move(addX, addY);
    }
    //上のブロックに対して、引数に渡されたブロックを「下」に接続します
    void connectPostBlock(Block block){
        //接続関係を設定
        this.postBlock = block;
        block.preBlock = this;

        //複数ブロックの移動の時のために、指定した座標に移動させるのではなく　必ず移動量を指定して移動させるようにする。
        block.move(this.x - block.x, (this.y + this.h) - block.y);
    }

    //上にあるブロックと自分のブロックのつながりを解除
    void disconnectPreBlock(){
        this.preBlock.postBlock = null;
        this.preBlock = null;
    }

    //マウスがブロック内にあるかどうか
    boolean isPressed(){
        return x <= mouseX && mouseX <= x + w && y <= mouseY && mouseY <= y + h;
    }

    //許容する二つのブロックの距離の差
    final int MARGIN = 20;
    boolean canConnect(Block block){
        //yに関しては相手のブロックの「底」と比較するためにhを足すのを忘れないように
        return abs(x - block.x) <= MARGIN && abs(y + h - block.y) <= MARGIN;
    }
    
    boolean isClonable() {
    return clonable;
    }

    boolean equals(Block b) {
        return name.equals(b.name);
    }
}