package servlet.review;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.ReviewController;
import model.MemberDTO;
import model.ReviewDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "WriteReviewServlet", value = "/review/write")
public class WriteReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        JsonObject object = new JsonObject();

        try {
            int filmId = Integer.parseInt(request.getParameter("filmId"));
            int writerId = logIn.getId();

            ReviewDTO r = new ReviewDTO();
            r.setWriterId(writerId);
            r.setFilmId(filmId);
            r.setScore(Integer.parseInt(request.getParameter("score")));
            r.setReview(request.getParameter("review"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            ReviewController reviewController = new ReviewController(connectionMaker);
            reviewController.insert(r);

            object.addProperty("status", "success");

        } catch (Exception e) {
            object.addProperty("status" , "fail");
        }

        PrintWriter writer = response.getWriter();
        writer.print(object);
    }
}
