package com.hhgx.soft.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
/**
 * 
 * Function: 支持js的跨域请求
 * date: 2017年8月21日 下午1:21:32
 * @author Mr.GoldenWan
 
 */
public class CorsFilter implements Filter {
	 
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
 
    }
 
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
        httpResponse.addHeader("Access-Control-Allow-Origin", "*");
        httpResponse.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
        httpResponse.setHeader("Access-Control-Allow-Methods", "GET, PUT, DELETE, POST");
        filterChain.doFilter(servletRequest, servletResponse);
    }
 
    @Override
    public void destroy() {
 
    }
}
