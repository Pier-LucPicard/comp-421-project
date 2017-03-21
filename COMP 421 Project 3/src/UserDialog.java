import java.awt.BorderLayout;
import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JCheckBox;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.LayoutStyle.ComponentPlacement;

public class UserDialog extends JDialog {

	private final JPanel contentPanel = new JPanel();
	private SearchListener listener;
	private JTextField textEmail;
	private String email;
	private JLabel lblEmail;
	private JCheckBox checkFollowed;
	private JCheckBox checkFollowing;
	private JCheckBox checkConversation;

	/**
	 * Create the dialog.
	 */
	public UserDialog(SearchListener listener) {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle("Find users");
		this.listener=listener;
		setBounds(100, 100, 400, 300);
		setVisible(true);
		getContentPane().setLayout(new BorderLayout());
		contentPanel.setBorder(new EmptyBorder(5, 5, 5, 5));
		getContentPane().add(contentPanel, BorderLayout.CENTER);
		{
			lblEmail = new JLabel("Email:");
		}
		{
			textEmail = new JTextField();
			textEmail.setColumns(10);
		}
		
		checkFollowed = new JCheckBox("Followed by me");
		
		checkFollowing = new JCheckBox("Following me");
		checkFollowing.setToolTipText("");
		
		checkConversation = new JCheckBox("In conversation with me");
		checkConversation.setToolTipText("");
		contentPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
		contentPanel.add(lblEmail);
		contentPanel.add(textEmail);
		contentPanel.add(checkFollowed);
		contentPanel.add(checkFollowing);
		contentPanel.add(checkConversation);
		{
			JPanel buttonPane = new JPanel();
			buttonPane.setLayout(new FlowLayout(FlowLayout.RIGHT));
			getContentPane().add(buttonPane, BorderLayout.SOUTH);
			{
				JButton okButton = new JButton("OK");
				okButton.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent arg0) {
						email=textEmail.getText();
						UserDialog.this.setVisible(false);
						listener.done();
					}
				});
				okButton.setActionCommand("OK");
				buttonPane.add(okButton);
			}
		}
	}
	
	public String getEmail(){
		return this.email;
	}
	
	public boolean isFollowing(){
		return checkFollowing.isSelected();
	}
	
	public boolean isFollowed(){
		return checkFollowed.isSelected();
	}
	
	public boolean inConversation(){
		return checkConversation.isSelected();
	}
}
