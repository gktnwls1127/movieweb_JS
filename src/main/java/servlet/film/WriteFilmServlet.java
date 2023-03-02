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

@WebServlet(name = "WriteFilmServlet", value = "/film/write")
public class WriteFilmServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn.getLevel() != 3){
            response.sendRedirect("/film/printList.jsp");
        }
        JsonObject object = new JsonObject();

        String savePath="upload"; // 저장하고싶은 파일,
        ServletContext context = request.getSession().getServletContext();//프로젝트 절대경로
        String uploadFilePath = context.getRealPath(savePath);
        String message = "";

        try {
            MultipartRequest multi = new MultipartRequest(request, uploadFilePath, 1024 * 1024 * 5, "UTF-8",
                    new DefaultFileRenamePolicy());

            String title = multi.getParameter("title");
            String summary = multi.getParameter("summary");
            String rating = multi.getParameter("rating");
            String images = multi.getOriginalFileName("images");

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            FilmController filmController = new FilmController(connectionMaker);
            FilmDTO filmDTO = new FilmDTO();

            filmDTO.setTitle(title);
            filmDTO.setSummary(summary);
            filmDTO.setRating(rating);
            filmDTO.setImages("/upload/"+images);

            filmController.insert(filmDTO);

            object.addProperty("status", "success");

        } catch (IOException e){
            message = "최대파일 용량을(5KB)초과하였습니다.";
            object.addProperty("status" , "fail");
            object.addProperty("message", message);
        } catch (Exception e){
            message = "오류가 발생하였습니다.";
            object.addProperty("status", "fail");
            object.addProperty("message", message);
        }

        PrintWriter writer = response.getWriter();
        writer.print(object);
    }
}
