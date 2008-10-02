<cfcomponent output="false" extends="mxunit.framework.TestCase">
    <cfscript>


  function testFindElementsByName() {
    driver.get("http://google.com");
    element = driver.findElement("q");
    element.sendKeys("mxunit");
    elements = driver.findElementsByName("q");
    debug(driver.getPageSource());
    debug(elements);

  }


  function dumpDrivers(){
    debug(createObject("java","org.openqa.selenium.htmlunit.HtmlUnitDriver"));

  }



  function makeSureWebDriverCompiles(){}



  function testNewInstance(){
    driver = driver.newInstance("htmlunit");
    debug(driver);
    assertIsTypeOf(driver,"cfwebdriver.WebDriver");
  }


  function testGet() {
   driver = driver.newInstance("htmlunit");
   driver.get("http://google.com");
  }



  function testClose(){
   driver.close();
  }



  function testFindElement(){
    driver.get("http://google.com");
    element = driver.findElement("q");
    assertIsTypeOf(element, "cfwebdriver.WebElement");
    debug(element);
    element.sendKeys("mxunit");
    debug(driver);
    debug("q ==" & element.getText()); //not sure why this is empty ...?
    element.submit();
    debug(driver.getTitle());
    debug(driver.getPageSource());

    assertEquals("mxunit - Google Search", driver.getTitle());
  }


  function testGetCurrentUrl() {
    driver.get("http://google.com");
    element = driver.findElement("q");
    element.sendKeys("mxunit");
    element.submit();
    debug(driver.getCurrentUrl());
    assertEquals("mxunit - google search", driver.getTitle(), "Title tag not right for mxunit search test");
    assertEquals("http://www.google.com/search?hl=en&q=mxunit&btnG=Google+Search",driver.getCurrentUrl() ,"Google URL changed?");
   }


  function testFindElementByLinkText() {
   driver.get(f);
   element = driver.findElementByLinkText("bill");
   assertEquals("bill",element.getText(),"getText() should return a value only if lin text is found. Should fail otherwise");
  }

  function testGetTitle() {
     driver.get(f);
     assertEquals("MXUnit Blog",driver.getTitle());
  }


  function testGetPageSource() {
   driver.get(f);
   assertTrue(len(driver.getPageSource()) > 1000 );
  }

  function testIsJavascriptEnabled(){
    assertFalse(driver.isJavascriptEnabled());
  }


   function testSetJavascriptEnabled(){
    driver.setJavascriptEnabled(true);
    assertTrue(driver.isJavascriptEnabled());
   }


  function testFindElements(){
    driver.get(f);
    driver.findElements("foo");
  }

  function testFindElementsById() {
    driver.get(f);
    elements = driver.findElementsById("navbar-iframe");
    assertEquals(1,arrayLen(elements),"should be just one element returned");
  }


  function testFindElementsByXPath() {
    driver.get(f);
    elements = driver.findElementsByXPath("/html/body");
    //debug(elements[1].getText());
    assertEquals(1,arrayLen(elements),"should be just one element returned");

    elements = driver.findElementsByXPath("/html/head");
    debug(elements[1].getText());

  }


  function testGetVisible() {
    driver.get(f);
    debug("Not sure what driver.visible means ...");
    debug(driver.getVisible());
    assertFalse(driver.getVisible());
  }

   function testSetVisible(){
    driver.get(f);
    driver.setVisible(true);
    debug(driver.getVisible());
    assertTrue(driver.getVisible() , "driver.SetVisible(not working?). Why should it?");
    //driver.setVisible("false");
    //assertFalse(driver.getVisible());
  }

  function testQuit() {
   driver.quit();
  }


  function testNavigate(){
    driver.get(f);
    driver.navigate("http://google.com");
    assertEquals("Google",driver.getTitle());
  }


  function testSwitchTo(){
    fail("to do");
  }

  function testSetProxy(){
    driver.setProxy("comcast.net",80);
  }


  //To Dos ...........................



  function testManage(){
    fail("to do");
  }



  //------------------------

  /*
   @BeforeTest/@AfterTest
  */

    function setUp(){
      driver = createObject("component","cfwebdriver.WebDriver");
      driver = driver.newInstance("htmlunit");
      //This should be done only once, not for each test.
      xml = fileRead(expandPath("/cfwebdriver/test/internal/test-config.xml"));
      dom = xmlParse(xml);
      f1 = xmlSearch(dom,"/config/file[@name='mxunitblog']");
      f = f1[1].xmlAttributes.path;
      
      
    }

    function tearDown(){
      driver.close();
    }

    </cfscript>

</cfcomponent>