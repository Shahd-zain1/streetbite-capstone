package com.streetbite.automation.tests;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.streetbite.automation.base.BaseTest;
import org.junit.jupiter.api.Test;

class LoginTest extends BaseTest {

    private static final String UNKNOWN_EMAIL = "nobody@streetbite.test";
    private static final String WRONG_PASSWORD = "WrongPass123";

    @Test
    void validLoginOpensHome() {
        assertTrue(loginAsConfiguredUser().isDisplayed());
    }

    @Test
    void invalidCredentialsShowError() {
        login(UNKNOWN_EMAIL, WRONG_PASSWORD);
        assertTrue(waitFor(SNACK_BAR).isDisplayed());
        assertTrue(isShown(LOGIN_BUTTON));
    }

    @Test
    void emptyFieldsShowValidationErrors() {
        waitFor(LOGIN_BUTTON).click();
        assertTrue(waitFor(labelContaining("Please enter your email")).isDisplayed());
        assertTrue(waitFor(labelContaining("Please enter a password")).isDisplayed());
        assertTrue(isShown(LOGIN_BUTTON));
    }
}
