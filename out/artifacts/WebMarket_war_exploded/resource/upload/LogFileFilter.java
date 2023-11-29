package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LogFileFilter implements Filter {
    PrintWriter writer = null;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("LogFileFilter초기화...");
        String filename = filterConfig.getInitParameter("filename");

        //파일이 없을 경우
        if(filename == null) {
            throw new ServletException("로그 파일의 이름을 찾을 수 없습니다.");
        }
        try {
//			매개변수로 받는 값이 FileWriter보조스트림을 연결하는데 true값은 파일을 덮어쓰지말고
//			이어서 계속 로그기록을 남기기 위한 속성을 정의한 것이다.
//			PrintWriter주스트림의 매개변수 중 true은 autoFlush를 하라는 뜻이다.
            writer = new PrintWriter(new FileWriter(filename, true), true);
        } catch (IOException e) { e.printStackTrace(); }
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        //요청한 클라이언트의 IP를 얻어오고 있다.
        String clientAddr = request.getRemoteAddr();
        writer.println("접속한 클라이언트 IP :" + clientAddr);
        writer.println("접근한 URL 경로 :" + this.getURLPath(request));

        long start = System.currentTimeMillis();
        writer.println("요청 처리 시작 시각 :" + this.getCurrentTime());

        chain.doFilter(request, response);
        long end = System.currentTimeMillis();
        writer.println("요청 처리 종료 시각 :" + this.getCurrentTime());
        writer.println("요청 처리 소요 시각 :" + (end-start) + "ms");
        writer.println("===============================================");
    }
    @Override
    public void destroy() {
        System.out.println("LogFileFilter해제...");
        writer.close(); //리소스 해제
    }
    public String getCurrentTime() {
        SimpleDateFormat sformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return sformat.format(new Date());
    }
    //URI 경로 가져오기
    public String getURLPath(ServletRequest request) {

        HttpServletRequest hRequest;
        String currentPath = "";
        String queryString = "";

        if(request instanceof HttpServletRequest) {
            hRequest = (HttpServletRequest)request;
            currentPath = hRequest.getRequestURI(); //URI가져오기
            //POST방식이라면 ?, GET방식이라면 getQueryString을 반환
            queryString = (queryString == null) ? "" : "?" + hRequest.getQueryString();
        }
        return currentPath + queryString;
    }
}