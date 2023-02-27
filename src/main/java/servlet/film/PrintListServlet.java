package servlet.film;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.FilmController;
import controller.MemberController;
import model.FilmDTO;
import model.MemberDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "PrintListServlet", value = "/film/printList")
public class PrintListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        int pageNo = Integer.parseInt(request.getParameter("pageNo"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);

        ArrayList<FilmDTO> list = filmController.selectPageALl(pageNo);
        int totalPage = filmController.countTotalPage();

        JsonArray array = new JsonArray();

        for (FilmDTO f : list) {
            JsonObject object = new JsonObject();
            object.addProperty("id", f.getId());
            object.addProperty("title", f.getTitle());
            object.addProperty("summary", f.getSummary());
            object.addProperty("rating", f.getRating());
            object.addProperty("image", f.getImages());
            array.add(object);
        }

        JsonObject result = new JsonObject();
        result.addProperty("result" , "success");
        result.addProperty("data", array.toString());
        result.addProperty("totalPage", totalPage);

        PrintWriter writer = response.getWriter();
        writer.print(result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
