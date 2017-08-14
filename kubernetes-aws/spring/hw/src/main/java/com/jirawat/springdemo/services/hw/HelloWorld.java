package com.jirawat.springdemo.services.hw;

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
    @JsonProperty("msg")
    private final String msg;

    @JsonProperty("hostName")
    private final String hostName;

    @JsonProperty("hostAddress")
    private final String hostAddress;

    @JsonProperty("hostDate")
    private final String hostDate;

    @JsonCreator
    HelloWorld() {
        this.msg = "Hello World";
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

    String getMsg() {
        return msg;
    }

    String getHostName() {
        return this.hostName;
    }

    String getHostAddress() {
        return this.hostAddress;
    }

    String getHostDate() {
        return this.hostDate;
    }
}
