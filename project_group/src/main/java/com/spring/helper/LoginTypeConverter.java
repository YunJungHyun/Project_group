package com.spring.helper;


import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

@Configuration
public class LoginTypeConverter implements Converter<String, LoginType> {
   
	@Override
    public LoginType convert(String s) {
		
        return LoginType.valueOf(s.toUpperCase());
    }
}