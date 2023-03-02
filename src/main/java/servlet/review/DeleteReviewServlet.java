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

@WebServlet(name = "DeleteReviewServlet", value = "/review/delete")
public class DeleteReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        JsonObject object = new JsonObject();
        PrintWriter writer = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            ReviewController reviewController = new ReviewController(connectionMaker);
            ReviewDTO temp = reviewController.selectOne(id);
            if (temp == null || temp.getWriterId() != logIn.getId()) {
                throw new NullPointerException();
            }

            reviewController.delete(id);

            status = "success";

        } catch (Exception e) {
            status = "fail";
        }
        object.addProperty("status", status);
        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
