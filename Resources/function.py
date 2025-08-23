import appium.webdriver.common.appiumby

def get_mobile_element(driver, locator_strategy, locator_value):
        from appium.webdriver.common.appiumby import AppiumBy
        if locator_strategy == "id":
            return driver.find_element(by=AppiumBy.ID, value=locator_value)
        elif locator_strategy == "xpath":
            return driver.find_element(by=AppiumBy.XPATH, value=locator_value)