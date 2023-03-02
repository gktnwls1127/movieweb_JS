package servlet.film;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.FilmController;
import model.FilmDTO;
import model.MemberDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateFilmServlet", value = "/film/update")
public class UpdateFilmServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        String nextPath = "";
        String message = "";
        JsonObject object = new JsonObject();
        PrintWriter printWriter = response.getWriter();

        try {
            HttpSession session = request.getSession();
            MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

            String savePath="upload"; // 저장하고싶은 파일,
            ServletContext context = request.getSession().getServletContext();//프로젝트 절대경로
            String uploadFilePath = context.getRealPath(savePath);

            MultipartRequest multi = new MultipartRequest(request, uploadFilePath, 1024 * 1024 * 5, "UTF-8",
                    new DefaultFileRenamePolicy());

            int id = Integer.parseInt(multi.getParameter("id"));

            if (logIn.getLevel() != 3){
                response.sendRedirect("/film/printOne.jsp?id"+ id);
            }

            String title = multi.getParameter("title");
            String summary = multi.getParameter("summary");
            String rating = multi.getParameter("rating");
            String images = multi.getOriginalFileName("images");

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            FilmController filmController = new FilmController(connectionMaker);
            FilmDTO filmDTO = filmController.selectOne(id);

            filmDTO.setTitle(title);
            filmDTO.setSummary(summary);
            filmDTO.setRating(rating);
            filmDTO.setImages("/upload/"+images);

            filmController.update(filmDTO);

            status = "success";
            nextPath = "/film/printOne.jsp?id=" + id;
            message = "성공적으로 수정되었습니다.";

        } catch (IOException e) {
            status = "error";
            nextPath = "/film/printList?pageNo=1";
            message = "최대파일 용량을(5KB)초과하였습니다.";

        } catch (Exception e) {
            status = "error";
            nextPath = "/film/printList?pageNo=1";
            message = "오류가 발생하였습니다.";
        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);

        printWriter.print(object);
    }
}
