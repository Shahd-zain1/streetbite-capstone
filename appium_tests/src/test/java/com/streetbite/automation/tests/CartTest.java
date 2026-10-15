package com.streetbite.automation.tests;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.streetbite.automation.base.BaseTest;
import org.junit.jupiter.api.Test;

class CartTest extends BaseTest {

    @Test
    void addingMealShowsSnackBar() {
        loginAsConfiguredUser();
        scrollTo(ADD_TO_CART).click();
        assertTrue(waitFor(SNACK_BAR).isDisplayed());
    }
}
