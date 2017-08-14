package com.jirawat.springdemo.services.hw;

import org.junit.Test;

import java.util.regex.Pattern;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;

/**
 * @author juttayaya
 */
public class HelloWorldTest {
    private static final Pattern IPV4_PATTERN = Pattern.compile(
            "^(([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.){3}([01]?\\d\\d?|2[0-4]\\d|25[0-5])$");

    @Test
    public void testHelloWorld() {
        final HelloWorld helloWorld = new HelloWorld();

        final String hostAddress = helloWorld.getHostAddress();
        assertThat("Host Address must be a valid IP",
          IPV4_PATTERN.matcher(hostAddress).matches(), is(true));
        assertThat("Host Name must be populated", helloWorld.getHostName(), notNullValue());
        assertThat("Host Date must be populated", helloWorld.getHostDate(), notNullValue());
    }
}
