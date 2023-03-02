package servlet.theater;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.TheaterController;
import model.MemberDTO;
import model.TheaterDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateTheaterServlet", value = "/theater/update")
public class UpdateTheaterServlet extends HttpServlet {
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
            if (logIn.getLevel() != 3){
                response.sendRedirect("/theater/printList.jsp");
            }

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            TheaterController theaterController = new TheaterController(connectionMaker);
            TheaterDTO theater = theaterController.selectOne(id);

            theater.setTheaterName(request.getParameter("theaterName"));
            theater.setTheaterPlace(request.getParameter("theaterPlace"));
            theater.setTheaterNumber(request.getParameter("theaterNumber"));

            theaterController.update(theater);

            status = "success";
            nextPath = "/theater/printOne.jsp?id=" + id;
            message = "성공적으로 수정되었습니다.";

        } catch (Exception e) {
            status = "error";
            message = "오류가 발생하였습니다.";
            nextPath = "/theater/printList.jsp";

        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);

        writer.print(object);
    }
}
