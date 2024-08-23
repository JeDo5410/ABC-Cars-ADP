package com.adp.ABC_Cars_Portal.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig{
	
	
	
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	
		
	@Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http	
        	.csrf(
        			csrf -> csrf.disable()
        	)
        	.authorizeRequests( auth -> {
                auth.requestMatchers("/").permitAll();
                auth.requestMatchers("/css/**").permitAll();
                auth.requestMatchers("/images/**").permitAll();
                auth.requestMatchers("/js/**").permitAll();
                
                auth.requestMatchers("/favicon.*").permitAll();
                auth.requestMatchers("/login").permitAll();
                auth.requestMatchers("/cars").hasAnyRole("Users","Administrator");
                auth.requestMatchers("/profile").hasAnyRole("Users","Administrator");
                auth.requestMatchers("/profile1").hasAnyRole("Users","Administrator");
                auth.requestMatchers("/car_detail").hasAnyRole("Users","Administrator");
                auth.requestMatchers("/users").hasRole("Administrator");
                auth.requestMatchers("/view").hasRole("Administrator");
                auth.requestMatchers("/edit").hasRole("Administrator");
                auth.requestMatchers("/delete").hasRole("Administrator");
                auth.requestMatchers("/all_cars").hasRole("Administrator");
                auth.requestMatchers("/edit_car").hasRole("Administrator");
                auth.requestMatchers("/delete_car").hasRole("Administrator");
                auth.requestMatchers("/edit_car1").hasRole("Users");
                auth.requestMatchers("/deleteCar").hasRole("Users");
        	})
            .formLogin(
                        form -> form
                                .loginPage("/login")
                                .loginProcessingUrl("/login")
                                .failureUrl("/login_error")                                
                                .permitAll()
                                .defaultSuccessUrl("/cars", true)
             )
             .logout(
                        logout -> logout
                                .logoutSuccessUrl("/login")
                                .permitAll(true)

              );
        return http.build();
    }

}
