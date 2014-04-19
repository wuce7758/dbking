package org.sosostudio.dbunifier;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DbConfig {

	private int mode;

	private String databaseDriver;

	private String databaseUrl;

	private String username;

	private String password;

	private String jndi;

	public DbConfig(String databaseDriver, String databaseUrl, String username,
			String password) {
		this.mode = 1;
		this.databaseDriver = databaseDriver;
		this.databaseUrl = databaseUrl;
		this.username = username;
		this.password = password;
	}

	public DbConfig(String databaseDriver, String databaseUrl) {
		this.mode = 2;
		this.databaseDriver = databaseDriver;
		this.databaseUrl = databaseUrl;
	}

	public DbConfig(String jndi) {
		this.mode = 4;
		this.jndi = jndi;
	}

	public DbConfig(String jndi, String username, String password) {
		this.mode = 6;
		this.jndi = jndi;
		this.username = username;
		this.password = password;
	}

	public Connection getConnection() {
		switch (this.mode) {
		case 1: {
			try {
				Class.forName(this.databaseDriver);
				return DriverManager.getConnection(this.databaseUrl,
						this.username, this.password);
			} catch (ClassNotFoundException e) {
				throw new DbUnifierException(e);
			} catch (SQLException e) {
				throw new DbUnifierException(e);
			}
		}
		case 2: {
			try {
				Class.forName(this.databaseDriver);
				return DriverManager.getConnection(this.databaseUrl);
			} catch (ClassNotFoundException e) {
				throw new DbUnifierException(e);
			} catch (SQLException e) {
				throw new DbUnifierException(e);
			}
		}
		case 4: {
			try {
				InitialContext initialContext = new InitialContext();
				DataSource dataSource = (DataSource) initialContext
						.lookup(this.jndi);
				return dataSource.getConnection();
			} catch (NamingException e) {
				throw new DbUnifierException(e);
			} catch (SQLException e) {
				throw new DbUnifierException(e);
			}
		}
		case 6: {
			try {
				InitialContext initialContext = new InitialContext();
				DataSource dataSource = (DataSource) initialContext
						.lookup(this.jndi);
				return dataSource.getConnection(this.username, this.password);
			} catch (NamingException e) {
				throw new DbUnifierException(e);
			} catch (SQLException e) {
				throw new DbUnifierException(e);
			}
		}
		default: {
			throw new DbUnifierException();
		}
		}
	}

}