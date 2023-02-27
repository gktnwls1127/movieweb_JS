package servlet.member;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.MemberController;
import model.MemberDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AuthServlet", value = "/member/auth")
public class AuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        MemberDTO memberDTO = memberController.auth(username, password);

        JsonObject result = new JsonObject();
        if (memberDTO != null){
            HttpSession session = request.getSession();
            session.setAttribute("logIn", memberDTO);

            result.addProperty("result", "success");
        } else {
            result.addProperty("result", "fail");
        }

        PrintWriter writer = response.getWriter();
        writer.print(result);
    }

}
