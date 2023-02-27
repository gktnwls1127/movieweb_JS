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
import java.text.SimpleDateFormat;

@WebServlet(name = "MemberPrintOneServlet", value = "/member/printOne")
public class MemberPrintOneServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();

        HttpSession session = request.getSession();

        String message = "";
        String nextPath = "";
        try {
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

            JsonObject memberJson = new JsonObject();
            memberJson.addProperty("id", logIn.getId());
            memberJson.addProperty("username", logIn.getUsername());
            memberJson.addProperty("nickname", logIn.getNickname());
            memberJson.addProperty("level", logIn.getLevel());

            object.addProperty("status", "success");
            object.addProperty("data", memberJson.toString());

        } catch (NullPointerException e) {
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("nextPath", nextPath);
        } catch (Exception e) {
            message = "오류가 발생하였습니다.";
            nextPath = "/index.jsp";
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("nextPath", nextPath);
        }

        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
