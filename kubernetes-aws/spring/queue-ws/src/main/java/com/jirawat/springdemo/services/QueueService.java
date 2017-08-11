package com.jirawat.springdemo.services;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.hateoas.ResourceSupport;

/**
 * @author juttayaya
 */
public class QueueService extends ResourceSupport {
    private final String serverInfo;

    @JsonCreator
    public QueueService(@JsonProperty("serverInfo") final String serverinfoInput) {
        this.serverInfo = serverinfoInput;
    }

    public String getServerInfo() {
        return this.serverInfo;
    }
}
