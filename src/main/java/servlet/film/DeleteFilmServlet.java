package servlet.film;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.FilmController;
import model.FilmDTO;
import model.MemberDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteFilmServlet", value = "/film/delete")
public class DeleteFilmServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();

        JsonObject resp = new JsonObject();
        String status = "";

        try {
            HttpSession session = request.getSession();
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            FilmController filmController = new FilmController(connectionMaker);
            FilmDTO filmDTO = filmController.selectOne(id);

            if (filmDTO == null || logIn.getLevel() != 3) {
                throw new NullPointerException();
            }

            filmController.delete(id);
            status = "success";

        } catch (Exception e) {
            status = "fail";
        }

        resp.addProperty("status", status);
        writer.print(resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
