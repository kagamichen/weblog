package org.chen.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.chen.handle.CustomAccessDecisionManager;
import org.chen.handle.CustomFilterInvocationSecurityMetadataSource;
import org.chen.handle.LogoutHandler;
import org.chen.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class MySecurityConfig extends WebSecurityConfigurerAdapter {
    private static final Logger logger = LoggerFactory.getLogger(MySecurityConfig.class);
    @Autowired
    UserService userService;

    @Bean
    PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService);
    }

    /**
     * 角色继承
     *
     * @return
     */

    @Bean
    CustomFilterInvocationSecurityMetadataSource cfisms() {
        return new CustomFilterInvocationSecurityMetadataSource();
    }

    @Bean
    CustomAccessDecisionManager cadm() {
        return new CustomAccessDecisionManager();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/css/**", "/js/**", "/index.html", "/img/**", "/fonts/**", "/favicon.ico");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
                    @Override
                    public <O extends FilterSecurityInterceptor> O postProcess(O object) {
                        object.setSecurityMetadataSource(cfisms());
                        object.setAccessDecisionManager(cadm());
                        return object;
                    }
                })
                .and().formLogin().loginProcessingUrl("/doLogin")//ajax调用登录接口。
                .usernameParameter("username")//参数
                .passwordParameter("password")
                .successHandler(new AuthenticationSuccessHandler() {//登录成功后返回json
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
                        Object principal = authentication.getPrincipal();
                        httpServletResponse.setContentType("application/json;charset=utf-8");
                        httpServletResponse.setStatus(200);
                        PrintWriter writer = httpServletResponse.getWriter();
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("status", 200);
                        map.put("msg", principal);
                        ObjectMapper om = new ObjectMapper();
                        writer.write(om.writeValueAsString(map));
                        writer.flush();
                        writer.close();
                        logger.info("登陆成功");
                    }
                }).failureHandler(new AuthenticationFailureHandler() {//登录失败返回json
            @Override
            public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
                response.setContentType("application/json;charset=utf-8");
                PrintWriter writer = response.getWriter();
                ObjectMapper om = new ObjectMapper();
                response.setStatus(401);
                HashMap<String, Object> map = new HashMap<>();
                map.put("status", 401);
                map.put("msg", "验证失败");
                writer.write(om.writeValueAsString(map));
                writer.flush();
                writer.close();
                logger.info("退出成功");
            }
        })
                .permitAll()//登陆接口不需要认证
                .and().logout().logoutUrl("/logout").logoutSuccessHandler((request, response, authentication) -> {
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("status", 200);
            map.put("msg", "退出成功");
            map.put("data", authentication);
            response.setContentType("application/json;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.write(objectMapper.writeValueAsString(map));
            out.flush();
            out.close();
            logger.info("退出成功");
        })
                .permitAll().and()
                .csrf().disable();//关闭csrf 解决跨域问题
http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write("{\"code\": \"403\", \"msg\": \"权限不足\"}");
    }
});
    }


}
