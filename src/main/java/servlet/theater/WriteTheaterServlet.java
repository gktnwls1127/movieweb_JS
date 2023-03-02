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

@WebServlet(name = "WriteTheaterServlet", value = "/theater/write")
public class WriteTheaterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonObject object = new JsonObject();
        String message= "";

        try {
            HttpSession session = request.getSession();
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
            if (logIn.getLevel() != 3){
                response.sendRedirect("/theater/printList.jsp");
            }

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            TheaterController theaterController = new TheaterController(connectionMaker);
            TheaterDTO theaterDTO = new TheaterDTO();

            theaterDTO.setTheaterName(request.getParameter("theaterName"));
            theaterDTO.setTheaterPlace(request.getParameter("theaterPlace"));
            theaterDTO.setTheaterNumber(request.getParameter("theaterNumber"));

            theaterController.insert(theaterDTO);
            object.addProperty("status", "success");
        } catch (Exception e) {
            message = "오류가 발생하였습니다.";
            object.addProperty("status", "fail");
            object.addProperty("message", message);
        }

        PrintWriter writer = response.getWriter();
        writer.print(object);

    }
}
