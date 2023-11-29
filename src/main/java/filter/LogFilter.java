package filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class LogFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
        System.out.println("WebMarket 초기화...");
    }

    public void doFilter(ServletRequest request,ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
        System.out.println(" 접속한 클라이언트 IP : " + request.getRemoteAddr());
        long start = System.currentTimeMillis();
        System.out.println(" 접근한 클라이언트 IP " + request.getRemoteAddr());
        System.out.println(" 요청 처리 시작 시각 : " + getCurrentTime());
        System.out.println("============================================================================");
    }

    public void destroy() {

    }

    private String getURLPath(ServletRequest request) {
        HttpServletRequest req;
        String currentPath="";
        String queryString="";
        if (request instanceof HttpServletRequest) {
            req=(HttpServletRequest) request;
            currentPath = req.getRequestURI();
            queryString = req.getQueryString();
            queryString = queryString == null ? "" : "?" + queryString;
        }
        return currentPath+queryString;
    }

    private String getCurrentTime() {
        DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        return formatter.format(calendar.getTime());
    }
}
