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
import java.util.ArrayList;

@WebServlet(name = "AdminUpgradeServlet", value = "/admin/upgrade")
public class AdminUpgradeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();

        JsonObject resp = new JsonObject();
        String status = "";
        String message = "";

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            MemberController memberController = new MemberController(connectionMaker);
            MemberDTO memberDTO = memberController.selectOne(id);

            ArrayList<MemberDTO> promoteList = memberController.selectUpgrade();

            if (promoteList.contains(memberDTO)) {
                memberDTO.setLevel(memberDTO.getUpgradeLevel());
            }

            memberController.rankUp(memberDTO);

            status = "success";
            message = "성공적으로 등업 완료되었습니다.";

        } catch (Exception e) {
            status = "error";
            message = "오류가 발생하였습니다.";
        }

        resp.addProperty("status", status);
        resp.addProperty("message", message);
        writer.print(resp);
    }
}
