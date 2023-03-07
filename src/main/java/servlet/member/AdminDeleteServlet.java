package servlet.member;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.FilmController;
import controller.MemberController;
import model.FilmDTO;
import model.MemberDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminDeleteServlet", value = "/admin/delete")
public class AdminDeleteServlet extends HttpServlet {
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
            MemberController memberController = new MemberController(connectionMaker);
            MemberDTO memberDTO = memberController.selectOne(id);

            if (memberDTO == null || logIn.getLevel() != 3) {
                throw new NullPointerException();
            }

            memberController.delete(id);
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
