import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JRadioButton;
import java.awt.GridLayout;
import javax.swing.JList;
import javax.swing.JOptionPane;

public class InsertUserDialog extends JDialog {

	private final JPanel contentPanel = new JPanel();
	private SearchListener listener;
	private JTextField textEmail;
	private JTextField textFirstName;
	private JTextField textLastName;
	private JTextField textPassword;
	private JTextField textCity;
	private JTextField textCountry;
	private Picker datePicker;
	private JRadioButton btnMale;
	private JRadioButton btnFemale;

	/**
	 * Create the dialog.
	 */
	public InsertUserDialog(SearchListener listener) {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setVisible(true);
		setTitle("Insert User");
		this.listener=listener;
		setBounds(100, 100, 450, 300);
		getContentPane().setLayout(new BorderLayout());
		contentPanel.setBorder(new EmptyBorder(5, 5, 5, 5));
		getContentPane().add(contentPanel, BorderLayout.CENTER);
		contentPanel.setLayout(new GridLayout(5,2));
		{
			JPanel panel = new JPanel();
			contentPanel.add(panel);
			{
				JLabel lblEmail = new JLabel("Email:");
				panel.add(lblEmail);
			}
			{
				textEmail = new JTextField();
				textEmail.setDocument(new RestrictedTextField(320));
				panel.add(textEmail);
				textEmail.setColumns(10);
			}
			{
				JLabel lblPassword = new JLabel("Password:");
				panel.add(lblPassword);
			}
			{
				textPassword = new JTextField();
				textPassword.setDocument(new RestrictedTextField(20));
				panel.add(textPassword);
				textPassword.setColumns(10);
			}
		}
		{
			JPanel panel = new JPanel();
			ButtonGroup group=new ButtonGroup();
			contentPanel.add(panel);
			{
				btnMale = new JRadioButton("male");
				btnMale.setSelected(true);
				panel.add(btnMale);
				group.add(btnMale);
			}
			{
				btnFemale = new JRadioButton("female");
				panel.add(btnFemale);
				group.add(btnFemale);
			}
		}
		{
			JPanel panel = new JPanel();
			contentPanel.add(panel);
			{
				JLabel lblFirstName = new JLabel("First name:");
				panel.add(lblFirstName);
			}
			{
				textFirstName = new JTextField();
				textFirstName.setDocument(new RestrictedTextField(50));
				panel.add(textFirstName);
				textFirstName.setColumns(10);
			}
			{
				JLabel lblLastName = new JLabel("Last name:");
				panel.add(lblLastName);
			}
			{
				textLastName = new JTextField();
				textLastName.setDocument(new RestrictedTextField(50));
				panel.add(textLastName);
				textLastName.setColumns(10);
			}
		}
		{
			JPanel panel = new JPanel();
			contentPanel.add(panel);
			{
				JLabel lblNewLabel = new JLabel("Birth date:");
				panel.add(lblNewLabel);
			}
			{
				datePicker = new Picker();
				panel.add(datePicker);
			}
		}
		{
			JPanel panel = new JPanel();
			contentPanel.add(panel);
			{
				JLabel lblCity = new JLabel("City:");
				panel.add(lblCity);
			}
			{
				textCity = new JTextField();
				textCity.setDocument(new RestrictedTextField(50));
				panel.add(textCity);
				textCity.setColumns(10);
			}
			{
				JLabel lblCountry = new JLabel("Country:");
				panel.add(lblCountry);
			}
			{
				textCountry = new JTextField();
				textCountry.setDocument(new RestrictedTextField(50));
				panel.add(textCountry);
				textCountry.setColumns(10);
			}
		}
		{
			JPanel buttonPane = new JPanel();
			buttonPane.setLayout(new FlowLayout(FlowLayout.RIGHT));
			getContentPane().add(buttonPane, BorderLayout.SOUTH);
			{
				JButton okButton = new JButton("OK");
				okButton.setActionCommand("OK");
				buttonPane.add(okButton);
				okButton.addActionListener(new ActionListener(){
					@Override
					public void actionPerformed(ActionEvent e) {
						validateForm();
					}
				});
			}
		}
	}
	
	private void validateForm(){
		Pattern pattern=Pattern.compile("^[a-zA-Z0-9\\-]+@[a-zA-Z0-9\\-]+\\.[a-zA-Z0-9\\-]+$");
		Matcher matcher=pattern.matcher(getEmail());
		if(matcher.find()){
			this.setVisible(false);
			listener.done();
		}else{
			JOptionPane.showMessageDialog(this, "Invalid email format");
		}
	}
	
	public String getEmail(){
		return textEmail.getText();
	}
	
	public String getFirstName(){
		return textFirstName.getText();
	}
	
	public String getLastName(){
		return textLastName.getText();
	}
	
	public String getCity(){
		return textCity.getText();
	}
	
	public String getCountry(){
		return textCountry.getText();
	}
	
	public String getPassword(){
		return textPassword.getText();
	}
	
	public String getBirthday(){
		return datePicker.getDate();
	}
	
	public char getGender(){
		return btnMale.isSelected()?'m':'f';
	}
}
