package servlet.member;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.MemberController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ValidateServlet", value = "/member/validate")
public class ValidateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);

        String username = request.getParameter("username");

        boolean result = memberController.validateUsername(username);
        String message;
        if (result) {
            message = "회원가입 가능";
        } else {
            message = "중복된 아이디입니다.";
        }

        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        object.addProperty("status", "success");
        object.addProperty("result", result);
        object.addProperty("message", message);

        System.out.println(object);

        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
