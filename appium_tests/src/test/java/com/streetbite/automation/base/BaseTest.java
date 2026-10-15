package com.streetbite.automation.base;

import com.streetbite.automation.config.TestConfig;
import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.android.options.UiAutomator2Options;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.TestInfo;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public abstract class BaseTest {

    protected static final By EDIT_TEXTS = AppiumBy.className("android.widget.EditText");
    protected static final By LOGIN_BUTTON = labelEquals("Log in");
    protected static final By SNACK_BAR = AppiumBy.xpath("//*[@resource-id='app_snackbar']");
    protected static final By ADD_TO_CART =
            AppiumBy.xpath("//*[starts-with(@resource-id,'add_to_cart_')]");

    private static final Duration DEFAULT_WAIT = Duration.ofSeconds(30);
    private static final Duration HOME_WAIT = Duration.ofSeconds(60);
    private static final int MAX_SWIPES = 10;

    protected AndroidDriver driver;

    @BeforeEach
    protected void setUp() throws MalformedURLException {
        Path apk = new File(TestConfig.get("apk.path")).toPath().toAbsolutePath().normalize();
        UiAutomator2Options options = new UiAutomator2Options()
                .setApp(apk.toString())
                .setDeviceName(TestConfig.get("device.name"))
                .setNewCommandTimeout(Duration.ofSeconds(180))
                .setAutoGrantPermissions(true);
        String udid = TestConfig.get("udid");
        if (!udid.isBlank()) {
            options.setUdid(udid);
        }
        driver = new AndroidDriver(URI.create(TestConfig.get("appium.url")).toURL(), options);
    }

    @AfterEach
    protected void tearDown(TestInfo info) throws IOException {
        try {
            saveScreenshot(info.getTestMethod().map(method -> method.getName()).orElse("test"));
        } finally {
            driver.quit();
        }
    }

    protected static By labelEquals(String text) {
        return AppiumBy.xpath("//*[@content-desc='" + text + "' or @text='" + text + "']");
    }

    protected static By labelContaining(String text) {
        return AppiumBy.xpath(
                "//*[contains(@content-desc,'" + text + "') or contains(@text,'" + text + "')]");
    }

    protected WebElement waitFor(By locator) {
        return waitFor(locator, DEFAULT_WAIT);
    }

    protected WebElement waitFor(By locator, Duration timeout) {
        return new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.visibilityOfElementLocated(locator));
    }

    protected boolean isShown(By locator) {
        List<WebElement> found = driver.findElements(locator);
        return !found.isEmpty() && found.get(0).isDisplayed();
    }

    protected void login(String email, String password) {
        waitFor(EDIT_TEXTS);
        List<WebElement> fields = driver.findElements(EDIT_TEXTS);
        type(fields.get(0), email);
        type(fields.get(1), password);
        hideKeyboardQuietly();
        driver.findElement(LOGIN_BUTTON).click();
    }

    protected WebElement loginAsConfiguredUser() {
        login(TestConfig.get("test.email"), TestConfig.get("test.password"));
        return waitFor(labelContaining("Hot Offers"), HOME_WAIT);
    }

    protected void swipeUp() {
        Dimension size = driver.manage().window().getSize();
        driver.executeScript("mobile: swipeGesture", Map.of(
                "left", 0,
                "top", size.height / 4,
                "width", size.width,
                "height", size.height / 2,
                "direction", "up",
                "percent", 0.75));
    }

    protected WebElement scrollTo(By locator) {
        for (int i = 0; i < MAX_SWIPES; i++) {
            List<WebElement> found = driver.findElements(locator);
            if (!found.isEmpty() && found.get(0).isDisplayed()) {
                return found.get(0);
            }
            swipeUp();
        }
        throw new NoSuchElementException("Not found after scrolling: " + locator);
    }

    private void type(WebElement field, String text) {
        field.click();
        field.sendKeys(text);
    }

    private void hideKeyboardQuietly() {
        try {
            driver.hideKeyboard();
        } catch (WebDriverException ignored) {
            return;
        }
    }

    private void saveScreenshot(String testName) throws IOException {
        File shot = driver.getScreenshotAs(OutputType.FILE);
        String device = TestConfig.get("device.name").replace(' ', '_');
        Path target = Path.of("screenshots", device + "_" + testName + ".png");
        Files.createDirectories(target.getParent());
        Files.copy(shot.toPath(), target, StandardCopyOption.REPLACE_EXISTING);
    }
}
