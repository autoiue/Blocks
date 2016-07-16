public class OutNode<T>{

	private String name;
	private T value;
	
	public OutNode(String name, T value){
		this.name = name;
		this.value = value;
	}

	public T get(){
		return value;
	}

	public void set(T value){
		this.value = value;
	}

}