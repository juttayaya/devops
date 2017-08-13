package com.jirawat.springdemo.services;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.hateoas.ResourceSupport;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

/**
 * @author juttayaya
 */
class HelloWorld extends ResourceSupport {
    @JsonProperty("hostName")
    private final String hostName;

    @JsonProperty("hostAddress")
    private final String hostAddress;

    @JsonProperty("hostDate")
    private final String hostDate;

    @JsonCreator
    HelloWorld() {
        this.hostName = findHostName();
        this.hostAddress = findHostAddress();
        this.hostDate = new Date().toString();
    }
    
    private String findHostName() {
        try {
            return InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            return "UNKNOWN: " + e.getMessage();
        }
    }

    private String findHostAddress() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            return "UNKNOWN: " + e.getMessage();
        }
    }

}
