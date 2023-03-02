package servlet.onBoard;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.OnBoardController;
import controller.TheaterController;
import model.MemberDTO;
import model.OnBoardDTO;
import model.TheaterDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "WriteOnBoardServlet", value = "/onBoard/write")
public class WriteOnBoardServlet extends HttpServlet {
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
                response.sendRedirect("/onBoard/printList.jsp");
            }

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            OnBoardController onBoardController = new OnBoardController(connectionMaker);
            OnBoardDTO onBoardDTO = new OnBoardDTO();

            onBoardDTO.setFilmId(Integer.parseInt(request.getParameter("filmId")));
            onBoardDTO.setTheaterId(Integer.parseInt(request.getParameter("theaterId")));
            onBoardDTO.setRunningTime(request.getParameter("runningTime"));

            onBoardController.insert(onBoardDTO);
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
