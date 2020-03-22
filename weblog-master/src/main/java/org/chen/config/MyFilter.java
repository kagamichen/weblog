//package org.chen.config;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.security.access.ConfigAttribute;
//import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
//
//import java.util.Collection;
//
//public class MyFilter implements FilterInvocationSecurityMetadataSource {
//    private static final Logger logger = LoggerFactory.getLogger(MyFilter.class);
//    @Override
//    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
//      logger.info("Object",object);
//        return null;
//    }
//
//    @Override
//    public Collection<ConfigAttribute> getAllConfigAttributes() {
//        return null;
//    }
//
//    @Override
//    public boolean supports(Class<?> clazz) {
//        return false;
//    }
//}
