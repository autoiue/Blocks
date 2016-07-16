import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

float GRID_SIZE = 50f;

int offsetX = 0;
int offsetY = 0;

int boundMinX,boundMaxX,boundMinY,boundMaxY, x, y = 0;

boolean dragging = false;

List<Block> blocks;

void setup(){
	size(1080,1080);
	surface.setResizable(true);

	blocks = new ArrayList<Block>();
	blocks.add(new Block(0,-1,3,2));
	blocks.add(new Block(9,8,4,4));

	blocks.add(new Block(5,0,3,8));
	blocks.add(new Block(9,-2,3,3));
	blocks.add(new Block(1,9,6,4));
	blocks.add(new Block(10,5,6,2));
}

void draw(){
	background(#263238); // BLUE_GREY._900
	stroke(#DD2C00); // DEEP_ORAGE.A700

	if(dragging){
		offsetX += mouseX - pmouseX;
		offsetY += mouseY - pmouseY; 
	}

	int gmousex = Math.round((mouseX - offsetX)/GRID_SIZE);
	int gmousey = Math.round((mouseY - offsetY)/GRID_SIZE);

	int[][] multi = new int[5][10];

	boundMinX = Math.round(-offsetX/GRID_SIZE);
	boundMaxX = Math.round((-offsetX+width)/GRID_SIZE);
	boundMinY = Math.round(-offsetY/GRID_SIZE);
	boundMaxY = Math.round((-offsetY+height)/GRID_SIZE);

	for (Block b : blocks) {
		if(b.getX() < boundMinX) boundMinX = b.getX();
		if(b.getX() + b.getWidth() > boundMaxX) boundMaxX = b.getX() + b.getWidth();
		if(b.getY() < boundMinY) boundMinY = b.getY();
		if(b.getY() + b.getHeight() > boundMaxY) boundMaxY = b.getY() + b.getHeight();
	}

	boundMinX -= 3;
	boundMinY -= 3;
	boundMaxX += 3;
	boundMaxY += 3;

	int[][] map = new int[boundMaxX-boundMinX][boundMaxY-boundMinY];

	for (Block b : blocks) {
		for(int bx = b.getX(); bx <= b.getX() + b.getWidth(); bx++){
			int x = bx - b.getX();
			for(int by = b.getY(); by <= b.getY() + b.getHeight(); by++){
				int y = by - b.getY();
				map[bx-boundMinX][by-boundMinY] = 1;
				if(x == 0 && y != 0 && y <= b.leftNodeCount()) map[bx-boundMinX][by-boundMinY] = 2; // 2 IN
				if(x == b.getWidth() && y != 0 && y <= b.rightNodeCount()) map[bx-boundMinX][by-boundMinY] = 3; // 3 OUT
				if(y == 0 && x != 0 && x <= b.topNodeCount()) map[bx-boundMinX][by-boundMinY] = 2; // 2 IN
				if(y == b.getHeight() && x != 0 && x <= b.bottomNodeCount()) map[bx-boundMinX][by-boundMinY] = 3; // 3 OUT
			}
		}
	}

	for(int x = Math.round(0 + offsetX % (2*GRID_SIZE) - GRID_SIZE); x < width + GRID_SIZE; x += 2*GRID_SIZE){
		for(int y = Math.round(0 + offsetY % (2*GRID_SIZE) - GRID_SIZE); y < height + GRID_SIZE; y += 2*GRID_SIZE){
			if(GRID_SIZE < 31){
				strokeWeight(2);
				point(x,y);
			}else{
				strokeWeight(1);
				line(x-1,y,x+1,y);
				line(x,y-1,x,y+1);
			}
		}
	}

	translate(offsetX, offsetY);


	noStroke();
	for(Block b : blocks){
		b.draw(GRID_SIZE);
	}

	fill(255, 0, 0);
	stroke(255,0,0);

	strokeWeight(1);
	for(int x = 0; x < map.length; x ++){
		for (int y = 0; y < map[0].length; y++) {
			//text(map[x][y], (0.1+x+boundMinX)*GRID_SIZE, (0.1+y+boundMinY)*GRID_SIZE);
		}
	}


	stroke(#00E676); // GREEN.A400
	stroke(#FF3D00); // GREEN.A400


	drawAStarPath(map, x-boundMinX, y-boundMinY, gmousex-boundMinX, gmousey-boundMinY, map[x-boundMinX][y-boundMinY]);
	if(mousePressed){
		x = gmousex;
		y = gmousey;
		println(map[gmousex-boundMinX][gmousey-boundMinY]);
	}
	stroke(#F50057); // jesaispal.A400
}

void mousePressed(){
	dragging = true;
}

void mouseReleased(){
	dragging = false;
}

class Square{
	public int x, y, px, py, f, g, h;

	Square(int x_, int y_, int px_, int py_, int f_, int g_, int h_){
		x = x_; y = y_; px = px_; py = py_; f = f_; g = g_; h = h_;
	} 
}

void drawAStarPath(final int map[][], int x1, int y1, int x2, int y2, int reppeled){

	int G = 10;
	int Hxf = 10;
	int Hyf = 7;

	Map<String,Square> open = new HashMap<String,Square>();
	Map<String,Square> closed = new HashMap<String,Square>();

	open.put(x1+":"+y1, new Square(x1, y1, x1, y1, 0, 0, 0));
	Square current = null;

	if(map[x1][y1] == 1 || map[x2][y2] == 1) return;

	while(true){

		Integer min = null;
		current = null;

		for(Square s : open.values()){if(current == null || s.f < min){current = s; min = s.f;}}
		if(current ==  null) return;
		

		open.remove(current.x+":"+current.y);
		closed.put(current.x+":"+current.y, current);

		if(current.x == x2 && current.y == y2){
			break; // FOUND
		}else{
			for(int i = 0; i < 4; i++){
				int x = (i == 0 ? current.x - 1 : (i == 2 ? current.x + 1 : current.x));
				int y = (i == 3 ? current.y - 1 : (i == 1 ? current.y + 1 : current.y));

				if(x < 0 || y < 0 || x > map.length -1 || y > map[0].length -1 || closed.containsKey(x+":"+y)){ // unreachable/treated block, end laps
				}else if(map[x][y] == 1 ||  (x != x2 || y!= y2) && map[x][y] != 0 ||  (x != x1 || y!= y1) && map[x][y] == reppeled){
				}else{
					int h = abs(x2-x)*Hxf+abs(y2-y)*Hyf;
					Square processed = new Square(x, y, current.x, current.y, G+h, G, h);
					open.put(x+":"+y, processed);
				}

			}
		}
	}


	strokeWeight(3);
	while(true){
		line((boundMinX+current.x)*GRID_SIZE, (boundMinY+ current.y)*GRID_SIZE, (boundMinX+ current.px)*GRID_SIZE, (boundMinY+ current.py)*GRID_SIZE);
		current = closed.get(current.px+":"+current.py);
		if(current.x == x1 && current.y == y1){break;}
	}
}

void mouseWheel(MouseEvent e){
	GRID_SIZE += e.getCount();
	GRID_SIZE = Math.min(200, Math.max(20, GRID_SIZE));
}
