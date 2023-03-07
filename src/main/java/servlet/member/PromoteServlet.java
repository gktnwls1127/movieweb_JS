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

@WebServlet(name = "PromoteServlet", value = "/member/promote")
public class PromoteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        HttpSession session = request.getSession();

        JsonObject resp = new JsonObject();
        String status = "";
        String message = "";
        String nextPath = "";

        try {
            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            MemberController memberController = new MemberController(connectionMaker);

            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
            MemberDTO memberDTO = memberController.selectOne(logIn.getId());
            int newLevel = Integer.parseInt(request.getParameter("level"));

            memberDTO.setUpgradeLevel(newLevel);
            memberController.updateLevel(memberDTO);

            status = "success";
            message = "성공적으로 등업신청이 완료되었습니다.";
            nextPath = "/index.jsp";

        } catch (Exception e) {
            status = "error";
            message = "오류가 발생하였습니다.";
            nextPath = "/member/promote.jsp";
        }

        resp.addProperty("status", status);
        resp.addProperty("message", message);
        resp.addProperty("nextPath", nextPath);
        writer.print(resp);
    }
}
