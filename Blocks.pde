Grid grid;
boolean dragging = false;

void setup(){
	size(1920,1080);
	surface.setResizable(true);

	grid = new Grid(this);
	grid.addBlock(new Block(0,-1,3,2));
	grid.addBlock(new Block(9,8,4,4));

	grid.addBlock(new Block(5,0,3,8));
	grid.addBlock(new Block(9,-2,3,3));
	grid.addBlock(new Block(1,9,6,4));
	grid.addBlock(new Block(10,5,6,2));
}

void draw(){
	background(#263238); // BLUE_GREY._900

	if(dragging){
		grid.drag(new PVector(mouseX - pmouseX, mouseY - pmouseY)); 
	}

	grid.draw();
}

void mousePressed(){
	dragging = true;
}

void mouseReleased(){
	dragging = false;
	grid.click();
}

void mouseWheel(MouseEvent e){
	grid.zoom(e.getCount());
}
