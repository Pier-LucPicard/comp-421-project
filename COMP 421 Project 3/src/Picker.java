
import java.util.Date;
import java.util.Properties;

import javax.swing.JFormattedTextField.AbstractFormatter;
import javax.swing.JPanel;
import javax.swing.text.DateFormatter;

import org.jdatepicker.impl.DateComponentFormatter;
import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.UtilDateModel;

public class Picker extends JPanel{
	
	private UtilDateModel model;
	
	public Picker(){
		model=new UtilDateModel();
		model.setValue(new Date());
		Properties p=new Properties();
		p.put("text.today", "Today");
		p.put("text.month", "Month");
		p.put("text.year", "Year");
		JDatePanelImpl pan=new JDatePanelImpl(model, p);
		JDatePickerImpl picker=new JDatePickerImpl(pan, new DateComponentFormatter());
		add(picker);
	}
	
	public String getDate(){
		String month=model.getMonth()+"";
		if(model.getMonth()<10)
			month="0"+month;
		String day=model.getDay()+"";
		if(model.getDay()<10)
			day="0"+day;
		return model.getYear()+"-"+month+"-"+day;
	}
}
