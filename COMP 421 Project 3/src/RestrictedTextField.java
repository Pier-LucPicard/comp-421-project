import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public class RestrictedTextField extends PlainDocument{

	private static final long serialVersionUID = 2152400146422831135L;
	private int limit=100;
	
	public RestrictedTextField(int limit){
		this.limit=limit;
	}
	
	@Override
	public void insertString(int offs, String str, AttributeSet a) throws BadLocationException {
		if(str==null)
			return;
		if((getLength()+str.length())<=limit)
			super.insertString(offs, str, a);
	}
	
}