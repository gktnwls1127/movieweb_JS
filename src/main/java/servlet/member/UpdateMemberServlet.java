package servlet.member;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.MemberController;
import controller.OnBoardController;
import model.MemberDTO;
import model.OnBoardDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateMemberServlet", value = "/member/update")
public class UpdateMemberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonObject object = new JsonObject();
        PrintWriter writer = response.getWriter();
        String message= "";
        String status= "";
        String nextPath = "";

        try {
            HttpSession session = request.getSession();
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            MemberController memberController = new MemberController(connectionMaker);
            MemberDTO memberDTO = memberController.selectOne(id);

            if (logIn.getId() != memberDTO.getId()) {
                response.sendRedirect("/index.jsp");
            }

            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");


            if (!oldPassword.equals(newPassword)){
                status = "error";
                message = "비밀번호가 일치하지 않습니다.";
                nextPath = "/member/printOne.jsp?id=" + id;
            }
            else {
                memberDTO.setNickname(request.getParameter("nickname"));
                memberDTO.setPassword(newPassword);

                memberController.update(memberDTO);

                status = "success";
                nextPath = "/member/printOne.jsp?id=" + id;
                message = "성공적으로 수정되었습니다.";
            }


        } catch (Exception e) {
            status = "error";
            message = "오류가 발생하였습니다.";
            nextPath = "/index.jsp";

        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);

        writer.print(object);
    }
}
