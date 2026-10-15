package com.streetbite.automation.tests;

import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.streetbite.automation.base.BaseTest;
import org.junit.jupiter.api.Test;

class HomeTest extends BaseTest {

    private static final int SWIPES = 3;

    @Test
    void mealsGridScrolls() {
        loginAsConfiguredUser();
        String before = driver.getPageSource();
        for (int i = 0; i < SWIPES; i++) {
            swipeUp();
        }
        assertNotEquals(before, driver.getPageSource());
        assertTrue(isShown(ADD_TO_CART));
    }
}
