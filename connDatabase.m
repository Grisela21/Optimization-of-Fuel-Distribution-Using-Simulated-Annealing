function conn = connDatabase()
    % Load Java classes
    import java.sql.DriverManager;
    import java.sql.Connection;

    % Add the JDBC driver to the Java classpath
    jdbcDriverPath ='C:\Users\CRS\Downloads\sqljdbc_12.6.1.0_enu\sqljdbc_12.6\enu\jars\mssql-jdbc-12.6.1.jre8';
 % Add the JDBC driver to the Java classpath
    javaaddpath(jdbcDriverPath);
    % Database connection parameters
    databaseName = 'SPEED';
    username = 'sa';
    password = 'Db_Sp33d_test';
    server = '130.251.5.104';
    port = '1433';

    % JDBC URL
    jdbcUrl = sprintf('jdbc:sqlserver://%s:%s;databaseName=%s;encrypt=true;TrustServerCertificate=true;', server, port, databaseName);

    % Print JDBC URL for debugging
    disp(['JDBC URL: ', jdbcUrl]);

    driver = 'com.microsoft.sqlserver.jdbc.SQLServerDriver';
    try
        java.lang.Class.forName(driver);
        disp('Driver loaded successfully.');
    catch e
        disp('Error loading driver:');
        disp(e.message);
    end

    % Establish the database connection
    try
        conn = DriverManager.getConnection(jdbcUrl, username, password);
        fprintf('Connection successful.\n');
    catch e
        error('Connection failed. Error message: %s', e.message);
    end

    % Return the connection object
    return
end
