package com.jirawat.springdemo.services;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.hateoas.ResourceSupport;

import java.util.Date;

/**
 * @author juttayaya
 */
public class QueueService extends ResourceSupport {
    @JsonProperty("hostName")
    private final String hostName;

    @JsonProperty("hostAddress")
    private final String hostAddress;

    @JsonProperty("hostDate")
    private final String hostDate;

    @JsonCreator
    QueueService(final String hostNm, final String hostAddr) {
        this.hostName = hostNm;
        this.hostAddress = hostAddr;
        this.hostDate = new Date().toString();
    }

    public String getHostName() {
        return this.hostName;
    }

    public String getHostAddress() {
        return hostAddress;
    }

    public String getHostDate() {
        return hostDate;
    }
}
