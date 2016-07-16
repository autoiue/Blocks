import java.util.List;
import java.util.ArrayList;

public class Block{

	private int x, y, w, h;
	private List<InNode> contentIn, controlIn;
	private List<OutNode> contentOut, controlOut;
	
	public Block(int x,int y,int w,int h){
		this.x = 2*x;
		this.y = 2*y;
		this.w = 2*w;
		this.h = 2*h;

		contentIn 	= new ArrayList<InNode>();
		contentOut 	= new ArrayList<OutNode>();
		controlIn 	= new ArrayList<InNode>();
		controlOut 	= new ArrayList<OutNode>();


		for(int i = 1; i < Math.random()*(h*1.8); i++){contentIn.add(new InNode<Boolean>("content", false));}
		for(int i = 1; i < Math.random()*(h*1.8); i++){contentOut.add(new OutNode<Boolean>("product", false));}
		for(int i = 1; i < Math.random()*(w*1.8); i++){controlIn.add(new InNode<Boolean>("control", false));}
		for(int i = 1; i < Math.random()*(w*1.8); i++){controlOut.add(new OutNode<Boolean>("feedback", false));}
	}

	public int x(){return x;}
	public int y(){return y;}
	public int w(){return w;}
	public int h(){return h;}

	public int leftNodeCount(){return contentIn.size();}
	public int rightNodeCount(){return contentOut.size();}
	public int topNodeCount(){return controlIn.size();}
	public int bottomNodeCount(){return controlOut.size();}

	public List<InNode> getContentInNodes(){return contentIn;}
	public List<OutNode> getContentOutNodes(){return contentOut;}
	public List<InNode> getControlInNodes(){return controlIn;}
	public List<OutNode> getControlOutNodes(){return controlOut;}
}