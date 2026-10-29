import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    private final String DB_URL = "jdbc:mysql://localhost:n0m3lo/ESCUELA";
    private final String DB_USER = "root";
    private final String DB_PASS = "tu_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String usuarioForm = request.getParameter("txtUsuario");
        String passwordForm = request.getParameter("txtPassword");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);



            String sql = "SELECT u.id_usuario, u.username, u.activo, r.nombre_rol, " +
                         "COALESCE(a.nombre, p.nombre) AS nombre_persona " +
                         "FROM USUARIO u " +
                         "INNER JOIN ROL r ON u.id_rol = r.id_rol " +
                         "LEFT JOIN ALUMNO a ON u.id_alumno = a.id_alumno " +
                         "LEFT JOIN PROFESOR p ON u.id_profesor = p.id_profesor " +
                         "WHERE u.username = ? AND u.password = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, usuarioForm);
            ps.setString(2, passwordForm); // NOTA: Idealmente las contraseñas deben estar encriptadas (BCrypt/SHA)

            rs = ps.executeQuery();

            if (rs.next()) {

                boolean estaoActivo = rs.getBoolean("activo");

                if (!estaoActivo) {
                    redireccionarConError(request, response, "El usuario se encuentra inactivo. Contacte al administrador.");
                    return;
                }


                String nombreRol = rs.getString("nombre_rol");
                String nombreCompleto = rs.getString("nombre_persona");


                HttpSession session = request.getSession();
                session.setAttribute("idUsuario", rs.getInt("id_usuario"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("rol", nombreRol);
                session.setAttribute("nombreUsuario", nombreCompleto != null ? nombreCompleto : "Usuario del Sistema");


                response.sendRedirect("dashboard.jsp");

            } else {

                redireccionarConError(request, response, "Usuario o contraseña incorrectos.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            redireccionarConError(request, response, "Error interno en el sistema de autenticación.");
        } finally {

            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    private void redireccionarConError(HttpServletRequest request, HttpServletResponse response, String mensajeError)
            throws ServletException, IOException {
        request.setAttribute("errorLogin", mensajeError);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
