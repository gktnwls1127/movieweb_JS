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

@WebServlet(name = "RegisterServlet", value = "/member/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");

        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setUsername(username);
        memberDTO.setPassword(password);
        memberDTO.setNickname(nickname);

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);
        boolean result = memberController.insert(memberDTO);

        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        object.addProperty("status", "success");
        object.addProperty("result", result);

        writer.print(object);
    }
}
