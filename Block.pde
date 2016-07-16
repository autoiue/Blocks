public class Block{

	private int x, y, w, h;
	private List<InNode> in, control;
	private List<OutNode> out, feedback;
	
	public Block(int x,int y,int w,int h){
		this.x = 2*x;
		this.y = 2*y;
		this.w = 2*w;
		this.h = 2*h;

		in 		= new ArrayList<InNode>();
		out 	= new ArrayList<OutNode>();
		control = new ArrayList<InNode>();
		feedback = new ArrayList<OutNode>();


		for(int i = 1; i < random(0, h*1.8); i++){in.add(new InNode<Boolean>("content", false));}
		for(int i = 1; i < random(0, h*1.8); i++){out.add(new OutNode<Boolean>("product", false));}
		for(int i = 1; i < random(0, w*1.8); i++){control.add(new InNode<Boolean>("control", false));}
		for(int i = 1; i < random(0, w*1.8); i++){feedback.add(new OutNode<Boolean>("feedback", false));}
	}

	public void draw(float gridSize){

		fill(#37474F);
		noStroke();
		rect(x*gridSize, y*gridSize, w*gridSize+1, h*gridSize+1);

		stroke(#FFFF00);
		fill(#263238);
		strokeWeight(3);

		int i = 1;
		for(InNode a : in){
			ellipse(x*gridSize, (i+y)*gridSize, gridSize/3, gridSize/3);
			i++;
		}
		i = 1;
		for(InNode a : control){
			ellipse((i+x)*gridSize, y*gridSize, gridSize/3, gridSize/3);
			i++;
		}
		i =1;
		
		stroke(#F57F17);
		for(OutNode a : out){
			ellipse((x+w)*gridSize, (i+y)*gridSize, gridSize/3, gridSize/3);
			i++;
		}
		i = 1;
		for(OutNode a : feedback){
			ellipse((i+x)*gridSize, (h+y)*gridSize, gridSize/3, gridSize/3);
			i++;
		}
	}

	public int getX(){return x;}
	public int getY(){return y;}
	public int getWidth(){return w;}
	public int getHeight(){return h;}

	public int topNodeCount(){return control.size();}
	public int leftNodeCount(){return in.size();}
	public int bottomNodeCount(){return feedback.size();}
	public int rightNodeCount(){return out.size();}
}