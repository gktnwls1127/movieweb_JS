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

@WebServlet(name = "UpdateOnBoardServlet", value = "/onBoard/update")
public class UpdateOnBoardServlet extends HttpServlet {
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
                response.sendRedirect("/onBoard/printList.jsp");
            }

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            OnBoardController onBoardController = new OnBoardController(connectionMaker);
            OnBoardDTO onBoardDTO = onBoardController.selectOne(id);

            int filmId = Integer.parseInt(request.getParameter("filmId"));

            onBoardDTO.setFilmId(filmId);
            onBoardDTO.setTheaterId(Integer.parseInt(request.getParameter("theaterId")));
            onBoardDTO.setRunningTime(request.getParameter("runningTime"));

            onBoardController.update(onBoardDTO);

            status = "success";
            nextPath = "/onBoard/printOne.jsp?filmId=" + filmId;
            message = "성공적으로 수정되었습니다.";

        } catch (Exception e) {
            status = "error";
            message = "오류가 발생하였습니다.";
            nextPath = "/onBoard/printList.jsp";

        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);

        writer.print(object);
    }
}
