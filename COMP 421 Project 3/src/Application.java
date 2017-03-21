import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.sql.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.RowSorter;
import javax.swing.RowSorter.SortKey;
import javax.swing.SortOrder;
import javax.swing.JList;
import javax.swing.AbstractListModel;
import java.awt.ScrollPane;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.ListSelectionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.ActionEvent;
import javax.swing.JButton;

public class Application extends JFrame {

	private JPanel contentPane;
	private JTable table;
	private Connection connection;
	private UserDialog userDiag;
	public static final String CONNECTION="jdbc:postgresql://localhost:5432/postgres";
	public static final String USERNAME="postgres";
	public static final String PASSWORD="test";
	private InsertUserDialog insertDiag;
	private JButton buttonNext;
	private JButton buttonPrevious;
	private int limit=0;
	private String lastSearch="";
	private final static int SEARCH_LIMIT=20;
	private String email="haloed-reason@yahoo.us";

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Application frame = new Application();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Application() {
		setTitle("Project 3");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		JMenu mnFile = new JMenu("File");
		menuBar.add(mnFile);
		
		JMenuItem mntmQuit = new JMenuItem("Quit");
		mntmQuit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		mnFile.add(mntmQuit);
		
		JMenu mnQueries = new JMenu("Queries");
		menuBar.add(mnQueries);
		
		JMenuItem mntmUsers = new JMenuItem("Users");
		mntmUsers.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				queryUsers();
			}
		});
		mnQueries.add(mntmUsers);
		
		JMenuItem mntmConversations = new JMenuItem("Conversations");
		mntmConversations.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				queryConversations();
			}
		});
		mnQueries.add(mntmConversations);
		
		JMenu mnInsert = new JMenu("Insert");
		menuBar.add(mnInsert);
		
		JMenuItem mntmUser = new JMenuItem("User");
		mntmUser.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				insertUser();
			}
		});
		mnInsert.add(mntmUser);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new BorderLayout(0, 0));
		
		table = new JTable();
		table.setAutoCreateRowSorter(true);
		
		JScrollPane scrollPane = new JScrollPane(table);
		contentPane.add(scrollPane, BorderLayout.CENTER);
		
		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.SOUTH);
		
		buttonPrevious = new JButton("Previous");
		buttonPrevious.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				previousPage();
			}
		});
		panel.add(buttonPrevious);
		
		buttonNext = new JButton("Next");
		buttonNext.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				nextPage();
			}
		});
		panel.add(buttonNext);
	}
	
	private void previousPage(){
		if(limit>0)
			limit-=SEARCH_LIMIT;
		if(lastSearch.equals("users"))
			executeUsersQuery();
	}
	
	private void nextPage(){
		limit+=SEARCH_LIMIT;
		if(lastSearch.equals("users"))
			executeUsersQuery();
	}
	
	private void insertUser(){
		insertDiag = new InsertUserDialog(new SearchListener(){
			@Override
			public void done() {
				try{
					connection=DriverManager.getConnection(Application.CONNECTION, Application.USERNAME, Application.PASSWORD);
					PreparedStatement stmt=connection.prepareStatement("SELECT email FROM Users WHERE email=?");
					stmt.setString(1, insertDiag.getEmail());
					stmt.execute();
					if(stmt.getResultSet().next()){
						JOptionPane.showMessageDialog(null, "A user with this email already exists");
					}else{
						stmt=connection.prepareStatement("INSERT INTO Location Select ?, ? WHERE NOT EXISTS (SELECT * FROM Location WHERE city=? AND country=?)");
						stmt.setString(1,  insertDiag.getCity());
						stmt.setString(2, insertDiag.getCountry());
						stmt.setString(3,  insertDiag.getCity());
						stmt.setString(4, insertDiag.getCountry());
						stmt.execute();
						stmt=connection.prepareStatement("INSERT INTO Users (email, first_name, last_name, birthday, password, gender, city, country) VALUES (?,?,?,?,?,?,?,?)");
						stmt.setString(1, insertDiag.getEmail());
						stmt.setString(2, insertDiag.getFirstName());
						stmt.setString(3, insertDiag.getLastName());
						stmt.setDate(4, Date.valueOf(insertDiag.getBirthday()));
						stmt.setString(5, insertDiag.getPassword());
						stmt.setString(6, insertDiag.getGender()+"");
						stmt.setString(7, insertDiag.getCity());
						stmt.setString(8, insertDiag.getCountry());
						stmt.execute();
						Vector<String> user=new Vector<String>(Arrays.asList(new String[]{insertDiag.getEmail(), insertDiag.getFirstName(), insertDiag.getLastName(),
								insertDiag.getBirthday(), insertDiag.getPassword(), insertDiag.getGender()+"", insertDiag.getCity(), insertDiag.getCountry()}));
						Vector<Vector<String>>users=new Vector<Vector<String>>();
						users.add(user);
						displayUsers(users);
					}
					connection.close();
				}catch(Exception e){e.printStackTrace();}
				insertDiag.dispose();
			}
		});
	}
	
	private void queryConversations(){
		try{
			lastSearch="conversations";
			String email=JOptionPane.showInputDialog("Enter the user's email:");
			connection=DriverManager.getConnection(Application.CONNECTION, Application.USERNAME, Application.PASSWORD);
			PreparedStatement statement=connection.prepareStatement("SELECT convo_id, email, content FROM Message WHERE email=? and convo_id IN"
					+ "(SELECT convo_id FROM PartOf WHERE email=?)");
			statement.setString(1, email);
			statement.setString(2,  email);
			statement.execute();
			ResultSet set=statement.getResultSet();
			Vector<String> cols=new Vector<String>(Arrays.asList(new String[]{"convo_id","email","content"}));
			Vector<Vector<String>> rows=new Vector<Vector<String>>();
			while(set.next()){
				Vector<String> row=new Vector<String>();
				row.add(set.getString("convo_id"));
				row.add(set.getString("email"));
				row.add(set.getString("content"));
				rows.add(row);
			}
			table.setModel(new DefaultTableModel(rows, cols));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private void queryUsers(){
		userDiag = new UserDialog(new SearchListener(){
			@Override
			public void done(){
				limit=0;
				executeUsersQuery();
			}
		});
	}
	
	private void executeUsersQuery(){
		lastSearch="users";
		try{
			connection=DriverManager.getConnection(Application.CONNECTION, Application.USERNAME, Application.PASSWORD);
			PreparedStatement statement=connection.prepareStatement("SELECT * FROM Users WHERE email LIKE ? ORDER BY email LIMIT ? OFFSET ?");
			statement.setString(1, "%"+userDiag.getEmail()+"%");
			statement.setInt(2, SEARCH_LIMIT);
			statement.setInt(3,  limit);
			statement.execute();
			ResultSet set=statement.getResultSet();
			Vector<Vector<String>> rows=new Vector<Vector<String>>();
			boolean rowFound=false;
			while(set.next()){
				rowFound=true;
				Vector<String> row=new Vector<String>();
				row.addAll(Arrays.asList(new String[]{set.getString("email"), set.getString("first_name"), set.getString("last_name"),
						set.getString("birthday"), set.getString("password"), set.getString("gender"),set.getString("city"), set.getString("country")}));
				rows.add(row);
			}
			if(!rowFound && limit>0)
				limit-=20;
			else
				displayUsers(rows);
		}catch(Exception e){e.printStackTrace();}
	}
	
	private void displayUsers(Vector<Vector<String>> rows){
		Vector<String> cols=new Vector<String>(Arrays.asList(new String[]{"email", "first name", "last_name", "birthday", "password", "gender", "city", "country"}));
		table.setModel(new DefaultTableModel(rows, cols));
	}

}
