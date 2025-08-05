package com.smhrd.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// @SpringBootApplication : 해당 클래스의 위치를 기준으로, 하위에 있는 파일을 읽어
// Spring Boot의 설정을 자동적으로 진행하는 클래스

// @ComponentScan : @Controller, @RestController, @Service, @Repository


@SpringBootApplication
public class wlbex2Application {

	public static void main(String[] args) {
		SpringApplication.run(wlbex2Application.class, args);
	}

}
