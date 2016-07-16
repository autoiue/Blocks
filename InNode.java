public class InNode<T>{

	private String name;
	private T value;
	private OutNode<T> parent;
	
	public InNode(String name, T value){
		this.name = name;
		this.value = value;
	}

	public T get(){
		if(parent == null){
			return value;
		}
		return parent.get();
	}

	public void setDefault(T value){
		this.value = value;
	}

	public void link(OutNode<T> parent){
		this.parent = parent;
	}
	public void unlink(){
		this.parent = null;
	}
}