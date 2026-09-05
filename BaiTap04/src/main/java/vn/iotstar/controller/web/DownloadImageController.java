package vn.iotstar.controller.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("fname");
		if (fileName == null || fileName.trim().isEmpty() || fileName.equalsIgnoreCase("null")) {
			return;
		}
		File file = new File(Constant.DIR + File.separator + fileName);
		if (file.exists() && file.isFile()) {
			resp.setContentType("image/jpeg");
			try (FileInputStream fis = new FileInputStream(file)) {
				IOUtils.copy(fis, resp.getOutputStream());
			}
		}
	}
}