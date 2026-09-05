package vn.iotstar.configs;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

@WebFilter(urlPatterns = {"/profile*", "/home*", "/product*"})
public class SitemeshFilter implements Filter {

    private static final String DECORATOR = "/common/web/decorator.jsp";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        if (uri.contains("/api/") || uri.contains("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        CharResponseWrapper wrapper = new CharResponseWrapper(res);
        chain.doFilter(request, wrapper);

        String content = wrapper.toString();

        if (res.getContentType() != null && res.getContentType().contains("text/html")) {
            String title = extract(content, "<title>(.*?)</title>");
            String head = extract(content, "<head>(.*?)</head>");
            String body = extract(content, "<body[^>]*>(.*?)</body>");

            req.setAttribute("title", title);
            req.setAttribute("head", head);
            req.setAttribute("body", body);

            req.getRequestDispatcher(DECORATOR).forward(request, response);
        } else {
            response.getWriter().write(content);
        }
    }

    @Override
    public void destroy() {}

    private String extract(String html, String regex) {
        Pattern pattern = Pattern.compile(regex, Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(html);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return "";
    }

    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private CharArrayWriter charWriter;
        private PrintWriter printWriter;

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
            charWriter = new CharArrayWriter();
            printWriter = new PrintWriter(charWriter);
        }

        @Override
        public PrintWriter getWriter() {
            return printWriter;
        }

        @Override
        public String toString() {
            return charWriter.toString();
        }
    }
}
