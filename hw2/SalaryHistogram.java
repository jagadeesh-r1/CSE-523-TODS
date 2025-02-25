package todb;
import java.sql.*;

public class SalaryHistogram {

    public static void main(String[] args) {
        double starting_range = Double.parseDouble(args[0]);
        double ending_range = Double.parseDouble(args[1]);
        int number_of_bins = Integer.parseInt(args[2]);
        String username = args[3];
        String password = args[4];
        String database_name = "jdbc:db2://localhost:25000/sample";

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try {
            Class.forName("com.ibm.db2.jcc.DB2Driver"); //JDBC driver module
            connection = DriverManager.getConnection(database_name, username, password);
            String query = "SELECT salary FROM JAGAD.EMPLOYEE WHERE salary >= " + starting_range + " AND salary < " + ending_range + " ORDER BY salary";

            statement = connection.createStatement();
            resultset = statement.executeQuery(query);

            double bin_width = (ending_range - starting_range) / number_of_bins;
            double bin_start = starting_range;
            double bin_end = bin_start + bin_width;
            int i = 1;
            int bin_count = 0;


            while (resultset.next()) {
                double currentSalary = resultset.getDouble("salary");

                if (currentSalary >= bin_end) {
                    if (bin_count > 0) {
                        System.out.println("binnum:" + i + " | frequency: " + bin_count + " | binstart: " + bin_start + " | binend: " + bin_end);
                    }

                    i++;
                    bin_count = 0;
                    bin_start = bin_end;
                    bin_end = bin_start + bin_width;
                }

                bin_count++;
            }

            if (bin_count > 0) {
                System.out.println("binnum:" + i + " | frequency: " + bin_count + " | binstart: " + bin_start + " | binend: " + bin_end);
            }

        } catch (SQLException error) {
            error.printStackTrace();
        } catch (Exception error) {
            error.printStackTrace();
        } finally {
            try {
                if (resultset != null) {
                	resultset.close();
                }
                if (statement != null) {
                	statement.close();
                }
                if (connection != null) {
                	connection.close();
                }
            } 
            catch (Exception error) {
                error.printStackTrace();
            }
        }
    }
}