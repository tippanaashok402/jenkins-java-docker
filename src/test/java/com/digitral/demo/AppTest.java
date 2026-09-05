package com.digitral.demo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class AppTest {

    @Test
    void greetingIsStable() {
        assertEquals("Hello from Jenkins Docker Java app", App.greeting());
    }

    @Test
    void greetingMentionsJenkins() {
        assertTrue(App.greeting().contains("Jenkins"));
    }
}
