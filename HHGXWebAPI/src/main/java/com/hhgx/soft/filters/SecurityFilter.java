package com.hhgx.soft.filters;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
/**
 * 登录认证的拦截器 
 * @author win
 *
 */
public class SecurityFilter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	        HttpSession session = request.getSession();
	        String user = (String) session.getAttribute("UserID");
	        String curPath=request.getRequestURL().toString();
	        String contextPath=request.getContextPath();
	        if (curPath.indexOf("UserManager/LoginBy")>=0){
	            return true;
	        }
	        
	        if(StringUtils.isEmpty(user)){
	        	//不符合条件的，跳转到登录界面  
	            response.sendRedirect(contextPath+"/static/index.html");
	        	return false;
	        }        
	        return true;
	        
	        
	        }
	/** 
     * Handler执行之后，ModelAndView返回之前调用这个方法 
     */  
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}
	/** 
     * Handler执行完成之后调用这个方法 
     */  
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}


 
      

}