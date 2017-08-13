package com.jirawat.springdemo.services;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

/**
 * @author juttayaya
 */
@RestController
public class HelloWorldController {
    @RequestMapping("/helloworld")
    public HttpEntity<HelloWorld> helloWorld() {
        final HelloWorld helloWorld = new HelloWorld();
        helloWorld.add(linkTo(methodOn(HelloWorldController.class).helloWorld()).withSelfRel());

        return new ResponseEntity<>(helloWorld, HttpStatus.OK);
    }
}
