package com.digitral.demo;

public final class App {

    private App() {
    }

    public static String greeting() {
        return "Hello from Jenkins Docker Java app";
    }

    public static void main(String[] args) {
        System.out.println(greeting());
        System.out.println("Java version: " + System.getProperty("java.version"));
        System.out.println("Status: OK");
    }
}
