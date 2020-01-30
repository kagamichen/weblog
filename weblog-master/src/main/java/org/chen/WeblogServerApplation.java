package org.chen;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("org.chen.mapper")
public class WeblogServerApplation {
    public static void main(String[] args) {
        SpringApplication.run(WeblogServerApplation.class,args);
    }
}
