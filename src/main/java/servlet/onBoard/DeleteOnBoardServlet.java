package servlet.onBoard;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.FilmController;
import controller.OnBoardController;
import model.FilmDTO;
import model.MemberDTO;
import model.OnBoardDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteOnBoardServlet", value = "/onBoard/delete")
public class DeleteOnBoardServlet extends HttpServlet {
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
            OnBoardController onBoardController = new OnBoardController(connectionMaker);
            OnBoardDTO onBoardDTO = onBoardController.selectOne(id);

            if (onBoardDTO == null || logIn.getLevel() != 3) {
                throw new NullPointerException();
            }

            onBoardController.delete(id);
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
